module sdcard;

import stm32f4xx;
import crc;

/// Masks for R6 Response
enum SDCheckMask = 0x000001AA;

/// Supported memory cards types
enum SDType : ubyte
{
    UNKNOWN = 0,
    STD_CAPACITY_SD_CARD_V1_0,
    STD_CAPACITY_SD_CARD_V2_0,
    MULTIMEDIA_CARD,
    HIGH_CAPACITY_SD_CARD
}

/// SD commands
enum SDCommand : ubyte
{
    GO_IDLE_STATE = 0,
    SEND_OP_COND = 1,
    HS_SEND_EXT_CSD = 8,  
    SET_BLOCKLEN = 16,
    READ_SINGLE_BLOCK = 17,
    SD_APP_OP_COND = 41,
    APP_CMD = 55,  
    READ_OCR = 58,
    CRC_ON_OFF = 59
}

__gshared SDType CardType;

ubyte init()
{
    RCC.AHB1ENR |= RCC_AHB1Periph_GPIOB;
    RCC.APB1ENR |= RCC_APB1Periph_SPI2;

    GPIOB.MODER |= (2 << (13 * 2)) | (2 << (14 * 2)) | (2 << (15 * 2)); // set pins as AF
    GPIOB.PUPDR |= (1 << (13 * 2)) | (1 << (14 * 2)) | (1 << (15 * 2)); // pull up
    GPIOB.OSPEEDR |= (2 << (13 * 2)) | (2 << (14 * 2)) | (2 << (15 * 2)); // 50mhz

    GPIOB.MODER |= (1 << (12 * 2)); // cs as out

    GPIOB.AFR[1] |= (0x5 << ((13 - 8) * 4));
    GPIOB.AFR[1] |= (0x5 << ((14 - 8) * 4));
    GPIOB.AFR[1] |= (0x5 << ((15 - 8) * 4));

    SPI2.CRCPR = 7;
    SPI2.CR1 |= 0x357;//(1 << 0) | (1 << 2) | (1 << 5) | (1 << 6) | (1 << 8);

    SPI2.CR1 |= 0x40; // enable spi2

    GPIOB.BSRRL = 1 << 12; // deselect sdcard

    return 0;
}

ubyte sendRecv(uint data)
{
    return sendRecv(cast(ubyte) data);
}

ubyte sendRecv(ubyte data)
{
    while ((SPI2.SR.load() & 2) == RESET)
    {
    }

    SPI2.DR = data;

    while ((SPI2.SR.load() & 1) == RESET)
    {
    }

    return cast(ubyte) SPI2.DR.load();
}

ubyte sendCmd(ubyte cmd, uint arg)
{
    ubyte wait, response, crc = 0;

    sendRecv(0xff); // This dummy send necessary for some cards

    // Send: [8b]Command -> [32b]Argument -> [8b]CRC
    sendRecv(cmd | 0x40);
    crc = CRC7(crc, cast(ubyte)(cmd | 0x40));
    sendRecv(arg >> 24);
    crc = CRC7(crc, cast(ubyte)(arg >> 24));
    sendRecv(arg >> 16);
    crc = CRC7(crc, cast(ubyte)(arg >> 16));
    sendRecv(arg >> 8);
    crc = CRC7(crc, cast(ubyte)(arg >> 8));
    sendRecv(arg);
    crc = CRC7(crc, cast(ubyte)(arg));
    sendRecv(crc | 0x01); // Bit 1 always must be set to "1" in CRC

    // Wait for response from SD Card
    wait = 0;
    while ((response = sendRecv(0xff)) == 0xff)
        if (wait++ > 200)
            break;

    return response;
}

ubyte cardInit()
{
    uint wait = 0;
    ubyte response;

    GPIOB.BSRRH = 1 << 12; // pull CS to low

    // Must send at least 74 clock ticks to SD Card
    for (wait = 0; wait < 8; wait++)
        sendRecv(0xff);

    // Software SD Card reset
    wait = 0;
    response = 0x00;
    while (wait < 0x20 && response != 0x01)
    {
        // Wait for SD card enters idle state (R1 response = 0x01)
        response = sendCmd(SDCommand.GO_IDLE_STATE, 0x00);
        wait++;
    }
    if (wait >= 0x20 && response != 0x01)
        return 0xff; // SD card timeout

    // CMD8: SEND_IF_COND. Send this command to verify SD card interface operating condition
    /* Argument: - [31:12]: Reserved (shall be set to '0')
	             - [11:8]: Supply Voltage (VHS) 0x1 (Range: 2.7-3.6 V)
	             - [7:0]: Check Pattern (recommended 0xAA) */

    response = sendCmd(SDCommand.HS_SEND_EXT_CSD, SDCheckMask); // CMD8

    if (response == 0x01)
    {
        // SDv2 or later
        // Read R7 responce
        uint r3 = sendRecv(0xff) << 24;
        r3 |= sendRecv(0xff) << 16;
        r3 |= sendRecv(0xff) << 8;
        r3 |= sendRecv(0xff);

        if ((r3 & 0x01ff) != (SDCheckMask & 0x01ff))
            return 0xfb; // SDv2 pattern mismatch -> unsupported SD card

        // CMD55: Send leading command for ACMD<n> command.
        // CMD41: APP_SEND_OP_COND. For only SDC - initiate initialization process.
        wait = 0;
        response = cast(byte) 0xff;
        while (++wait < 0x2710 && response != 0x00)
        {
            sendCmd(SDCommand.APP_CMD, 0); // CMD55
            response = sendCmd(SDCommand.SD_APP_OP_COND, 0x40000000); // ACMD41: HCS flag set
        }
        if (wait >= 0x2710 || response != 0x00)
            return 0xff; // SD card timeout

        CardType = SDType.STD_CAPACITY_SD_CARD_V2_0; // SDv2;

        // Read OCR register
        response = sendCmd(SDCommand.READ_OCR, 0x00000000); // CMD58
        if (response == 0x00)
        {
            // Get R3 response
            r3 = sendRecv(0xff) << 24;
            r3 |= sendRecv(0xff) << 16;
            r3 |= sendRecv(0xff) << 8;
            r3 |= sendRecv(0xff);
        }
        else
        {
            CardType = SDType.UNKNOWN;
            return 0xfc; // bad CMD58 response
        }
        if (r3 & (1 << 30))
            CardType = SDType.HIGH_CAPACITY_SD_CARD; // SDHC or SDXC
    }
    else
    {
        // SDv1 or MMC
        wait = 0;
        response = 0xff;
        while (++wait < 0xfe)
        {
            sendCmd(SDCommand.APP_CMD, 0); // CMD55
            response = sendCmd(SDCommand.SD_APP_OP_COND, 0x00000000); // CMD41
            if (response == 0x00)
            {
                CardType = SDType.STD_CAPACITY_SD_CARD_V1_0; // SDv1
                break;
            }
        }

        if (response == 0x05 && wait >= 0xfe)
        {
            // MMC or bad card
            // CMD1: Initiate initialization process.
            wait = 0;
            response = 0xff;
            while (++wait < 0xfe)
            {
                response = sendCmd(SDCommand.SEND_OP_COND, 0x00000000); // CMD1
                if (response == 0x00)
                {
                    CardType = SDType.MULTIMEDIA_CARD; // MMC
                    break;
                }
            }
        }
    }

    if (CardType == 0)
        return 0xfe; // Unknown or bad SD/MMC card

    // Set SPI to higher speed
    //SD_SPI_Init(SPI_BaudRatePrescaler_8);

    // Turn off CRC
    response = sendCmd(SDCommand.CRC_ON_OFF, 0x00000001); // CMD59

    // For SDv2,SDv1,MMC must set block size. For SDHC/SDXC it fixed to 512.
    if ((CardType == SDType.STD_CAPACITY_SD_CARD_V1_0)
            || (CardType == SDType.STD_CAPACITY_SD_CARD_V2_0) || (CardType == SDType
                .MULTIMEDIA_CARD))
    {
        response = sendCmd(SDCommand.SET_BLOCKLEN, 0x00000200); // CMD16: block size = 512 bytes
        if (response != 0x00)
            return 0xfd; // Set block size failed
    }

    GPIOB.BSRRL = 1 << 12; // pull CS to high

    return 0;
}

ubyte readBlock(uint addr, ubyte* buff)
{
    //uint wait;
    ubyte response;

    //GPIO_WriteBit(SD_CS_PORT,SD_CS_PIN,Bit_RESET); // pull CS to low
    GPIOB.BSRRH = 1 << 12; // pull CS to low

    //if (CardType != SDType.HIGH_CAPACITY_SD_CARD)
    //    addr <<= 9; // Convert block number to byte offset
    
    response = sendCmd(SDCommand.READ_SINGLE_BLOCK, addr); // CMD17
    if (response != 0)
    {
        // Something wrong happened, fill buffer with zeroes
        //for (int i = 0; i < 512; i++) buff[i] = 0;
        return response; // READ_SINGLE_BLOCK command returns bad response
    }
    else
    {
        uint wait = 0;
        response = 0;
        while (++wait <= 0x1ff && response != 0xfe)
            response = sendRecv(0xff);
        if (wait >= 0x1ff)
            return 0xff;
        // Read 512 bytes of sector
        for (int i = 0; i < 512; i++)
            buff[i] = sendRecv(0xff);
    }

    // Receive 16-bit CRC (some cards demand this)
    ushort recvCRC = sendRecv(0xff) << 8;
    recvCRC |= sendRecv(0xff);

    // // Calculate CRC16 of received buffer
    ushort realCRC = CRC16(buff, 512);

    //GPIO_WriteBit(SD_CS_PORT,SD_CS_PIN,Bit_SET); // pull CS to high
    GPIOB.BSRRL = 1 << 12; // pull CS to high

    return recvCRC == realCRC ? 0 : 255;
}

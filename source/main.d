module main;

import stm32f4xx;
static import lcd;
static import input;
static import delay;
static import synth;
static import uart;
static import sdcard;
static import random;
import fat;
import pong;
static import gfx;

void scanFiles(string path)
{
    FILINFO Finfo = void;
    DIR dirs = void;
    byte i = 0;

    uart.send("List SDCARD:\n");

    if (opendir(&dirs, path.ptr) == FR_OK)
    {
        while ((readdir(&dirs, &Finfo) == FR_OK) && Finfo.fname[0])
        {
            uart.send(cast(string) Finfo.fname);
            uart.send("\n");
            gfx.drawString(cast(char*)&Finfo.fname, cast(ubyte) 0,
                    cast(ubyte)(i * 10), lcd.Color.black);
            i++;
        }
    }

    uart.send("List END\n");
}

extern (C) int main()
{
    delay.init();

	RCC.AHB1ENR |= RCC_AHB1Periph_GPIOD;

	GPIOD.MODER |= 1 << (15 * 2);
	//GPIOD.OSPEEDR |= (0 << (15 * 2));
	//GPIOD.OTYPER |=  (0 << 15)
	GPIOD.PUPDR |= 1 << (15 * 2);

    while (1)
    {
		GPIOD.ODR |= 1 << 15;
        delay.mili(10);
        GPIOD.ODR &= ~(1 << 15);
        delay.mili(25);
    }

    /*lcd.init();
    input.init();
    random.init();
    uart.init();
    synth.init();
    sdcard.init();
    sdcard.cardInit();

    ubyte[512] buffer = void;
    sdcard.readBlock(0, buffer.ptr);

    for (int i = 0; i < 32; i++)
    {
        for (int j = 0; j < 16; j++)
        {
            uart.puthex(buffer[j + i * 16]);
        }
        uart.send("\r\n");
    }

    FATFS fatfs = void;
    mount(&fatfs, "".ptr, 0);
    scanFiles("");

    FIL f = void;
    uint w;

    while (1)
    {
        if (input.getButton(input.Button.up))
        {
            break;
        }
        else if (input.getButton(input.Button.down))
        {
            if (open(&f, "/blink.bin".ptr, FA_OPEN_EXISTING | FA_READ) == FR_OK)
            {
                ubyte* adr = cast(ubyte*) 0x20000000;
                read(&f, cast(void*) 0x20000000, 65_536u, &w);
                uart.send("bytes readed: ");
                uart.puthex(cast(byte) w);
                close(&f);
                for (int i = 0; i < 32; i++)
                {
                    for (int j = 0; j < 10; j++)
                    {
                        uart.puthex(adr[j + i * 16]);
                    }
                    uart.send("\r\n");
                }
                (cast(void function()) 0x20000001)();
                uart.send("hello?");
            }
        }

    }

    Pong pong;
    pong.reset();

    while (1)
    {
        //uint start = delay.ticks.load;
        pong.update();
        //delay.mili(16 - (delay.ticks.load() - start));
        delay.mili(16);
    }*/

    return 0;
}

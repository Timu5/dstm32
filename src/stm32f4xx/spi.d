module stm32f4xx.spi;

import stm32f4xx.core;

/** 
  * @brief Serial Peripheral Interface
  */

struct SPI_TypeDef
{
  __IO!ushort CR1;        /*!< SPI control register 1 (not used in I2S mode),      Address offset: 0x00 */
  ushort      RESERVED0;  /*!< Reserved, 0x02                                                           */
  __IO!ushort CR2;        /*!< SPI control register 2,                             Address offset: 0x04 */
  ushort      RESERVED1;  /*!< Reserved, 0x06                                                           */
  __IO!ushort SR;         /*!< SPI status register,                                Address offset: 0x08 */
  ushort      RESERVED2;  /*!< Reserved, 0x0A                                                           */
  __IO!ushort DR;         /*!< SPI data register,                                  Address offset: 0x0C */
  ushort      RESERVED3;  /*!< Reserved, 0x0E                                                           */
  __IO!ushort CRCPR;      /*!< SPI CRC polynomial register (not used in I2S mode), Address offset: 0x10 */
  ushort      RESERVED4;  /*!< Reserved, 0x12                                                           */
  __IO!ushort RXCRCR;     /*!< SPI RX CRC register (not used in I2S mode),         Address offset: 0x14 */
  ushort      RESERVED5;  /*!< Reserved, 0x16                                                           */
  __IO!ushort TXCRCR;     /*!< SPI TX CRC register (not used in I2S mode),         Address offset: 0x18 */
  ushort      RESERVED6;  /*!< Reserved, 0x1A                                                           */
  __IO!ushort I2SCFGR;    /*!< SPI_I2S configuration register,                     Address offset: 0x1C */
  ushort      RESERVED7;  /*!< Reserved, 0x1E                                                           */
  __IO!ushort I2SPR;      /*!< SPI_I2S prescaler register,                         Address offset: 0x20 */
  ushort      RESERVED8;  /*!< Reserved, 0x22                                                           */
}
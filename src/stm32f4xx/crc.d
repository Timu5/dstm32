module stm32f4xx.crc;

import stm32f4xx.core;

/** 
  * @brief CRC calculation unit 
  */

struct CRC_TypeDef
{
  __IO!uint   DR;         /*!< CRC Data register,             Address offset: 0x00 */
  __IO!ubyte  IDR;        /*!< CRC Independent data register, Address offset: 0x04 */
  ubyte       RESERVED0;  /*!< Reserved, 0x05                                      */
  ushort      RESERVED1;  /*!< Reserved, 0x06                                      */
  __IO!uint   CR;         /*!< CRC Control register,          Address offset: 0x08 */
}
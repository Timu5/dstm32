module stm32f4xx.usart;

import stm32f4xx.core;

/** 
  * @brief Universal Synchronous Asynchronous Receiver Transmitter
  */
 
struct USART_TypeDef
{
  __IO!ushort SR;         /*!< USART Status register,                   Address offset: 0x00 */
  ushort      RESERVED0;  /*!< Reserved, 0x02                                                */
  __IO!ushort DR;         /*!< USART Data register,                     Address offset: 0x04 */
  ushort      RESERVED1;  /*!< Reserved, 0x06                                                */
  __IO!ushort BRR;        /*!< USART Baud rate register,                Address offset: 0x08 */
  ushort      RESERVED2;  /*!< Reserved, 0x0A                                                */
  __IO!ushort CR1;        /*!< USART Control register 1,                Address offset: 0x0C */
  ushort      RESERVED3;  /*!< Reserved, 0x0E                                                */
  __IO!ushort CR2;        /*!< USART Control register 2,                Address offset: 0x10 */
  ushort      RESERVED4;  /*!< Reserved, 0x12                                                */
  __IO!ushort CR3;        /*!< USART Control register 3,                Address offset: 0x14 */
  ushort      RESERVED5;  /*!< Reserved, 0x16                                                */
  __IO!ushort GTPR;       /*!< USART Guard time and prescaler register, Address offset: 0x18 */
  ushort      RESERVED6;  /*!< Reserved, 0x1A                                                */
}
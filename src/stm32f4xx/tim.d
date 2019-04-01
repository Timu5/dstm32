module stm32f4xx.tim;

import stm32f4xx.core;

/** 
  * @brief TIM
  */

struct TIM_TypeDef
{
  __IO!ushort CR1; /*!< TIM control register 1,              Address offset: 0x00 */
  ushort RESERVED0; /*!< Reserved, 0x02                                            */
  __IO!ushort CR2; /*!< TIM control register 2,              Address offset: 0x04 */
  ushort RESERVED1; /*!< Reserved, 0x06                                            */
  __IO!ushort SMCR; /*!< TIM slave mode control register,     Address offset: 0x08 */
  ushort RESERVED2; /*!< Reserved, 0x0A                                            */
  __IO!ushort DIER; /*!< TIM DMA/interrupt enable register,   Address offset: 0x0C */
  ushort RESERVED3; /*!< Reserved, 0x0E                                            */
  __IO!ushort SR; /*!< TIM status register,                 Address offset: 0x10 */
  ushort RESERVED4; /*!< Reserved, 0x12                                            */
  __IO!ushort EGR; /*!< TIM event generation register,       Address offset: 0x14 */
  ushort RESERVED5; /*!< Reserved, 0x16                                            */
  __IO!ushort CCMR1; /*!< TIM capture/compare mode register 1, Address offset: 0x18 */
  ushort RESERVED6; /*!< Reserved, 0x1A                                            */
  __IO!ushort CCMR2; /*!< TIM capture/compare mode register 2, Address offset: 0x1C */
  ushort RESERVED7; /*!< Reserved, 0x1E                                            */
  __IO!ushort CCER; /*!< TIM capture/compare enable register, Address offset: 0x20 */
  ushort RESERVED8; /*!< Reserved, 0x22                                            */
  __IO!uint CNT; /*!< TIM counter register,                Address offset: 0x24 */
  __IO!ushort PSC; /*!< TIM prescaler,                       Address offset: 0x28 */
  ushort RESERVED9; /*!< Reserved, 0x2A                                            */
  __IO!uint ARR; /*!< TIM auto-reload register,            Address offset: 0x2C */
  __IO!ushort RCR; /*!< TIM repetition counter register,     Address offset: 0x30 */
  ushort RESERVED10; /*!< Reserved, 0x32                                            */
  __IO!uint CCR1; /*!< TIM capture/compare register 1,      Address offset: 0x34 */
  __IO!uint CCR2; /*!< TIM capture/compare register 2,      Address offset: 0x38 */
  __IO!uint CCR3; /*!< TIM capture/compare register 3,      Address offset: 0x3C */
  __IO!uint CCR4; /*!< TIM capture/compare register 4,      Address offset: 0x40 */
  __IO!ushort BDTR; /*!< TIM break and dead-time register,    Address offset: 0x44 */
  ushort RESERVED11; /*!< Reserved, 0x46                                            */
  __IO!ushort DCR; /*!< TIM DMA control register,            Address offset: 0x48 */
  ushort RESERVED12; /*!< Reserved, 0x4A                                            */
  __IO!ushort DMAR; /*!< TIM DMA address for full transfer,   Address offset: 0x4C */
  ushort RESERVED13; /*!< Reserved, 0x4E                                            */
  __IO!ushort OR; /*!< TIM option register,                 Address offset: 0x50 */
  ushort RESERVED14; /*!< Reserved, 0x52                                            */
}

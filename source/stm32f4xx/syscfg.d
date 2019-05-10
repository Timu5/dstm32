module stm32f4xx.syscfg;

import stm32f4xx.core;

/** 
  * @brief System configuration controller
  */

struct SYSCFG_TypeDef
{
  __IO!uint MEMRMP; /** SYSCFG memory remap register,                      Address offset: 0x00      */
  __IO!uint PMC; /** SYSCFG peripheral mode configuration register,     Address offset: 0x04      */
  __IO!uint[4] EXTICR; /** SYSCFG external interrupt configuration registers, Address offset: 0x08-0x14 */
  uint[2] RESERVED; /** Reserved, 0x18-0x1C                                                          */
  __IO!uint CMPCR; /** SYSCFG Compensation cell control register,         Address offset: 0x20      */
}

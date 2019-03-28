module stm32f4xx.rng;

import stm32f4xx.core;

/** 
  * @brief RNG
  */
  
struct RNG_TypeDef
{
  __IO!uint CR;  /*!< RNG control register, Address offset: 0x00 */
  __IO!uint SR;  /*!< RNG status register,  Address offset: 0x04 */
  __IO!uint DR;  /*!< RNG data register,    Address offset: 0x08 */
}
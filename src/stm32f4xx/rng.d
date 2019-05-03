module stm32f4xx.rng;

import stm32f4xx.core;

/** 
  * @brief RNG
  */

struct RNG_TypeDef
{
  __IO!uint CR; /** RNG control register, Address offset: 0x00 */
  __IO!uint SR; /** RNG status register,  Address offset: 0x04 */
  __IO!uint DR; /** RNG data register,    Address offset: 0x08 */
}

enum RNG_BASE = AHB2PERIPH_BASE + 0x60800;
enum RNG = cast(RNG_TypeDef *) RNG_BASE;

module stm32f4xx.dac;

import stm32f4xx.core;

/** 
  * @brief Digital to Analog Converter
  */

struct DAC_TypeDef
{
  __IO!uint CR;       /**!< DAC control register,                                    Address offset: 0x00 */
  __IO!uint SWTRIGR;  /**!< DAC software trigger register,                           Address offset: 0x04 */
  __IO!uint DHR12R1;  /**!< DAC channel1 12-bit right-aligned data holding register, Address offset: 0x08 */
  __IO!uint DHR12L1;  /**!< DAC channel1 12-bit left aligned data holding register,  Address offset: 0x0C */
  __IO!uint DHR8R1;   /**!< DAC channel1 8-bit right aligned data holding register,  Address offset: 0x10 */
  __IO!uint DHR12R2;  /**!< DAC channel2 12-bit right aligned data holding register, Address offset: 0x14 */
  __IO!uint DHR12L2;  /**!< DAC channel2 12-bit left aligned data holding register,  Address offset: 0x18 */
  __IO!uint DHR8R2;   /**!< DAC channel2 8-bit right-aligned data holding register,  Address offset: 0x1C */
  __IO!uint DHR12RD;  /**!< Dual DAC 12-bit right-aligned data holding register,     Address offset: 0x20 */
  __IO!uint DHR12LD;  /**!< DUAL DAC 12-bit left aligned data holding register,      Address offset: 0x24 */
  __IO!uint DHR8RD;   /**!< DUAL DAC 8-bit right aligned data holding register,      Address offset: 0x28 */
  __IO!uint DOR1;     /**!< DAC channel1 data output register,                       Address offset: 0x2C */
  __IO!uint DOR2;     /**!< DAC channel2 data output register,                       Address offset: 0x30 */
  __IO!uint SR;       /**!< DAC status register,                                     Address offset: 0x34 */
}

enum DAC_BASE = APB1PERIPH_BASE + 0x7400;
enum DAC = cast(DAC_TypeDef*)DAC_BASE;

enum DAC_Channel_1 = 0x00000000;
enum DAC_Channel_2 = 0x00000010;
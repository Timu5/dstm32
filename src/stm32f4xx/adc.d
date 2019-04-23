module stm32f4xx.adc;

import stm32f4xx.core;

/** 
  * @brief Analog to Digital Converter  
  */

struct ADC_TypeDef
{
  __IO!uint SR;     /*!< ADC status register,                         Address offset: 0x00 */
  __IO!uint CR1;    /*!< ADC control register 1,                      Address offset: 0x04 */      
  __IO!uint CR2;    /*!< ADC control register 2,                      Address offset: 0x08 */
  __IO!uint SMPR1;  /*!< ADC sample time register 1,                  Address offset: 0x0C */
  __IO!uint SMPR2;  /*!< ADC sample time register 2,                  Address offset: 0x10 */
  __IO!uint JOFR1;  /*!< ADC injected channel data offset register 1, Address offset: 0x14 */
  __IO!uint JOFR2;  /*!< ADC injected channel data offset register 2, Address offset: 0x18 */
  __IO!uint JOFR3;  /*!< ADC injected channel data offset register 3, Address offset: 0x1C */
  __IO!uint JOFR4;  /*!< ADC injected channel data offset register 4, Address offset: 0x20 */
  __IO!uint HTR;    /*!< ADC watchdog higher threshold register,      Address offset: 0x24 */
  __IO!uint LTR;    /*!< ADC watchdog lower threshold register,       Address offset: 0x28 */
  __IO!uint SQR1;   /*!< ADC regular sequence register 1,             Address offset: 0x2C */
  __IO!uint SQR2;   /*!< ADC regular sequence register 2,             Address offset: 0x30 */
  __IO!uint SQR3;   /*!< ADC regular sequence register 3,             Address offset: 0x34 */
  __IO!uint JSQR;   /*!< ADC injected sequence register,              Address offset: 0x38*/
  __IO!uint JDR1;   /*!< ADC injected data register 1,                Address offset: 0x3C */
  __IO!uint JDR2;   /*!< ADC injected data register 2,                Address offset: 0x40 */
  __IO!uint JDR3;   /*!< ADC injected data register 3,                Address offset: 0x44 */
  __IO!uint JDR4;   /*!< ADC injected data register 4,                Address offset: 0x48 */
  __IO!uint DR;     /*!< ADC regular data register,                   Address offset: 0x4C */
}

struct ADC_Common_TypeDef
{
  __IO!uint CSR;    /// ADC Common status register,                  Address offset: ADC1 base address + 0x300
  __IO!uint CCR;    /*!< ADC common control register,                 Address offset: ADC1 base address + 0x304 */
  __IO!uint CDR;    /*!< ADC common regular data register for dual
                        AND triple modes,                            Address offset: ADC1 base address + 0x308 */
}
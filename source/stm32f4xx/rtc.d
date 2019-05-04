module stm32f4xx.rtc;

import stm32f4xx.core;

/** 
  * @brief Real-Time Clock
  */

struct RTC_TypeDef
{
  __IO!uint TR; /*!< RTC time register,                                        Address offset: 0x00 */
  __IO!uint DR; /*!< RTC date register,                                        Address offset: 0x04 */
  __IO!uint CR; /*!< RTC control register,                                     Address offset: 0x08 */
  __IO!uint ISR; /*!< RTC initialization and status register,                   Address offset: 0x0C */
  __IO!uint PRER; /*!< RTC prescaler register,                                   Address offset: 0x10 */
  __IO!uint WUTR; /*!< RTC wakeup timer register,                                Address offset: 0x14 */
  __IO!uint CALIBR; /*!< RTC calibration register,                                 Address offset: 0x18 */
  __IO!uint ALRMAR; /*!< RTC alarm A register,                                     Address offset: 0x1C */
  __IO!uint ALRMBR; /*!< RTC alarm B register,                                     Address offset: 0x20 */
  __IO!uint WPR; /*!< RTC write protection register,                            Address offset: 0x24 */
  __IO!uint SSR; /*!< RTC sub second register,                                  Address offset: 0x28 */
  __IO!uint SHIFTR; /*!< RTC shift control register,                               Address offset: 0x2C */
  __IO!uint TSTR; /*!< RTC time stamp time register,                             Address offset: 0x30 */
  __IO!uint TSDR; /*!< RTC time stamp date register,                             Address offset: 0x34 */
  __IO!uint TSSSR; /*!< RTC time-stamp sub second register,                       Address offset: 0x38 */
  __IO!uint CALR; /*!< RTC calibration register,                                 Address offset: 0x3C */
  __IO!uint TAFCR; /*!< RTC tamper and alternate function configuration register, Address offset: 0x40 */
  __IO!uint ALRMASSR; /*!< RTC alarm A sub second register,                          Address offset: 0x44 */
  __IO!uint ALRMBSSR; /*!< RTC alarm B sub second register,                          Address offset: 0x48 */
  uint RESERVED7; /*!< Reserved, 0x4C                                                                 */
  __IO!uint BKP0R; /*!< RTC backup register 1,                                    Address offset: 0x50 */
  __IO!uint BKP1R; /*!< RTC backup register 1,                                    Address offset: 0x54 */
  __IO!uint BKP2R; /*!< RTC backup register 2,                                    Address offset: 0x58 */
  __IO!uint BKP3R; /*!< RTC backup register 3,                                    Address offset: 0x5C */
  __IO!uint BKP4R; /*!< RTC backup register 4,                                    Address offset: 0x60 */
  __IO!uint BKP5R; /*!< RTC backup register 5,                                    Address offset: 0x64 */
  __IO!uint BKP6R; /*!< RTC backup register 6,                                    Address offset: 0x68 */
  __IO!uint BKP7R; /*!< RTC backup register 7,                                    Address offset: 0x6C */
  __IO!uint BKP8R; /*!< RTC backup register 8,                                    Address offset: 0x70 */
  __IO!uint BKP9R; /*!< RTC backup register 9,                                    Address offset: 0x74 */
  __IO!uint BKP10R; /*!< RTC backup register 10,                                   Address offset: 0x78 */
  __IO!uint BKP11R; /*!< RTC backup register 11,                                   Address offset: 0x7C */
  __IO!uint BKP12R; /*!< RTC backup register 12,                                   Address offset: 0x80 */
  __IO!uint BKP13R; /*!< RTC backup register 13,                                   Address offset: 0x84 */
  __IO!uint BKP14R; /*!< RTC backup register 14,                                   Address offset: 0x88 */
  __IO!uint BKP15R; /*!< RTC backup register 15,                                   Address offset: 0x8C */
  __IO!uint BKP16R; /*!< RTC backup register 16,                                   Address offset: 0x90 */
  __IO!uint BKP17R; /*!< RTC backup register 17,                                   Address offset: 0x94 */
  __IO!uint BKP18R; /*!< RTC backup register 18,                                   Address offset: 0x98 */
  __IO!uint BKP19R; /*!< RTC backup register 19,                                   Address offset: 0x9C */
}

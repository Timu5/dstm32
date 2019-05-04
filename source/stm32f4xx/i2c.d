module stm32f4xx.i2c;

import stm32f4xx.core;

/** 
  * @brief Inter-integrated Circuit Interface
  */

struct I2C_TypeDef
{
  __IO!ushort CR1; /*!< I2C Control register 1,     Address offset: 0x00 */
  ushort RESERVED0; /*!< Reserved, 0x02                                   */
  __IO!ushort CR2; /*!< I2C Control register 2,     Address offset: 0x04 */
  ushort RESERVED1; /*!< Reserved, 0x06                                   */
  __IO!ushort OAR1; /*!< I2C Own address register 1, Address offset: 0x08 */
  ushort RESERVED2; /*!< Reserved, 0x0A                                   */
  __IO!ushort OAR2; /*!< I2C Own address register 2, Address offset: 0x0C */
  ushort RESERVED3; /*!< Reserved, 0x0E                                   */
  __IO!ushort DR; /*!< I2C Data register,          Address offset: 0x10 */
  ushort RESERVED4; /*!< Reserved, 0x12                                   */
  __IO!ushort SR1; /*!< I2C Status register 1,      Address offset: 0x14 */
  ushort RESERVED5; /*!< Reserved, 0x16                                   */
  __IO!ushort SR2; /*!< I2C Status register 2,      Address offset: 0x18 */
  ushort RESERVED6; /*!< Reserved, 0x1A                                   */
  __IO!ushort CCR; /*!< I2C Clock control register, Address offset: 0x1C */
  ushort RESERVED7; /*!< Reserved, 0x1E                                   */
  __IO!ushort TRISE; /*!< I2C TRISE register,         Address offset: 0x20 */
  ushort RESERVED8; /*!< Reserved, 0x22                                   */
}

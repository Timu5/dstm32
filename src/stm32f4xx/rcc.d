module stm32f4xx.rcc;

import stm32f4xx.core;

struct RCC_TypeDef
{
    __IO!uint CR; /*!< RCC clock control register,                                  Address offset: 0x00 */
    __IO!uint PLLCFGR; /*!< RCC PLL configuration register,                              Address offset: 0x04 */
    __IO!uint CFGR; /*!< RCC clock configuration register,                            Address offset: 0x08 */
    __IO!uint CIR; /*!< RCC clock interrupt register,                                Address offset: 0x0C */
    __IO!uint AHB1RSTR; /*!< RCC AHB1 peripheral reset register,                          Address offset: 0x10 */
    __IO!uint AHB2RSTR; /*!< RCC AHB2 peripheral reset register,                          Address offset: 0x14 */
    __IO!uint AHB3RSTR; /*!< RCC AHB3 peripheral reset register,                          Address offset: 0x18 */
    __IO!uint RESERVED0; /*!< Reserved, 0x1C                                                                    */
    __IO!uint APB1RSTR; /*!< RCC APB1 peripheral reset register,                          Address offset: 0x20 */
    __IO!uint APB2RSTR; /*!< RCC APB2 peripheral reset register,                          Address offset: 0x24 */
    __IO!uint[2] RESERVED1; /*!< Reserved, 0x28-0x2C                                                               */
    __IO!uint AHB1ENR; /*!< RCC AHB1 peripheral clock register,                          Address offset: 0x30 */
    __IO!uint AHB2ENR; /*!< RCC AHB2 peripheral clock register,                          Address offset: 0x34 */
    __IO!uint AHB3ENR; /*!< RCC AHB3 peripheral clock register,                          Address offset: 0x38 */
    __IO!uint RESERVED2; /*!< Reserved, 0x3C                                                                    */
    __IO!uint APB1ENR; /*!< RCC APB1 peripheral clock enable register,                   Address offset: 0x40 */
    __IO!uint APB2ENR; /*!< RCC APB2 peripheral clock enable register,                   Address offset: 0x44 */
    __IO!uint[2] RESERVED3; /*!< Reserved, 0x48-0x4C                                                               */
    __IO!uint AHB1LPENR; /*!< RCC AHB1 peripheral clock enable in low power mode register, Address offset: 0x50 */
    __IO!uint AHB2LPENR; /*!< RCC AHB2 peripheral clock enable in low power mode register, Address offset: 0x54 */
    __IO!uint AHB3LPENR; /*!< RCC AHB3 peripheral clock enable in low power mode register, Address offset: 0x58 */
    __IO!uint RESERVED4; /*!< Reserved, 0x5C                                                                    */
    __IO!uint APB1LPENR; /*!< RCC APB1 peripheral clock enable in low power mode register, Address offset: 0x60 */
    __IO!uint APB2LPENR; /*!< RCC APB2 peripheral clock enable in low power mode register, Address offset: 0x64 */
    __IO!uint[2] RESERVED5; /*!< Reserved, 0x68-0x6C                                                               */
    __IO!uint BDCR; /*!< RCC Backup domain control register,                          Address offset: 0x70 */
    __IO!uint CSR; /*!< RCC clock control & status register,                         Address offset: 0x74 */
    __IO!uint[2] RESERVED6; /*!< Reserved, 0x78-0x7C                                                               */
    __IO!uint SSCGR; /*!< RCC spread spectrum clock generation register,               Address offset: 0x80 */
    __IO!uint PLLI2SCFGR; /*!< RCC PLLI2S configuration register,                           Address offset: 0x84 */
}

enum RCC_BASE = AHB1PERIPH_BASE + 0x3800;
enum RCC = cast(RCC_TypeDef*) RCC_BASE;

enum RCC_AHB1Periph_GPIOC = 0x4;
enum RCC_AHB1Periph_GPIOD = 0x8;
enum RCC_AHB1Periph_GPIOE = 0x10;

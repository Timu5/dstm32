module stm32f4xx.gpio;

import stm32f4xx.core;

struct GPIO_TypeDef
{
	__IO!uint MODER; /// GPIO port mode register,               Address offset: 0x00
	__IO!uint OTYPER; /*!< GPIO port output type register,        Address offset: 0x04      */
	__IO!uint OSPEEDR; /*!< GPIO port output speed register,       Address offset: 0x08      */
	__IO!uint PUPDR; /*!< GPIO port pull-up/pull-down register,  Address offset: 0x0C      */
	__IO!uint IDR; /*!< GPIO port input data register,         Address offset: 0x10      */
	__IO!uint ODR; /*!< GPIO port output data register,        Address offset: 0x14      */
	__IO!uint BSRRL; /*!< GPIO port bit set/reset low register,  Address offset: 0x18      */
	__IO!uint BSRRH; /*!< GPIO port bit set/reset high register, Address offset: 0x1A      */
	__IO!uint LCKR; /*!< GPIO port configuration lock register, Address offset: 0x1C      */
	__IO!uint[2] AFR; /*!< GPIO alternate function registers,     Address offset: 0x20-0x24 */
}

enum GPIOA_BASE = AHB1PERIPH_BASE + 0x0000;
enum GPIOB_BASE = AHB1PERIPH_BASE + 0x0400;
enum GPIOC_BASE = AHB1PERIPH_BASE + 0x0800;
enum GPIOD_BASE = AHB1PERIPH_BASE + 0x0C00;
enum GPIOE_BASE = AHB1PERIPH_BASE + 0x1000;
enum GPIOF_BASE = AHB1PERIPH_BASE + 0x1400;
enum GPIOG_BASE = AHB1PERIPH_BASE + 0x1800;
enum GPIOH_BASE = AHB1PERIPH_BASE + 0x1C00;
enum GPIOI_BASE = AHB1PERIPH_BASE + 0x2000;

enum GPIOA = cast(GPIO_TypeDef*) GPIOA_BASE;
enum GPIOB = cast(GPIO_TypeDef*) GPIOB_BASE;
enum GPIOC = cast(GPIO_TypeDef*) GPIOC_BASE;
enum GPIOD = cast(GPIO_TypeDef*) GPIOD_BASE;
enum GPIOE = cast(GPIO_TypeDef*) GPIOE_BASE;
enum GPIOF = cast(GPIO_TypeDef*) GPIOF_BASE;
enum GPIOG = cast(GPIO_TypeDef*) GPIOG_BASE;
enum GPIOH = cast(GPIO_TypeDef*) GPIOH_BASE;
enum GPIOI = cast(GPIO_TypeDef*) GPIOI_BASE;

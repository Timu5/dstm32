module stm32f4xx.core;

import stm32f4xx._volatile;

/**
* @brief STM32F4XX Interrupt Number Definition, according to the selected device 
*        in @ref Library_configuration_section 
*/
enum IRQn
{
    /******  Cortex-M4 Processor Exceptions Numbers ****************************************************************/
    NonMaskableInt         = -14,    /*!< 2 Non Maskable Interrupt                                          */
    MemoryManagement       = -12,    /*!< 4 Cortex-M4 Memory Management Interrupt                           */
    BusFault               = -11,    /*!< 5 Cortex-M4 Bus Fault Interrupt                                   */
    UsageFault             = -10,    /*!< 6 Cortex-M4 Usage Fault Interrupt                                 */
    SVCall                 = -5,     /*!< 11 Cortex-M4 SV Call Interrupt                                    */
    DebugMonitor           = -4,     /*!< 12 Cortex-M4 Debug Monitor Interrupt                              */
    PendSV                 = -2,     /*!< 14 Cortex-M4 Pend SV Interrupt                                    */
    SysTick                = -1,     /*!< 15 Cortex-M4 System Tick Interrupt                                */
    /******  STM32 specific Interrupt Numbers **********************************************************************/
    WWDG                   = 0,      /*!< Window WatchDog Interrupt                                         */
    PVD                    = 1,      /*!< PVD through EXTI Line detection Interrupt                         */
    TAMP_STAMP             = 2,      /*!< Tamper and TimeStamp interrupts through the EXTI line             */
    RTC_WKUP               = 3,      /*!< RTC Wakeup interrupt through the EXTI line                        */
    FLASH                  = 4,      /*!< FLASH global Interrupt                                            */
    RCC                    = 5,      /*!< RCC global Interrupt                                              */
    EXTI0                  = 6,      /*!< EXTI Line0 Interrupt                                              */
    EXTI1                  = 7,      /*!< EXTI Line1 Interrupt                                              */
    EXTI2                  = 8,      /*!< EXTI Line2 Interrupt                                              */
    EXTI3                  = 9,      /*!< EXTI Line3 Interrupt                                              */
    EXTI4                  = 10,     /*!< EXTI Line4 Interrupt                                              */
    DMA1_Stream0           = 11,     /*!< DMA1 Stream 0 global Interrupt                                    */
    DMA1_Stream1           = 12,     /*!< DMA1 Stream 1 global Interrupt                                    */
    DMA1_Stream2           = 13,     /*!< DMA1 Stream 2 global Interrupt                                    */
    DMA1_Stream3           = 14,     /*!< DMA1 Stream 3 global Interrupt                                    */
    DMA1_Stream4           = 15,     /*!< DMA1 Stream 4 global Interrupt                                    */
    DMA1_Stream5           = 16,     /*!< DMA1 Stream 5 global Interrupt                                    */
    DMA1_Stream6           = 17,     /*!< DMA1 Stream 6 global Interrupt                                    */
    ADC                    = 18,     /*!< ADC1, ADC2 and ADC3 global Interrupts                             */
    CAN1_TX                = 19,     /*!< CAN1 TX Interrupt                                                 */
    CAN1_RX0               = 20,     /*!< CAN1 RX0 Interrupt                                                */
    CAN1_RX1               = 21,     /*!< CAN1 RX1 Interrupt                                                */
    CAN1_SCE               = 22,     /*!< CAN1 SCE Interrupt                                                */
    EXTI9_5                = 23,     /*!< External Line[9:5] Interrupts                                     */
    TIM1_BRK_TIM9          = 24,     /*!< TIM1 Break interrupt and TIM9 global interrupt                    */
    TIM1_UP_TIM10          = 25,     /*!< TIM1 Update Interrupt and TIM10 global interrupt                  */
    TIM1_TRG_COM_TIM11     = 26,     /*!< TIM1 Trigger and Commutation Interrupt and TIM11 global interrupt */
    TIM1_CC                = 27,     /*!< TIM1 Capture Compare Interrupt                                    */
    TIM2                   = 28,     /*!< TIM2 global Interrupt                                             */
    TIM3                   = 29,     /*!< TIM3 global Interrupt                                             */
    TIM4                   = 30,     /*!< TIM4 global Interrupt                                             */
    I2C1_EV                = 31,     /*!< I2C1 Event Interrupt                                              */
    I2C1_ER                = 32,     /*!< I2C1 Error Interrupt                                              */
    I2C2_EV                = 33,     /*!< I2C2 Event Interrupt                                              */
    I2C2_ER                = 34,     /*!< I2C2 Error Interrupt                                              */  
    SPI1                   = 35,     /*!< SPI1 global Interrupt                                             */
    SPI2                   = 36,     /*!< SPI2 global Interrupt                                             */
    USART1                 = 37,     /*!< USART1 global Interrupt                                           */
    USART2                 = 38,     /*!< USART2 global Interrupt                                           */
    USART3                 = 39,     /*!< USART3 global Interrupt                                           */
    EXTI15_10              = 40,     /*!< External Line[15:10] Interrupts                                   */
    RTC_Alarm              = 41,     /*!< RTC Alarm (A and B) through EXTI Line Interrupt                   */
    OTG_FS_WKUP            = 42,     /*!< USB OTG FS Wakeup through EXTI line interrupt                     */    
    TIM8_BRK_TIM12         = 43,     /*!< TIM8 Break Interrupt and TIM12 global interrupt                   */
    TIM8_UP_TIM13          = 44,     /*!< TIM8 Update Interrupt and TIM13 global interrupt                  */
    TIM8_TRG_COM_TIM14     = 45,     /*!< TIM8 Trigger and Commutation Interrupt and TIM14 global interrupt */
    TIM8_CC                = 46,     /*!< TIM8 Capture Compare Interrupt                                    */
    DMA1_Stream7           = 47,     /*!< DMA1 Stream7 Interrupt                                            */
    FSMC                   = 48,     /*!< FSMC global Interrupt                                             */
    SDIO                   = 49,     /*!< SDIO global Interrupt                                             */
    TIM5                   = 50,     /*!< TIM5 global Interrupt                                             */
    SPI3                   = 51,     /*!< SPI3 global Interrupt                                             */
    UART4                  = 52,     /*!< UART4 global Interrupt                                            */
    UART5                  = 53,     /*!< UART5 global Interrupt                                            */
    TIM6_DAC               = 54,     /*!< TIM6 global and DAC1&2 underrun error  interrupts                 */
    TIM7                   = 55,     /*!< TIM7 global interrupt                                             */
    DMA2_Stream0           = 56,     /*!< DMA2 Stream 0 global Interrupt                                    */
    DMA2_Stream1           = 57,     /*!< DMA2 Stream 1 global Interrupt                                    */
    DMA2_Stream2           = 58,     /*!< DMA2 Stream 2 global Interrupt                                    */
    DMA2_Stream3           = 59,     /*!< DMA2 Stream 3 global Interrupt                                    */
    DMA2_Stream4           = 60,     /*!< DMA2 Stream 4 global Interrupt                                    */
    ETH                    = 61,     /*!< Ethernet global Interrupt                                         */
    ETH_WKUP               = 62,     /*!< Ethernet Wakeup through EXTI line Interrupt                       */
    CAN2_TX                = 63,     /*!< CAN2 TX Interrupt                                                 */
    CAN2_RX0               = 64,     /*!< CAN2 RX0 Interrupt                                                */
    CAN2_RX1               = 65,     /*!< CAN2 RX1 Interrupt                                                */
    CAN2_SCE               = 66,     /*!< CAN2 SCE Interrupt                                                */
    OTG_FS                 = 67,     /*!< USB OTG FS global Interrupt                                       */
    DMA2_Stream5           = 68,     /*!< DMA2 Stream 5 global interrupt                                    */
    DMA2_Stream6           = 69,     /*!< DMA2 Stream 6 global interrupt                                    */
    DMA2_Stream7           = 70,     /*!< DMA2 Stream 7 global interrupt                                    */
    USART6                 = 71,     /*!< USART6 global interrupt                                           */ 
    I2C3_EV                = 72,     /*!< I2C3 event interrupt                                              */
    I2C3_ER                = 73,     /*!< I2C3 error interrupt                                              */
    OTG_HS_EP1_OUT         = 74,     /*!< USB OTG HS End Point 1 Out global interrupt                       */
    OTG_HS_EP1_IN          = 75,     /*!< USB OTG HS End Point 1 In global interrupt                        */
    OTG_HS_WKUP            = 76,     /*!< USB OTG HS Wakeup through EXTI interrupt                          */
    OTG_HS                 = 77,     /*!< USB OTG HS global interrupt                                       */
    DCMI                   = 78,     /*!< DCMI global interrupt                                             */
    CRYP                   = 79,     /*!< CRYP crypto global interrupt                                      */
    HASH_RNG               = 80,      /*!< Hash and Rng global interrupt                                     */
    FPU                    = 81      /*!< FPU global interrupt                                              */
}

alias __IO = Volatile;
alias __I = Volatile;
alias __O = Volatile;

enum 
{
	RESET = 0,
	SET = !RESET
}

enum 
{
	DISABLE = 0,
	ENABLE = !DISABLE
}

enum 
{
	ERROR = 0,
	SUCCESS = !DISABLE
}

/** @addtogroup Peripheral_memory_map
* @{
*/
enum FLASH_BASE            =(0x08000000); /*!< FLASH(up to 1 MB) base address in the alias region                         */
enum CCMDATARAM_BASE       =(0x10000000); /*!< CCM(core coupled memory) data RAM(64 KB) base address in the alias region  */
enum SRAM1_BASE            =(0x20000000); /*!< SRAM1(112 KB) base address in the alias region                             */
enum SRAM2_BASE            =(0x2001C000); /*!< SRAM2(16 KB) base address in the alias region                              */
enum PERIPH_BASE           =(0x40000000); /*!< Peripheral base address in the alias region                                */
enum BKPSRAM_BASE          =(0x40024000); /*!< Backup SRAM(4 KB) base address in the alias region                         */
enum FSMC_R_BASE           =(0xA0000000); /*!< FSMC registers base address                                                */

enum CCMDATARAM_BB_BASE    =(0x12000000); /*!< CCM(core coupled memory) data RAM(64 KB) base address in the bit-band region  */
enum SRAM1_BB_BASE         =(0x22000000); /*!< SRAM1(112 KB) base address in the bit-band region                             */
enum SRAM2_BB_BASE         =(0x2201C000); /*!< SRAM2(16 KB) base address in the bit-band region                              */
enum PERIPH_BB_BASE        =(0x42000000); /*!< Peripheral base address in the bit-band region                                */
enum BKPSRAM_BB_BASE       =(0x42024000); /*!< Backup SRAM(4 KB) base address in the bit-band region                         */

/* Legacy defines */
enum SRAM_BASE             =SRAM1_BASE;
enum SRAM_BB_BASE          =SRAM1_BB_BASE;


/*!< Peripheral memory map */
enum APB1PERIPH_BASE       =PERIPH_BASE;
enum APB2PERIPH_BASE       =(PERIPH_BASE + 0x00010000);
enum AHB1PERIPH_BASE       =(PERIPH_BASE + 0x00020000);
enum AHB2PERIPH_BASE       =(PERIPH_BASE + 0x10000000);


/** \brief  Structure type to access the Nested Vectored Interrupt Controller (NVIC).
*/
struct NVIC_Type
{
    __IO!uint[8]  ISER;                 /*!< Offset: 0x000 (R/W)  Interrupt Set Enable Register           */
    uint[24]  RESERVED0;
    __IO!uint[8]  ICER;                 /*!< Offset: 0x080 (R/W)  Interrupt Clear Enable Register         */
    uint[24]  RSERVED1;
    __IO!uint[8]  ISPR;                 /*!< Offset: 0x100 (R/W)  Interrupt Set Pending Register          */
    uint[24]  RESERVED2;
    __IO!uint[8]  ICPR;                 /*!< Offset: 0x180 (R/W)  Interrupt Clear Pending Register        */
    uint[24]  RESERVED3;
    __IO!uint[8]  IABR;                 /*!< Offset: 0x200 (R/W)  Interrupt Active bit Register           */
    uint[56]  RESERVED4;
    __IO!ubyte[240] IP;                 /*!< Offset: 0x300 (R/W)  Interrupt Priority Register (8Bit wide) */
    uint[644] RESERVED5;
    __O!uint  STIR;                    /*!< Offset: 0xE00 ( /W)  Software Trigger Interrupt Register     */

    pragma(inline, true) void SetPriority()(IRQn IRQn, uint priority)
    {
        if(IRQn < 0)
        {
            volatileStore1(cast(ubyte*)&SCB.SHP[(cast(uint)(IRQn) & 0xF)-4], cast(byte)((priority << (8 - __NVIC_PRIO_BITS)) & 0xff));  /* set Priority for Cortex-M  System Interrupts */
        }
        else
        {      
            volatileStore1(cast(ubyte*)(&NVIC.IP[cast(uint)(IRQn)]),  cast(ubyte)((priority << (8 - __NVIC_PRIO_BITS)) & 0xff)); /* set Priority for device specific Interrupts  */
        }
    }
}

/* Software Triggered Interrupt Register Definitions */
enum NVIC_STIR_INTID_Pos                 =0;                                          /*!< STIR: INTLINESNUM Position */
enum NVIC_STIR_INTID_Msk              =(0x1FF << NVIC_STIR_INTID_Pos);           /*!< STIR: INTLINESNUM Mask */

enum __NVIC_PRIO_BITS = 4;


/** \brief  Structure type to access the System Control Block (SCB).
*/
struct SCB_Type
{
    __I! uint CPUID;                   /*!< Offset: 0x000 (R/ )  CPUID Base Register                                   */
    __IO!uint ICSR;                    /*!< Offset: 0x004 (R/W)  Interrupt Control and State Register                  */
    __IO!uint VTOR;                    /*!< Offset: 0x008 (R/W)  Vector Table Offset Register                          */
    __IO!uint AIRCR;                   /*!< Offset: 0x00C (R/W)  Application Interrupt and Reset Control Register      */
    __IO!uint SCR;                     /*!< Offset: 0x010 (R/W)  System Control Register                               */
    __IO!uint CCR;                     /*!< Offset: 0x014 (R/W)  Configuration Control Register                        */
    __IO!ubyte[12]  SHP;                 /*!< Offset: 0x018 (R/W)  System Handlers Priority Registers (4-7, 8-11, 12-15) */
    __IO!uint SHCSR;                   /*!< Offset: 0x024 (R/W)  System Handler Control and State Register             */
    __IO!uint CFSR;                    /*!< Offset: 0x028 (R/W)  Configurable Fault Status Register                    */
    __IO!uint HFSR;                    /*!< Offset: 0x02C (R/W)  HardFault Status Register                             */
    __IO!uint DFSR;                    /*!< Offset: 0x030 (R/W)  Debug Fault Status Register                           */
    __IO!uint MMFAR;                   /*!< Offset: 0x034 (R/W)  MemManage Fault Address Register                      */
    __IO!uint BFAR;                    /*!< Offset: 0x038 (R/W)  BusFault Address Register                             */
    __IO!uint AFSR;                    /*!< Offset: 0x03C (R/W)  Auxiliary Fault Status Register                       */
    __I! uint[2] PFR;                  /*!< Offset: 0x040 (R/ )  Processor Feature Register                            */
    __I! uint DFR;                     /*!< Offset: 0x048 (R/ )  Debug Feature Register                                */
    __I! uint ADR;                     /*!< Offset: 0x04C (R/ )  Auxiliary Feature Register                            */
    __I! uint[4] MMFR;                 /*!< Offset: 0x050 (R/ )  Memory Model Feature Register                         */
    __I! uint[5] ISAR;                 /*!< Offset: 0x060 (R/ )  Instruction Set Attributes Register                   */
    uint[5] RESERVED0;
    __IO!uint CPACR;                   /*!< Offset: 0x088 (R/W)  Coprocessor Access Control Register                   */
}


/** \brief  Structure type to access the System Timer (SysTick).
*/
struct SysTick_Type
{
    __IO!uint CTRL;                    /*!< Offset: 0x000 (R/W)  SysTick Control and Status Register */
    __IO!uint LOAD;                    /*!< Offset: 0x004 (R/W)  SysTick Reload Value Register       */
    __IO!uint VAL;                     /*!< Offset: 0x008 (R/W)  SysTick Current Value Register      */
    __I!uint  CALIB;                   /*!< Offset: 0x00C (R/ )  SysTick Calibration Register        */

    pragma(inline, true) void Config()(uint ticks)
    {
        SysTick.LOAD  = (ticks & SysTick_LOAD_RELOAD_Msk) - 1;
        NVIC.SetPriority(IRQn.SysTick, (1<<__NVIC_PRIO_BITS) - 1);  /* set Priority for Cortex-M0 System Interrupts */
        SysTick.VAL   = 0;                                          /* Load the SysTick Counter Value */
        SysTick.CTRL  = (1 << 2) | (1 << 1) | (1 << 0);            /* Enable SysTick IRQ and SysTick Timer */
    }
}

enum SysTick_LOAD_RELOAD_Pos = 0;
enum SysTick_LOAD_RELOAD_Msk = (0xFFFFFF << SysTick_LOAD_RELOAD_Pos);

enum SCS_BASE            =(0xE000E000);                            /*!< System Control Space Base Address  */
enum SysTick_BASE        =(SCS_BASE +  0x0010);                    /*!< SysTick Base Address               */
enum NVIC_BASE           =(SCS_BASE +  0x0100);                    /*!< NVIC Base Address                  */
enum SCB_BASE            =(SCS_BASE +  0x0D00);                    /*!< NVIC Base Address                  */

enum SCB                 =(cast(SCB_Type*) SCB_BASE);
enum SysTick             =(cast(SysTick_Type   *)     SysTick_BASE  );   /*!< SysTick configuration struct       */
enum NVIC                =(cast(NVIC_Type      *)     NVIC_BASE     );   /*!< NVIC configuration struct          */

extern (C) extern __gshared uint SystemCoreClock;

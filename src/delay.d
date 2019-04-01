module delay;

import stm32f4xx;

/// Number of miliseconds since timer initialization
__gshared __IO!uint ticks;

extern (C) void SysTick_Handler()
{
    ticks += 1;
}

/// Initialize delay timer using SysTick as source of interrupts
void init()
{
    ticks = 0;
    SysTick.Config(SystemCoreClock / 1000);
}

/// Wait for given number of miliseconds
void mili(uint time)
{
    immutable uint end = ticks.load() + time;
    while (ticks < end)
    {
    }
}

module delay;

import stm32f4xx;

__gshared __IO!uint ticks;

extern(C) void SysTick_Handler()
{
    ticks += 1;
}

void init()
{
	ticks = 0;
	SysTick.Config(SystemCoreClock / 1000);
}

void mili(uint time)
{
	uint end = ticks.load() + time;
	while(ticks < end) {}
}
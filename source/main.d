module main;

import stm32f4xx;
static import lcd;
static import delay;
static import synth;
import pong;

uint random(uint* seed)
{
    if (*seed == 0)
        *seed = 0xF1F2F3F4;
    *seed = 16_807 * (*seed % 127_773) - 2836 * (*seed / 127_773);
    return *seed;
}

extern (C) int main()
{
    delay.init();
    lcd.init();

    Pong pong;
    pong.reset();
    synth.init();

    while (1)
    {
        pong.update();
        delay.mili(15);
    }

    return 0;
}

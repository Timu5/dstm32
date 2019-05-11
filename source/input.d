module input;

import stm32f4xx;

enum Button
{
    up = 0,
    down,
    left,
    right
}

void init()
{
    RCC.AHB1ENR |= RCC_AHB1Periph_GPIOD; // power up gpiod
    GPIOD.PUPDR |= (1 << (0 * 2)) | (1 << (1 * 2)) | (1 << (1 * 3)) | (1 << (1 * 4)); // enable pull up
}

bool getButton(Button button)
{
    return (GPIOD.IDR.load() & (1 << button)) != 0;
}

module input;

import stm32f4xx;

enum Button
{
    up = 0,
    down = 1,
    left = 2,
    right = 3
}

void init()
{
    RCC.AHB1ENR |= RCC_AHB1Periph_GPIOD; // power up gpiod
    GPIOD.PUPDR |= (1 << (0 * 2)) | (1 << (1 * 2)) | (1 << (3 * 2)) | (1 << (4 * 2)); // enable pull up
}

bool getButton(Button button)
{
    return (GPIOD.IDR.load() & (1 << button)) == 0;
}

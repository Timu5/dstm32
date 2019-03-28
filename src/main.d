module main;

import stm32f4xx;
static import lcd;
static import delay;

extern(C) int main()
{
    delay.init();
    lcd.init();
	
    RCC.AHB1ENR |= RCC_AHB1Periph_GPIOD;

    GPIOD.MODER |= 1 << (15 * 2); // Mode out
    //GPIOD.OSPEEDR |= (0 << (15 * 2)); // 2MHz
    //GPIOD.OTYPER |=  (0 << 15); // OType pp
    GPIOD.PUPDR |= 1 << (15 * 2); // PuPd UP
   
    while (1)
    {
        GPIOD.ODR ^= 1 << 15;// toggle pin 15 from port gpiod
        delay.mili(500);
    }

    return 0;
}
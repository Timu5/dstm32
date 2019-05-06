module uart;

import stm32f4xx;

/// Initlize USART on port A with speed of 115200
void init()
{
    RCC.AHB1ENR |= RCC_AHB1Periph_GPIOA;
    RCC.APB1ENR |= RCC_APB1Periph_USART2;

    GPIOA.MODER |= (2 << (2 * 2)) | (2 << (3 * 2)); // set pins as AF
    GPIOA.PUPDR |= (1 << (2 * 2)) | (1 << (3 * 2)); // pull up
    GPIOA.OSPEEDR |= (2 << (2 * 2)) | (2 << (3 * 2)); // 50mhz speed

    GPIOA.AFR[0] |= (7 << (2 * 4)) | (7 << (3 * 4));

    USART2.CR1 |= USART_Mode_Rx |  USART_Mode_Tx;

    USART2.BRR = (SystemCoreClock / 115_200) >> 2;

	USART2.CR1 |= 0x2000; // enable usart
}

/// Send single byte to usart
void send(ubyte b)
{
    while(!(USART2.SR.load() & 0x40))
    {
    }
    USART2.DR = b;
}

/// Send string to usart
void send(string str)
{
    for(int i = 0; i < str.length; i++)
    {
        send(str[i]);
    }
}

/// Receive single byte
ubyte recv()
{
    while(!(USART2.SR.load() & 0x20))
    {
    }
    return cast(ubyte) (USART2.DR.load() & 0xFF);
}

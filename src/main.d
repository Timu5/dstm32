module main;

import stm32f4xx;
static import lcd;
static import delay;


void send_command(int command, void* message)
{
	import ldc.llvmasm;

    __asm
    (
      "mov r0, $0;
      mov r1, $1;
      bkpt #0xAB",
      "r,r,~{r0},~{r1}",
      command, message
    );
}

void debug_print(string str)
{
	uint[3] message = [2, cast(uint)str.ptr, str.length];
	send_command(0x05, &message);
}

extern(C) int main()
{
	delay.init();
	//lcd.init();
    //RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOD, ENABLE);
	RCC.AHB1ENR |= RCC_AHB1Periph_GPIOD;

	/*GPIO_InitTypeDef GPIO_InitStruct; 
	GPIO_InitStruct.GPIO_Pin = GPIO_Pin_15;
	GPIO_InitStruct.GPIO_Mode = GPIO_Mode_OUT;
	GPIO_InitStruct.GPIO_Speed = GPIO_Speed_2MHz;
	GPIO_InitStruct.GPIO_OType = GPIO_OType_PP;
	GPIO_InitStruct.GPIO_PuPd = GPIO_PuPd_UP;

	GPIO_Init(GPIOD, &GPIO_InitStruct)*/

	GPIOD.MODER |= 1 << (15 * 2);
	//GPIOD.OSPEEDR |= (0 << (15 * 2));
	//GPIOD.OTYPER |=  (0 << 15)
	GPIOD.PUPDR |= 1 << (15 * 2);
	
	//debug_print("Hello World!\r\n");

    while (1)
    {
		//GPIO_ToggleBits(GPIOD, GPIO_Pin_15);
		GPIOD.ODR ^= 1 << 15;//GPIO_Pin_15;
		//GPIOD.ODR ^= 1 << 14;//GPIO_Pin_15;
        //delay();
		delay.mili(500);
    }

	return 0;
}
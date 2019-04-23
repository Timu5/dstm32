module synth;

import stm32f4xx;

const ubyte[8] pulse = [0,0,32,32,32,32,0,0];
const ubyte[8] triangle = [1,5, 12, 32, 32, 12, 5, 1];

__gshared uint[3] freq = [0,0,440*2048/1000];

__gshared __IO!uint sampleCounter;

extern(C) void TIM2_IRQHandler()
{
    // Checks whether the TIM2 interrupt has occurred or not
    if (!(TIM2.SR.load() & 1) && !(TIM2.DIER.load() & 1))
    {
        int sample = 0;

        if (freq[0] != 0)
            sample += pulse[((sampleCounter.load() * freq[0]) / 2048) % 8];

        if (freq[1] != 0)
            sample += pulse[((sampleCounter.load() * freq[1]) / 2048) % 8];

        if (freq[2] != 0)
            sample += triangle[((sampleCounter.load() * freq[2]) / 2048) % 8];

        sample *= 32;

        DAC.DHR12R2 = sample > 4056 ? 4056 : sample;
        sampleCounter += 1; 

        // Clears the TIM2 interrupt pending bit
        //TIM_ClearITPendingBit(TIM2, TIM_IT_Update);
        TIM2.SR = 1;
    }
}

void init()
{
    //sampleCounter = 0;
    RCC.AHB1ENR |= RCC_AHB1Periph_GPIOA;
    RCC.APB1ENR |= RCC_APB1Periph_DAC;
    RCC.APB1ENR |= RCC_APB1Periph_TIM2;

    GPIOA.MODER |= (11 << (4 * 2)) | (11 << (5 * 2)); // set pins as analogs

    RCC.APB1RSTR |= RCC_APB1Periph_DAC; // reset dac
    RCC.APB1RSTR &= RCC_APB1Periph_DAC;

    DAC.CR |= 1 << DAC_Channel_2; // enable dac

    TIM2.ARR = 249;
    TIM2.PSC = 41;
    TIM2.EGR = 1; // reload
    TIM2.DIER |= 1; // enable interrupt
    TIM2.CR1 |= 1; // eanble TIM2

    NVIC.enable(IRQn.TIM2, 0, 0);
}
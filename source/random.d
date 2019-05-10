module random;

import stm32f4xx;

/// Seed for random() function, it's initlize to real random value by hardware
__gshared uint seed;

void init()
{
    RCC.AHB2ENR |= RCC_AHB2Periph_RNG; // Enable power to RNG
}

/// Lehmer pseudorandom number generator
uint random()
{
    if (seed == 0)
        seed = rrandom();
    seed = 16_807 * (seed % 127_773) - 2836 * (seed / 127_773);
    return seed;
}

/// Hardware random generator
uint rrandom()
{
    RNG.CR |= (1 << 2); // enable random generator

    while (RNG.SR.load() & 1)
    {
        // wait for random number to generate
    }

    immutable uint result = RNG.DR.load();

    RNG.CR &= ~(1 << 2); // disable random generator

    return result;
}

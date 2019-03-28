module lcd;

import stm32f4xx;
import delay;

enum Width = 320;
enum Height = 480;

enum Color
{
    white = 0xFFFF,
    black = 0x0000
    // TODO
}

enum Orientation
{
    portrait, 
    landscape,
    reverse_portrait,
    reverse_landscape
}

void init()
{
    //RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOE | RCC_AHB1Periph_GPIOC, ENABLE);
    RCC.AHB1ENR |= RCC_AHB1Periph_GPIOE | RCC_AHB1Periph_GPIOC;
    
    /*GPIO_InitTypeDef  GPIO_InitStructure;
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10 | GPIO_Pin_7 | GPIO_Pin_8 | GPIO_Pin_9;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
    GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
    GPIO_Init(GPIOC, &GPIO_InitStructure);*/

    /*GPIO_InitStructure.GPIO_Pin = GPIO_Pin_All;
    GPIO_Init(GPIOE, &GPIO_InitStructure);*/
    
    GPIOC.MODER |= (1 << (7 * 2)) | (1 << (8 * 2)) | (1 << (9 * 2)) | (1 << (10 * 2));
    //GPIOC.OSPEEDR |= (0 << (15 * 2));
    //GPIOC.OTYPER |=  (0 << 15)
    GPIOC.PUPDR |= (1 << (7 * 2)) | (1 << (8 * 2)) | (1 << (9 * 2)) | (1 << (10 * 2));
    
    GPIOE.MODER = 0xffff;// 0b1111111111111111;// (1 << (7 * 2)) | (1 << (8 * 2)) | (1 << (9 * 2)) | (1 << (10 * 2));
    //GPIOD.OSPEEDR |= (0 << (15 * 2));
    //GPIOD.OTYPER |=  (0 << 15)
    GPIOE.PUPDR = 0x55555555;//0b01010101010101010101010101010101;// (1 << (7 * 2)) | (1 << (8 * 2)) | (1 << (9 * 2)) | (1 << (10 * 2));
    
    reset();

    set_reg(0XF1);
    set_data(0x36);
    set_data(0x04);
    set_data(0x00);
    set_data(0x3C);
    set_data(0X0F);
    set_data(0x8F);

    set_reg(0XF2);
    set_data(0x18);
    set_data(0xA3);
    set_data(0x12);
    set_data(0x02);
    set_data(0XB2);
    set_data(0x12);
    set_data(0xFF);
    set_data(0x10);
    set_data(0x00);

    set_reg(0XF8);
    set_data(0x21);
    set_data(0x04);

    set_reg(0XF9);
    set_data(0x00);
    set_data(0x08);

    set_reg(0x36);
    set_data(0x08); // set memorty access

    //set_reg(0xB4);
    //set_data(0x00);

    set_reg(0xC1);
    set_data(0x41); // set power control 2

    set_reg(0xC5);
    set_data(0x00);
    set_data(0x91); // VCOM voltage
    set_data(0x80);
    set_data(0x00);

    set_reg(0xE0); // set gamma
    set_data(0x0F);
    set_data(0x1F);
    set_data(0x1C);
    set_data(0x0C);
    set_data(0x0F);
    set_data(0x08);
    set_data(0x48);
    set_data(0x98);
    set_data(0x37);
    set_data(0x0A);
    set_data(0x13);
    set_data(0x04);
    set_data(0x11);
    set_data(0x0D);
    set_data(0x00);

    set_reg(0xE1); // set negative gamma
    set_data(0x0F);
    set_data(0x32);
    set_data(0x2E);
    set_data(0x0B);
    set_data(0x0D);
    set_data(0x05);
    set_data(0x47);
    set_data(0x75);
    set_data(0x37);
    set_data(0x06);
    set_data(0x10);
    set_data(0x03);
    set_data(0x24);
    set_data(0x20);
    set_data(0x00);

    set_reg(0x3A);
    set_data(0x55); // set 16bits / piexel

    set_reg(0x11); // load default registers

    set_reg(0x36);
    set_data(0x28); // set memorty access

    delay.mili(120);

    set_reg(0x29); // display on

    set_orientation(Orientation.portrait);
    clear(Color.white);
}

void reset()
{
    GPIOC.ODR &= ~(1 << 10); // clear RST
    delay.mili(100);
    GPIOC.ODR |= 1 << 10; // set RST
    delay.mili(50);
}

void write(ushort data)
{
    GPIOC.ODR &= ~(1 << 9); // clear CS 
    GPIOE.ODR = data;
    GPIOC.ODR &= ~(1 << 7); // clear WR 
    GPIOC.ODR |= 1 << 7;    // set WR 
    GPIOC.ODR |= 1 << 9;    // set CS 
}

void set_reg(ushort data)
{
    GPIOC.ODR &= ~(1 << 10); // clear RS
    write(data);
}

void set_data(ushort data)
{
    GPIOC.ODR = 1 << 10; // set RS
    write(data);
}

void write_reg(ushort reg, ushort data)
{
    set_reg(reg);
    set_data(data);
}

void draw_pixel(ushort x, ushort y, ushort color)
{
    set_cursor(x, y);
    set_data(color);
}

void clear(ushort Color)
{
    set_window(0, 0, Width - 1, Height - 1);
    GPIOC.ODR = 1 << 10; // set RS
    for (uint i = 0; i < Width * Height; i++)
    {
        write(Color);
    }
}

void set_window(ushort x0, ushort y0, ushort x1, ushort y1)
{
    //set_reg(lcddev.setxcmd);
    set_reg(0x2A);
    set_data(x0 >> 8);
    set_data(x0);
    set_data(x1 >> 8);
    set_data(x1);

    //set_reg(lcddev.setycmd);
    set_reg(0x2B);
    set_data(y0 >> 8);
    set_data(y0);
    set_data(y1 >> 8);
    set_data(y1);

    //set_reg(lcddev.wramcmd);
    set_reg(0x2C);
}

void set_cursor(ushort x, ushort y)
{
    set_window(x, y, x, y);
}

void set_orientation(Orientation orientation)
{
    //lcddev.setxcmd = 0x2A;
    //lcddev.setycmd = 0x2B;
    //lcddev.wramcmd = 0x2C;

    switch (orientation)
    {
    case Orientation.portrait:
        write_reg(0x36, (1 << 6) | (1 << 3));//0 degree MY=0,MX=0,MV=0,ML=0,BGR=1,MH=0
        break;
    case Orientation.landscape:
        write_reg(0x36, (1 << 3) | (1 << 4) | (1 << 5));//90 degree MY=0,MX=1,MV=1,ML=1,BGR=1,MH=0
        break;
    case Orientation.reverse_portrait:
        write_reg(0x36, (1 << 3) | (1 << 7));//180 degree MY=1,MX=1,MV=0,ML=0,BGR=1,MH=0
        break;
    case Orientation.reverse_landscape:
        write_reg(0x36, (1 << 3) | (1 << 5) | (1 << 6) | (1 << 7));//270 degree MY=1,MX=0,MV=1,ML=0,BGR=1,MH=0
        break;
    default:
        break;
    }
}

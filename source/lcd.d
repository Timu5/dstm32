module lcd;

import stm32f4xx;
static import delay;

enum width = 320; /// Width in pixels of LCD screen
enum height = 480; /// Height in pixels of LCD screen

/// Enum representing 16bits colors
enum Color
{
    white = 0xFFFF,
    black = 0x0000 // TODO
}

/// LCD display orientation
enum Orientation
{
    portrait,
    landscape,
    reverse_portrait,
    reverse_landscape
}

/// This function is setting up hardware for LCD control and initilize LCD module itself 
void init()
{
    RCC.AHB1ENR |= RCC_AHB1Periph_GPIOE | RCC_AHB1Periph_GPIOC; // Enable power to GPIOE and GPIOC

    GPIOC.MODER |= (1 << (7 * 2)) | (1 << (8 * 2)) | (1 << (9 * 2)) | (1 << (10 * 2)); // pins 7,8,9,10 as output
    GPIOC.PUPDR |= (1 << (7 * 2)) | (1 << (8 * 2)) | (1 << (9 * 2)) | (1 << (10 * 2)); // pull up

    GPIOE.MODER = 0x55555555; // all pins as output
    GPIOE.PUPDR = 0x55555555; // pull up

    reset();

    //6
    set_reg(0XF1);
    set_data(0x36);
    set_data(0x04);
    set_data(0x00);
    set_data(0x3C);
    set_data(0X0F);
    set_data(0x8F);

    //9
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

    //2
    set_reg(0XF8);
    set_data(0x21);
    set_data(0x04);

    //2
    set_reg(0XF9);
    set_data(0x00);
    set_data(0x08);

    //1
    set_reg(0x36);
    set_data(0x08); // set memorty access

    //set_reg(0xB4);
    //set_data(0x00);

    //1
    set_reg(0xC1);
    set_data(0x41); // set power control 2

    //4
    set_reg(0xC5);
    set_data(0x00);
    set_data(0x91); // VCOM voltage
    set_data(0x80);
    set_data(0x00);

    //15
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

    //15
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

    //1
    set_reg(0x3A);
    set_data(0x55); // set 16bits / piexel

    //0
    set_reg(0x11); // load default registers

    //1
    set_reg(0x36);
    set_data(0x28); // set memorty access

    delay.mili(120);

    //0
    set_reg(0x29); // display on

    set_orientation(Orientation.portrait);
    clear(Color.white);
}

/// Force reset LCD module
void reset()
{
    GPIOC.ODR &= ~(1 << 10); // clear RST
    delay.mili(100);
    GPIOC.ODR |= 1 << 10; // set RST
    delay.mili(50);
}

/// Write data to LCD databus
void write(ushort data)
{
    GPIOC.ODR &= ~(1 << 9); // clear CS 
    GPIOE.ODR = data;
    GPIOC.ODR &= ~(1 << 7); // clear WR 
    GPIOC.ODR |= 1 << 7; // set WR 
    GPIOC.ODR |= 1 << 9; // set CS 
}

/// Set LCD register
void set_reg(ushort data)
{
    GPIOC.ODR &= ~(1 << 8); // clear RS
    write(data);
}

/// Set LCD data
void set_data(ushort data)
{
    GPIOC.ODR |= 1 << 8; // set RS
    write(data);
}

/// Write data to LCD register
void write_reg(ushort reg, ushort data)
{
    set_reg(reg);
    set_data(data);
}

/// Draw single pixel into LCD buffer
void draw_pixel(ushort x, ushort y, ushort color)
{
    set_cursor(x, y);
    set_data(color);
}

/// Fill rectangle area with given color
void fill_rect(ushort x, ushort y, ushort w, ushort h, ushort color)
{
    set_window(x, y, cast(ushort)(x + w - 1), cast(ushort)(y + h - 1));
    GPIOC.ODR |= 1 << 8; // set RS
    for (uint i = 0; i < w * h; i++)
    {
        write(color);
    }
}

/// Clear LCD to given color
void clear(ushort color)
{
    fill_rect(0, 0, width, height, color);
}

/// Set drawing window
void set_window(ushort x0, ushort y0, ushort x1, ushort y1)
{
    set_reg(0x2A);
    set_data(x0 >> 8);
    set_data(x0 & 0xff);
    set_data(x1 >> 8);
    set_data(x1 & 0xff);

    set_reg(0x2B);
    set_data(y0 >> 8);
    set_data(y0 & 0xff);
    set_data(y1 >> 8);
    set_data(y1 & 0xff);

    set_reg(0x2C);
}

// Set drawing cursor. Cursor is nothing else than drawing window with 1x1 size
void set_cursor(ushort x, ushort y)
{
    set_window(x, y, x, y);
}

// Set LCD orientation
void set_orientation(Orientation orientation)
{
    switch (orientation)
    {
    case Orientation.portrait:
        write_reg(0x36, (1 << 6) | (1 << 3)); //0 degree MY=0,MX=0,MV=0,ML=0,BGR=1,MH=0
        break;
    case Orientation.landscape:
        write_reg(0x36, (1 << 3) | (1 << 4) | (1 << 5)); //90 degree MY=0,MX=1,MV=1,ML=1,BGR=1,MH=0
        break;
    case Orientation.reverse_portrait:
        write_reg(0x36, (1 << 3) | (1 << 7)); //180 degree MY=1,MX=1,MV=0,ML=0,BGR=1,MH=0
        break;
    case Orientation.reverse_landscape:
        write_reg(0x36, (1 << 3) | (1 << 5) | (1 << 6) | (1 << 7)); //270 degree MY=1,MX=0,MV=1,ML=0,BGR=1,MH=0
        break;
    default:
        break;
    }
}
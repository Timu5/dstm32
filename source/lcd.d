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
    setReg(0XF1);
    setData(0x36);
    setData(0x04);
    setData(0x00);
    setData(0x3C);
    setData(0X0F);
    setData(0x8F);

    //9
    setReg(0XF2);
    setData(0x18);
    setData(0xA3);
    setData(0x12);
    setData(0x02);
    setData(0XB2);
    setData(0x12);
    setData(0xFF);
    setData(0x10);
    setData(0x00);

    //2
    setReg(0XF8);
    setData(0x21);
    setData(0x04);

    //2
    setReg(0XF9);
    setData(0x00);
    setData(0x08);

    //1
    setReg(0x36);
    setData(0x08); // set memorty access

    //setReg(0xB4);
    //setData(0x00);

    //1
    setReg(0xC1);
    setData(0x41); // set power control 2

    //4
    setReg(0xC5);
    setData(0x00);
    setData(0x91); // VCOM voltage
    setData(0x80);
    setData(0x00);

    //15
    setReg(0xE0); // set gamma
    setData(0x0F);
    setData(0x1F);
    setData(0x1C);
    setData(0x0C);
    setData(0x0F);
    setData(0x08);
    setData(0x48);
    setData(0x98);
    setData(0x37);
    setData(0x0A);
    setData(0x13);
    setData(0x04);
    setData(0x11);
    setData(0x0D);
    setData(0x00);

    //15
    setReg(0xE1); // set negative gamma
    setData(0x0F);
    setData(0x32);
    setData(0x2E);
    setData(0x0B);
    setData(0x0D);
    setData(0x05);
    setData(0x47);
    setData(0x75);
    setData(0x37);
    setData(0x06);
    setData(0x10);
    setData(0x03);
    setData(0x24);
    setData(0x20);
    setData(0x00);

    //1
    setReg(0x3A);
    setData(0x55); // set 16bits / piexel

    //0
    setReg(0x11); // load default registers

    //1
    setReg(0x36);
    setData(0x28); // set memorty access

    delay.mili(120);

    //0
    setReg(0x29); // display on

    setOrientation(Orientation.portrait);
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
void setReg(ushort data)
{
    GPIOC.ODR &= ~(1 << 8); // clear RS
    write(data);
}

/// Set LCD data
void setData(ushort data)
{
    GPIOC.ODR |= 1 << 8; // set RS
    write(data);
}

/// Write data to LCD register
void writeReg(ushort reg, ushort data)
{
    setReg(reg);
    setData(data);
}

/// Draw single pixel into LCD buffer
void drawPixel(ushort x, ushort y, ushort color)
{
    setCursor(x, y);
    setData(color);
}

/// Fill rectangle area with given color
void fillRect(ushort x, ushort y, ushort w, ushort h, ushort color)
{
    setWindow(x, y, cast(ushort)(x + w - 1), cast(ushort)(y + h - 1));
    GPIOC.ODR |= 1 << 8; // set RS
    for (uint i = 0; i < w * h; i++)
    {
        write(color);
    }
}

/// Clear LCD to given color
void clear(ushort color)
{
    fillRect(0, 0, width, height, color);
}

/// Set drawing window
void setWindow(ushort x0, ushort y0, ushort x1, ushort y1)
{
    setReg(0x2A);
    setData(x0 >> 8);
    setData(x0 & 0xff);
    setData(x1 >> 8);
    setData(x1 & 0xff);

    setReg(0x2B);
    setData(y0 >> 8);
    setData(y0 & 0xff);
    setData(y1 >> 8);
    setData(y1 & 0xff);

    setReg(0x2C);
}

// Set drawing cursor. Cursor is nothing else than drawing window with 1x1 size
void setCursor(ushort x, ushort y)
{
    setWindow(x, y, x, y);
}

// Set LCD orientation
void setOrientation(Orientation orientation)
{
    switch (orientation)
    {
    case Orientation.portrait:
        writeReg(0x36, (1 << 6) | (1 << 3)); //0 degree MY=0,MX=0,MV=0,ML=0,BGR=1,MH=0
        break;
    case Orientation.landscape:
        writeReg(0x36, (1 << 3) | (1 << 4) | (1 << 5)); //90 degree MY=0,MX=1,MV=1,ML=1,BGR=1,MH=0
        break;
    case Orientation.reverse_portrait:
        writeReg(0x36, (1 << 3) | (1 << 7)); //180 degree MY=1,MX=1,MV=0,ML=0,BGR=1,MH=0
        break;
    case Orientation.reverse_landscape:
        writeReg(0x36, (1 << 3) | (1 << 5) | (1 << 6) | (1 << 7)); //270 degree MY=1,MX=0,MV=1,ML=0,BGR=1,MH=0
        break;
    default:
        break;
    }
}

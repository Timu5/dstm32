module main;

import stm32f4xx;
static import lcd;
static import delay;
import pong;

uint random(uint* seed)
{
    if(*seed == 0) *seed = 0xF1F2F3F4;
    uint v = 16807 * (*seed % 127773) - 2836 * (*seed / 127773);
    *seed = v;
    return v;
}

extern(C) int main()
{
    delay.init();
    lcd.init();
    //pong.init();

    uint seed = void;
    while(1)
    {
        /*lcd.clear(lcd.Color.white);

        while (1)
        {
            ushort startx = random(&seed) % 150;
            ushort starty = random(&seed) % 150;
            ushort width = cast(ushort)random(&seed) % (320 - startx - 1);
            ushort height = cast(ushort)random(&seed) % (480 - starty - 1);
            ushort color = random(&seed) % 0xffff;

            // fill screen with random rectangles
            lcd.fill_rect(startx, starty, width, height, color);
        }*/

        //lcd.set_orientation(lcd.Orientation.landscape);
        /*int x = 0;
        while(1)
        {
            lcd.clear(lcd.Color.black);
            lcd.fill_rect(0, 0, 10, 100, lcd.Color.white);
            lcd.fill_rect(200, cast(ushort)(20+x), 10, 10, lcd.Color.white);
            x++;
            x = x % 128;
        }*/
        Pong pong;
        pong.reset();
        
        while(1)
        {
            pong.update();
            //pong.draw();
            //pong.drawBack();
            delay.mili(15);
        }
    }

    return 0;
}
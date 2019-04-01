module pong;

static import lcd;
import main;

extern (C) void __aeabi_memcpy(void* dest, void* src, size_t n)
{
    for (size_t i = 0; i < n; i++)
    {
        *cast(byte*) dest = *cast(byte*) src;
        dest++;
        src++;
    }
}

struct Pong
{
    bool pause = true;

    uint seed = 123;

    int player = 200 * 16;
    int enemy = 200 * 16;

    int playerScore = 0;
    int enemyScore = 0;

    int ballX = (480 / 2 - 10) * 16;
    int ballY = (320 / 2 - 10) * 16;
    int ballSpeedX = 20 * 16;
    int ballSpeedY = 20 * 16;

    void update()
    {
        //if(pause) return;

        /*const char * keys = SDL_GetKeyboardState(NULL);
        if(keys[SDL_SCANCODE_W])
            player -= 5;
        if(keys[SDL_SCANCODE_S])
            player += 5;
        if(keys[SDL_SCANCODE_UP])
            enemy -= 5;
        if(keys[SDL_SCANCODE_DOWN])
            enemy += 5;*/
        clear();

        ballX += ballSpeedX;
        ballY += ballSpeedY;

        enemy = ballY - 50 * 16;
        player = ballY - 50 * 16;
        //enemy = (enemy < 0) ? 0 : ((enemy/16) > (320 - 100) ? (320 - 100) * 16 : enemy);
        //player = (player < 0) ? 0 : ((player/16) > (320 - 100) ? (320 - 100) * 16 : player);

        if (ballX < 10 * 16)
        {
            ballX = 10 * 16;
            if (ballY > player && ballY < player + 100 * 16)
            {
                ballSpeedX = -ballSpeedX;

                int delta = player / 16 + 50 - ballY / 16 + 10;
                ballSpeedY = delta * 2 + random(&seed) % 128;
            }
            else
            {
                reset();
                enemyScore++;
            }
        }
        if (ballX > (480 - 10 - 20) * 16)
        {
            ballX = (480 - 10 - 20) * 16;
            if (ballY > enemy && ballY < enemy + 100 * 16)
            {
                ballSpeedX = -ballSpeedX;

                int delta = enemy / 16 + 50 - ballY / 16 + 10;
                ballSpeedY = delta * 2 + random(&seed) % 128;
            }
            else
            {
                reset();
                playerScore++;
            }
        }
        if (ballY < 0)
        {
            ballY = 0;
            ballSpeedY = -ballSpeedY;
        }
        if (ballY > (320 - 20) * 16)
        {
            ballY = (320 - 20) * 16;
            ballSpeedY = -ballSpeedY;
        }

        draw();
    }

    void drawBack()
    {
        lcd.fill_rect(0, 0, 320, 480, lcd.Color.black);
    }

    void draw()
    {
        for (int i = 0; i < 13; i++)
            drawRect(480 / 2 - 5, i * 25, 10, 10);

        drawNum(480 / 2 - 150, 20, playerScore);
        drawNum(480 / 2 + 50, 20, enemyScore);

        drawRect(10, player / 16, 20, 100);
        drawRect(480 - 20 - 10, enemy / 16, 20, 100);

        drawRect(ballX / 16, ballY / 16, 20, 20);
    }

    void clear()
    {
        drawRect(10, player / 16, 20, 100, lcd.Color.black);
        drawRect(480 - 20 - 10, enemy / 16, 20, 100, lcd.Color.black);

        drawRect(ballX / 16, ballY / 16, 20, 20, lcd.Color.black);
    }

    void drawRect(int x, int y, int w, int h, lcd.Color color = lcd.Color.white)
    {
        lcd.fill_rect(cast(ushort) y, cast(ushort) x, cast(ushort) h,
                cast(ushort) w, cast(ushort) color);
    }

    void drawNum(int x, int y, int n)
    {
        n = n % 10;
        switch (n)
        {
        case 0:
            drawRect(x, y, 100, 20);
            drawRect(x, y + 150, 100, 20);
            drawRect(x, y, 20, 150);
            drawRect(x + 100 - 20, y, 20, 150);
            break;
        case 1:
            drawRect(x + 100 - 20, y, 20, 150 + 20);
            break;
        case 2:
            drawRect(x, y, 100, 20);
            drawRect(x, y + 150, 100, 20);
            drawRect(x, y + 60, 100, 20);
            drawRect(x, y + 60, 20, 150 - 60);
            drawRect(x + 100 - 20, y, 20, 60);
            break;
        case 3:
            drawRect(x, y, 100, 20);
            drawRect(x, y + 150, 100, 20);
            drawRect(x, y + 60, 100, 20);
            drawRect(x + 100 - 20, y, 20, 150 + 20);
            break;
        case 4:
            drawRect(x, y + 60, 100, 20);
            drawRect(x + 100 - 20, y, 20, 150 + 20);
            drawRect(x, y, 20, 60);
            break;
        case 5:
            drawRect(x, y, 100, 20);
            drawRect(x, y + 150, 100, 20);
            drawRect(x, y + 60, 100, 20);
            drawRect(x + 100 - 20, y + 60, 20, 150 - 60);
            drawRect(x, y, 20, 60);
            break;

        case 6:
            drawRect(x, y + 150, 100, 20);
            drawRect(x, y + 60, 100, 20);
            drawRect(x, y, 20, 150);
            drawRect(x + 100 - 20, y + 60, 20, 150 - 60);
            break;

        case 7:
            drawRect(x, y, 100, 20);
            drawRect(x + 100 - 20, y, 20, 150 + 20);
            break;
        case 8:
            drawRect(x, y, 100, 20);
            drawRect(x, y, 20, 150);
            drawRect(x, y + 150, 100, 20);
            drawRect(x, y + 60, 100, 20);
            drawRect(x + 100 - 20, y, 20, 150 + 20);
            break;
        case 9:
            drawRect(x, y, 100, 20);
            drawRect(x, y + 60, 100, 20);
            drawRect(x + 100 - 20, y, 20, 150 + 20);
            drawRect(x, y, 20, 60);
            break;
        default:
            break;
        }
    }

    void reset()
    {
        ballX = (480 / 2 - 10) * 16;
        ballY = (320 / 2 - 10) * 16;
        pause = true;
        drawBack();
        draw();
    }

}

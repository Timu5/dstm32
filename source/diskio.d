module diskio;

static import sdcard;

extern (C) ubyte disk_status(ubyte pdrv)
{
    return 0;
}

extern (C) ubyte disk_initialize(ubyte pdrv)
{
    return 0;
}

extern (C) ubyte disk_read(ubyte pdrv, ubyte* buff, uint sector, uint count)
{
    for (int i = 0; i < count; i++)
    {
        sdcard.readBlock(sector + i, buff + i * 512);
    }

    return 0;
}

extern (C) ubyte disk_ioctl(ubyte pdrv, ubyte cmd, void* buff)
{
    if (cmd == 0)
        return 0;
    return 1;
}

extern (C) uint get_fattime()
{
    return 0;
}
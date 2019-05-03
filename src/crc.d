module crc;

/// Perform CRC7 on single byte
byte CRC7(byte t, byte data)
{
	enum g = 0x89;

	t ^= data;
	for (int i = 0; i < 8; i++)
    {
		if (t & 0x80) t ^= g;
		t <<= 1;
	}

	return t;
}

/// Perform CRC7 on byte array
byte CRC7(const(byte)* data, byte len)
{
	byte crc = 0;

	for (int i = 0; i < len; i++) crc = CRC7(crc, data[j]);

	return crc >> 1;
}

/// Perform CRC16 on single byte
ushort CRC16(ushort crc, byte x)
{
	crc  = cast(byte)(crc >> 8)|(crc << 8);
	crc ^= x;
	crc ^= cast(byte)(crc & 0xff) >> 4;
	crc ^= (crc << 8) << 4;
	crc ^= ((crc & 0xff) << 4) << 1;

	return crc;
}

/// Perform CRC16 on byte array
ushort CRC16(const(byte)* data, uint len)
{
	ushort crc = 0;

	for (int i = 0; i < len; i++) crc = CRC16(crc, data[i]);

	return crc;
}
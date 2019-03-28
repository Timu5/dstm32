import subprocess

#ldc2 -mtriple=thumb-none-eabi -float-abi=hard -mcpu=cortex-m4 -c -betterC -singleobj start.d
#arm-none-eabi-ld -T link.ld --gc-sections start.o -o start.elf
#arm-none-eabi-objcopy -O binary start.elf start.bin

retcode = subprocess.call("wsl ldc2 -mtriple=thumb-none-eabi -float-abi=hard -mcpu=cortex-m4 -c -betterC -singleobj -boundscheck=off -I=src -of=build/main.o src/main.d src/lcd.d src/delay.d", shell=True)
if retcode != 0:
    print("Compilation fail!")
    quit()

retcode = subprocess.call("wsl arm-none-eabi-ld -T stm32f4_flash.ld --gc-sections src.o -o build/main.elf build/main.o build/startup_stm32f4xx.o build/system_stm32f4xx.o", shell=True)
if retcode != 0:
    print("Linkning fail!")
    quit()

print("OK!")
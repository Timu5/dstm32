import subprocess
import glob

#ldc2 -mtriple=thumb-none-eabi -float-abi=hard -mcpu=cortex-m4 -c -betterC -singleobj start.d
#arm-none-eabi-ld -T link.ld --gc-sections start.o -o start.elf
#arm-none-eabi-objcopy -O binary start.elf start.bin

files = " ".join([f.replace("\\", "/") for f in glob.glob("source/*.d", recursive=False)])

retcode = subprocess.call("ldc2 -mtriple=thumb-none-eabi -g -float-abi=hard -mcpu=cortex-m4 -c -betterC -singleobj -boundscheck=off -I=source -O2 -of=build/main.o  source/stm32f4xx/core.d " + files, shell=True)
if retcode != 0:
    print("Compilation fail!")
    quit()

retcode = subprocess.call("arm-none-eabi-ld -T stm32f4_flash.ld --gc-sections -o build/main.elf build/main.o build/pre/startup_stm32f4xx.o build/pre/system_stm32f4xx.o", shell=True)
if retcode != 0:
    print("Linking fail!")
    quit()

print("OK!")
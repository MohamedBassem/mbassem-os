C_FILES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
OBJ = ${C_FILES:.c=.o}

DOCKER = docker run --rm -v $(PWD):/work -w /work kernel-dev
DOCKER_INT = docker run -it --net=host --rm -v $(PWD):/work -w /work kernel-dev
LD = /usr/bin/ld
CC = /usr/bin/gcc
NASM = /usr/local/bin/nasm
QEMU = qemu-system-i386

CC_FLAGS = '-m32'
LD_FLAGS = '-melf_i386'

all: os-image.bin

run: os-image.bin
	${QEMU} -fda $<

clean:
	rm -f *.bin *.o *.elf
	rm -f kernel/*.bin kernel/*.o
	rm -f drivers/*.bin drivers/*.o

os-image.bin: boot_sector.bin kernel.bin
	cat $^ > $@

kernel.elf: ${OBJ}
	${DOCKER} ${LD} ${LD_FLAGS} -o $@ -Ttext 0x1000 $^

kernel.bin: kernel/kernel_entry.o ${OBJ}
	${DOCKER} ${LD} ${LD_FLAGS} -o $@ -Ttext 0x1000 --oformat binary $^

kernel/kernel_entry.o: kernel/kernel_entry.asm
	${DOCKER} /usr/bin/nasm $< -f elf -o $@

debug: os-image.bin kernel.elf
	${QEMU} -gdb tcp::9000 -S -fda os-image.bin &
	${DOCKER_INT} /usr/bin/gdb -ex "target remote docker.for.mac.localhost:9000" -ex "symbol-file kernel.elf"

%.o : %.c ${HEADERS}
	${DOCKER} ${CC} -g ${CC_FLAGS} -ffreestanding -c $< -o $@

%.bin : %.asm
	${NASM} $< -f bin -o $@


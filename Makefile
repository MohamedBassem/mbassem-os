C_FILES = $(wildcard kernel/*.c)
HEADERS = $(wildcard kernel/*.h)
OBJ = ${C_FILES:.c=.o}

all: os-image.bin

run: os-image.bin
	qemu-system-x86_64 -fda $<

clean:
	rm -f *.bin *.o
	rm -f kernel/*.bin kernel/*.o

os-image.bin: boot_sector.bin kernel.bin
	cat $^ > $@

kernel.bin: ${OBJ}
	docker run --rm -v $(PWD):/work -w /work kernel-dev /usr/bin/ld -o $@ -Ttext 0x1000 --oformat binary $^

%.o : %.c
	docker run --rm -v $(PWD):/work -w /work kernel-dev /usr/bin/gcc -ffreestanding -c $< -o $@

%.bin : %.asm
	/usr/local/bin/nasm $< -f bin -o $@


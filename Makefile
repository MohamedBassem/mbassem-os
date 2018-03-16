SRC_DIR := src
BIN_DIR := bin

DOCKER_WORKSPACE := /work
ASSEMBLY_IMAGE_PATH := $(BIN_DIR)/boot.bin
C_IMAGE_PATH := $(BIN_DIR)/kernel.bin
BIN_PATH := $(BIN_DIR)/image.bin

run: build_bin
	qemu-system-x86_64 $(BIN_PATH)

clean:
	rm -f bin/*

build_bin: assemble_boot_sector cross_compile_kernel
	mkdir -p $(BIN_DIR)
	cat $(ASSEMBLY_IMAGE_PATH) $(C_IMAGE_PATH) > $(BIN_PATH)

assemble_boot_sector:
	/usr/local/bin/nasm boot_sector.asm -o $(ASSEMBLY_IMAGE_PATH)

cross_compile_kernel:
	docker run -v $(PWD):/work -w /work kernel-dev /usr/bin/make compile_kernel

# This target will be called from docker
compile_kernel:
	gcc -ffreestanding -c $(SRC_DIR)/kernel.c -o $(BIN_DIR)/kernel.o
	ld -o $(C_IMAGE_PATH) -Ttext 0x1000 --oformat binary $(BIN_DIR)/kernel.o

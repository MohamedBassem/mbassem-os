BIN_DIR := bin
BIN_PATH := $(BIN_DIR)/image.bin

run: build_bin
	qemu-system-x86_64 $(BIN_PATH)

build_bin:
	mkdir -p $(BIN_DIR)
	/usr/local/bin/nasm boot_sector.asm -o $(BIN_PATH)

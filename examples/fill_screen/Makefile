NDK?=../../
BUILD_DIR=bin
SOURCE_DIR=src
COMPILER_OPT= -I $(NDK)/inc --cpu 6502
ASM_OPT = -t none
LINKER_OPT= -C $(NDK)/cfg/nes.cfg
LINKER_LIBS=  $(NDK)/bin/neslib.lib


all: fill_screen.nes

$(BUILD_DIR)/fill_screen.s: $(SOURCE_DIR)/fill_screen.c
	cc65 $(COMPILER_OPT) -o $(BUILD_DIR)/fill_screen.s $(SOURCE_DIR)/fill_screen.c
$(BUILD_DIR)/fill_screen.o: $(BUILD_DIR)/fill_screen.s
	ca65 $(ASM_OPT) $(BUILD_DIR)/fill_screen.s -o $(BUILD_DIR)/fill_screen.o
fill_screen.nes: $(BUILD_DIR)/ $(BUILD_DIR)/fill_screen.o
	ld65 $(LINKER_OPT) $(BUILD_DIR)/fill_screen.o $(LINKER_LIBS) -o fill_screen.nes


$(BUILD_DIR)/:
	mkdir -p $(BUILD_DIR)

clean:
	rm -Rf $(BUILD_DIR)/ fill_screen.nes

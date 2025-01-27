ASM_DIR=asm
BUILD_DIR=bin
CFG_DIR=cfg
INC_DIR=inc
EXAMPLES_DIR=examples
DOCS_DIR=docs
NDK_VERSION ?= 0.1.0
CC65_PATH ?= /usr/share/cc65

all: $(BUILD_DIR)/neslib.lib

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/crt0.o: $(ASM_DIR)/crt0.s $(BUILD_DIR)
	ca65 -t none $(ASM_DIR)/crt0.s -o $(BUILD_DIR)/crt0.o
	
$(BUILD_DIR)/neslib.lib: $(BUILD_DIR)/crt0.o $(BUILD_DIR)/neslib.o
	cp ${CC65_PATH}/lib/supervision.lib $(BUILD_DIR)/nes.lib && ar65 a $(BUILD_DIR)/nes.lib $(BUILD_DIR)/neslib.o $(BUILD_DIR)/crt0.o

$(BUILD_DIR)/neslib.o: $(ASM_DIR)/neslib.s $(BUILD_DIR)
	ca65 -t none $(ASM_DIR)/neslib.s -o $(BUILD_DIR)/neslib.o


clean:
	rm -Rf $(BUILD_DIR)

zip: $(BUILD_DIR)/neslib.lib
	zip -r neslib-$(NDK_VERSION).zip $(INC_DIR)/* $(CFG_DIR)/* $(BUILD_DIR)/nes.lib

#
# Makefile for BJR
#
include VERSION

VERSION_STR=$(BJR_VERSION_MAJOR).$(BJR_VERSION_MINOR)

BAS_PRG = main.prg
BAS_SRC = main.bas

ML_CONFIG := ml.cfg
ML_PRG := ml.prg
ML_OBJECTS := ml.o
ML_START_ADDR := 9216

LOADER_PRG = loader
LOADER_OBJECTS := loader.o
LOADER_START_ADDR := 8192

BJR_PRG = bjr-2018
BJR_OBJECTS := bjr.o
BJR_START_ADDR := 4609

IMAGE := bjr-v$(VERSION_STR).d64

AS := ca65
LD := ld65
PETCAT := petcat
PETCAT_FLAGS = -w2 -l 2c01

# Additional assembler flags and options.
ASFLAGS += -t vic20

# Additional linker flags and options.
LDFLAGS = -C $(ML_CONFIG)


all: $(BAS_PRG) $(ML_PRG) $(LOADER_PRG) $(BJR_PRG)
.PHONY: all image clean

$(BAS_PRG): $(BAS_SRC)
	$(PETCAT) $(PETCAT_FLAGS) -o $@ $(BAS_SRC)

$(ML_PRG) : $(ML_CONFIG) $(ML_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ -S $(ML_START_ADDR) $(ML_OBJECTS)

$(LOADER_PRG): $(ML_CONFIG) $(LOADER_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ -S $(LOADER_START_ADDR) $(LOADER_OBJECTS)

$(BJR_PRG): $(ML_CONFIG) $(BJR_OBJECTS)
	$(LD) $(LDFLAGS) -o "$@" -S $(BJR_START_ADDR) $(BJR_OBJECTS)

image: all
	c1541 -format bjr-2018,os d64 $(IMAGE)
	c1541 $(IMAGE) -write $(BJR_PRG)
	c1541 $(IMAGE) -write $(LOADER_PRG)
	c1541 $(IMAGE) -write picture.bin
	c1541 $(IMAGE) -write $(ML_PRG)
	c1541 $(IMAGE) -write chr.bin
	c1541 $(IMAGE) -write $(BAS_PRG)
	c1541 $(IMAGE) -write map01.bin
	c1541 $(IMAGE) -write map02.bin
	c1541 $(IMAGE) -write map03.bin
	c1541 $(IMAGE) -write map04.bin
	c1541 $(IMAGE) -write map05.bin
	c1541 $(IMAGE) -write map06.bin
	c1541 $(IMAGE) -write map07.bin
	c1541 $(IMAGE) -write map08.bin

testimage: image
	xvic -memory 8k -autostart $(IMAGE)

clean:
	$(RM) $(ML_OBJECTS) $(ML_PRG)
	$(RM) $(LOADER_OBJECTS) $(LOADER_PRG)
	$(RM) $(BJR_OBJECTS) $(BJR_PRG)
	$(RM) $(BAS_PRG)
	$(RM) $(IMAGE)
	$(RM) *~

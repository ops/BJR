#
# Makefile for BJR
#
include VERSION

VERSION_STR=v$(BJR_VERSION_MAJOR).$(BJR_VERSION_MINOR)

BAS_PRG = main.prg
BAS_SRC = main.bas

ML_CONFIG := ml.cfg
ML_PRG := ml.prg
ML_OBJECTS := ml.o
ML_START_ADDR := 9216

LOADER_PRG = loader
LOADER_OBJECTS := loader.o
LOADER_START_ADDR := 8192

BJR_PRG = bomb-jack
BJR_OBJECTS := bjr.o
BJR_START_ADDR := 4609

IMAGE := bjr-$(VERSION_STR).d64
RELEASE_FILE := "Bomb_Jack_Revisited_$(VERSION_STR)(+8k).zip"

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
	$(LD) $(LDFLAGS) -o $@ -S $(BJR_START_ADDR) $(BJR_OBJECTS)

image: all
	c1541 -format bjr-2018,os d64 $(IMAGE)
	c1541 $(IMAGE) -write $(BJR_PRG)
	c1541 $(IMAGE) -write $(LOADER_PRG)
	c1541 $(IMAGE) -write picture
	c1541 $(IMAGE) -write $(ML_PRG)
	c1541 $(IMAGE) -write chr.prg
	c1541 $(IMAGE) -write $(BAS_PRG)
	c1541 $(IMAGE) -write map01
	c1541 $(IMAGE) -write map02
	c1541 $(IMAGE) -write map03
	c1541 $(IMAGE) -write map04
	c1541 $(IMAGE) -write map05
	c1541 $(IMAGE) -write map06
	c1541 $(IMAGE) -write map07
	c1541 $(IMAGE) -write map08

release: image
	zip -9 $(RELEASE_FILE) $(IMAGE)

testimage: image
	xvic -memory 8k -autostart $(IMAGE)

clean:
	$(RM) $(ML_OBJECTS) $(ML_PRG)
	$(RM) $(LOADER_OBJECTS) $(LOADER_PRG)
	$(RM) $(BJR_OBJECTS) $(BJR_PRG)
	$(RM) $(BAS_PRG)
	$(RM) $(RELEASE_FILE) $(IMAGE)
	$(RM) *~

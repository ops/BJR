#
# Makefile for BJR
#

BAS_PRG = main.prg
BAS_SRC = main.bas

ML_CONFIG := ml.cfg
ML_PRG := ml.prg
ML_OBJECTS := ml.o
ML_START_ADDR := 8192

LOADER_PRG = loader
LOADER_OBJECTS := loader.o
LOADER_START_ADDR := 8192

BJR_PRG = bj\ revisited
BJR_OBJECTS := bjr.o
BJR_START_ADDR := 4609

AS := ca65
LD := ld65
PETCAT := petcat
PETCAT_FLAGS = -w2 -l 3001

# Additional assembler flags and options.
ASFLAGS += -t vic20

# Additional linker flags and options.
LDFLAGS = -C $(ML_CONFIG)


all: $(BAS_PRG) $(ML_PRG) $(LOADER_PRG) $(BJR_PRG)
.PHONY: all clean

$(BAS_PRG): $(BAS_SRC)
	$(PETCAT) $(PETCAT_FLAGS) $(BAS_SRC) > $@

$(ML_PRG): $(ML_CONFIG) $(ML_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ -S $(ML_START_ADDR) $(ML_OBJECTS)

$(LOADER_PRG): $(ML_CONFIG) $(LOADER_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ -S $(LOADER_START_ADDR) $(LOADER_OBJECTS)

$(BJR_PRG): $(ML_CONFIG) $(BJR_OBJECTS)
	$(LD) $(LDFLAGS) -o "$@" -S $(BJR_START_ADDR) $(BJR_OBJECTS)

clean:
	$(RM) $(ML_OBJECTS) $(ML_PRG)
	$(RM) $(LOADER_OBJECTS) $(LOADER_PRG)
	$(RM) $(BJR_OBJECTS) $(BJR_PRG)
	$(RM) $(BAS_PRG)
	$(RM) *~

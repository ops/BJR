#
# Makefile for BJR
#

ML_PRG := ml.prg
ML_CONFIG := ml.cfg
ML_START_ADDR := 8192
BAS_PRG = main.prg
BAS_SRC = main.bas
#LOADER_PRG = loader.prg
LOADER_PRG = l
LOADER_SRC = loader.s
LOADER_START_ADDR := 8192

AS := ca65
LD := ld65
PETCAT := petcat
PETCAT_FLAGS = -w2 -l 3001

# Additional assembler flags and options.
ASFLAGS += -t vic20

# Additional linker flags and options.
LDFLAGS = -C $(ML_CONFIG)

# Set OBJECTS
ML_OBJECTS := ml.o
LOADER_OBJECTS := loader.o

all: $(BAS_PRG) $(ML_PRG) $(LOADER_PRG)
.PHONY: all clean

$(BAS_PRG): $(BAS_SRC)
	$(PETCAT) $(PETCAT_FLAGS) $(BAS_SRC) > $@

$(ML_PRG): $(ML_CONFIG) $(ML_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ -S $(ML_START_ADDR) $(ML_OBJECTS)

$(LOADER_PRG): $(ML_CONFIG) $(LOADER_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ -S $(LOADER_START_ADDR) $(LOADER_OBJECTS)

clean:
	$(RM) $(ML_OBJECTS) $(ML_PRG)
	$(RM) $(LOADER_OBJECTS) $(LOADER_PRG)
	$(RM) $(BAS_PRG)
	$(RM) *~

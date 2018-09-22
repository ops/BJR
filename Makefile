#
# Makefile for BJR
#

ML_PRG := ml.prg
ML_CONFIG := ml.cfg
ML_START_ADDR := 5376
BAS_PRG = main.prg
BAS_SRC = main.bas

AS := ca65
LD := ld65
PETCAT := petcat
PETCAT_FLAGS = -w2 -l 0401

# Additional assembler flags and options.
ASFLAGS += -t vic20

# Additional linker flags and options.
LDFLAGS = -C $(ML_CONFIG)

# Set OBJECTS
OBJECTS := ml.o

all: $(BAS_PRG) $(ML_PRG)
.PHONY: all clean

$(BAS_PRG): $(BAS_SRC)
	$(PETCAT) $(PETCAT_FLAGS) $(BAS_SRC) > $@

$(ML_PRG): $(ML_CONFIG) $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ -S $(ML_START_ADDR) $(OBJECTS)

clean:
	$(RM) $(OBJECTS) $(ML_PRG)
	$(RM) $(BAS_PRG)
	$(RM) *~

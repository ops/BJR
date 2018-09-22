
PROGRAM_BASE := ml

SUFFIX := prg
CONFIG += ml.cfg
START_ADDR := 5376

PROGRAM := $(PROGRAM_BASE).$(SUFFIX)

AS := ca65
LD := ld65

# Compiler and assembler flags for generating listings
define _listing_
  ASFLAGS += --listing $$(@:.o=.lst)
  REMOVES += $(addsuffix .lst,$(basename $(OBJECTS)))
endef

# Linker flags for generating map file
define _mapfile_
  LDFLAGS += --mapfile $$@.map
  REMOVES += $(PROGRAM).map
endef

# Linker flags for generating VICE label file
define _labelfile_
  LDFLAGS += -Ln $$@.lbl
  REMOVES += $(PROGRAM).lbl
endef

# Linker flags for generating a debug file
define _debugfile_
  LDFLAGS += -Wl --dbgfile,$$@.dbg
  REMOVES += $(PROGRAM).dbg
endef

# Additional assembler flags and options.
ASFLAGS += -t vic20

# Additional linker flags and options.
LDFLAGS = -C $(CONFIG)

# Set OBJECTS
OBJECTS := ml.o

$(PROGRAM): $(CONFIG) $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ -S $(START_ADDR) $(OBJECTS)

clean:
	$(RM) $(OBJECTS) $(PROGRAM) *~

testcrt:
	xvic -cartA $(PROGRAM)

ASMSOURCES  := $(wildcard *.asm)
ASMOBJECTS  := $(patsubst %.asm,%.o,$(ASMSOURCES))

.PHONY: all clean

all: program

clean:
	$(RM) $(ASMOBJECTS) $@.nes

program: $(ASMOBJECTS)
	ld65 $^ -o $@.nes $(LDFLAGS) -t nes

-include $(CDEPENDS)

%.o: %.asm
	ca65 $(ASMFLAGS) $<

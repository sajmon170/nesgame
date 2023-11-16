ASMSOURCES  := $(wildcard *.s)
ASMOBJECTS  := $(patsubst %.s,%.o,$(ASMSOURCES))

.PHONY: all clean

all: game

clean:
	$(RM) $(ASMOBJECTS) $@.nes

game: $(ASMOBJECTS)
	ld65 $^ -o $@.nes $(LDFLAGS) -t nes

-include $(CDEPENDS)

%.o: %.s
	ca65 $(ASMFLAGS) $<

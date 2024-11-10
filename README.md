# Nestalgic
An NES game written in 6502 assembly

<p align="center">
  <img src="/docs/resources/screenshot.png" width="75%">
</p>

> [!NOTE]
> This project is under heavy development

## Current progress
### Terminology
- **PPU** - Picture Processing Unit
- **APU** - Audio Processing Unit
- **NMI** - Non-Maskable Interrupt

### Done
- [X] post-boot hardware init (RESET NMI)
  - [X] disable APU interrupts
  - [X] clear PPU memory
  - [X] clear system memory
  - [X] wait for vblank
- [X] read controller data from memory-mapped registers
- [X] PPU setup
  - [X] load palettes
  - [X] load sprites
- [X] Rendering  
  - [X] Handle the PPU NMI
- [X] Object entity system
  - [X] metatile support
- [X] Level data loading
  - [X] compressed-tile format
  - [X] generating PPU display data from level data

### TODO
- [ ] basic physics support
- [ ] NPC support
- [ ] screen scrolling

## Build instructions
This project requires the [cc65 toolchain](https://www.cc65.org/) (ca65 assembler + ld65 linker) and GNU Make. To build it run
```bash
make
```

This will output a `game.nes` file which can be tested in an emulator or transferred onto a flashcart and played on a real console.

> [!NOTE]
> This game targets the Famicom system model.

## Additional notes
This project wouldn't be possible without the tremendous documentation work done by [the NESdev community](https://www.nesdev.org/wiki/Nesdev_Wiki) and their help on Discord. Thank you!

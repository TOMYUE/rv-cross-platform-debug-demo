MAKEFLAGS = -sR
CC	:= riscv64-unknown-elf-gcc
CCFLAGES	:= -c -march=rv64imac -mabi=lp64 -g -Wall
LKFLAGES	:= -march=rv64imac -mabi=lp64
QEMU	:= qemu-riscv64
QFLAGES := -g 1234
RM := rm 
RMFLAGES := -rf 

ALLC_FILE := $(wildcard *.c)
ALLS_FILE := $(wildcard *.S)
ALLC_OBJS = $(ALLC_FILE:%.c=%.o)
ALLS_OBJS = $(ALLS_FILE:%.S=%.o)
ALL_OBJS  = $(ALLS_OBJS) $(ALLC_OBJS)
MAINEXEC = main.elf

.PHYANY: all clean build run

all: clean build link

build:$(ALL_OBJS)
run:
	$(QEMU) $(QFLAGES) $(MAINEXEC)
link:$(MAINEXEC)
clean:
	$(RM) $(RMFLAGES) *.elf *.o *.i *.s

CCSTR		= 	'CC -[M] Building... '$<
PRINTCSTR 	=	@echo $(CCSTR)
%.o : %.c
	$(CC) $(CCFLAGES) -o $@ $<
	$(PRINTCSTR)
%.o : %.S
	$(CC) $(CCFLAGES) -o $@ $<
	$(PRINTCSTR)	
%.elf :
	$(CC) $(LKFLAGES) -o $@ $(ALL_OBJS)
	@echo 'CC -[M] Building... '$@ 
BUILD_DIR := $(CURDIR)/../..

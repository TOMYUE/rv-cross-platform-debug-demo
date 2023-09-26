# 设置 MAKEFLAGS，-s 表示静默模式，-R 表示递归执行
MAKEFLAGS = -sR
# 设置 CC 变量为 RISC-V 编译器
CC := riscv64-unknown-elf-gcc
# 设置 CCFLAGES 变量，包含编译选项
CCFLAGES := -c -march=rv64imac -mabi=lp64 -g -Wall
# 设置 LKFLAGES 变量，包含链接选项
LKFLAGES := -march=rv64imac -mabi=lp64

# 设置 QEMU 变量为模拟器的名称
QEMU := qemu-riscv64
# 设置 QFLAGES 变量，包含模拟器选项
QFLAGES := -g 1234

# 设置 RM 变量为删除命令
RM := rm
# 设置 RMFLAGES 变量，包含删除选项
RMFLAGES := -rf

# 使用通配符获取所有的 .c 和 .S 文件
ALLC_FILE := $(wildcard *.c)
ALLS_FILE := $(wildcard *.S)
# 通过替换后缀，生成所有 .c 和 .S 文件对应的 .o 文件列表
ALLC_OBJS = $(ALLC_FILE:%.c=%.o)
ALLS_OBJS = $(ALLS_FILE:%.S=%.o)
# 汇总所有 .o 文件，生成 ALL_OBJS 列表
ALL_OBJS = $(ALLS_OBJS) $(ALLC_OBJS)

# 设置 MAINEXEC 变量为输出的可执行文件名
MAINEXEC = main.elf

# 声明伪目标 all，它依赖于 clean、build、link
.PHONY: all clean build run

# 默认目标，执行 clean、build、link
all: clean build link

# build 依赖于 ALL_OBJS
build: $(ALL_OBJS)

# run 命令用于运行模拟器
run:
	$(QEMU) $(QFLAGES) $(MAINEXEC)

# link 依赖于 MAINEXEC
link: $(MAINEXEC)

# clean 用于删除生成的文件
clean:
	$(RM) $(RMFLAGES) *.elf *.o *.i *.s

# 定义模式规则，将 .c 文件编译成 .o 文件
%.o : %.c
	$(CC) $(CCFLAGES) -o $@ $<
	@echo 'CC -[M] Building... '$<

# 定义模式规则，将 .S 文件编译成 .o 文件
%.o : %.S
	$(CC) $(CCFLAGES) -o $@ $<
	@echo 'CC -[M] Building... '$@

# 定义规则生成 .elf 可执行文件
%.elf :
	$(CC) $(LKFLAGES) -o $@ $(ALL_OBJS)
	@echo 'CC -[M] Building... '$@

# 设置 BUILD_DIR 变量为当前目录的上级目录
BUILD_DIR := $(CURDIR)/../..

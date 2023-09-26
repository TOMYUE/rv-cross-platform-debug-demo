# 设置 GDB 显示寄存器 x5、x6 和 x7 的十六进制值
display/z $x5
display/z $x6
display/z $x7

# 在源码级别进行单步调试时，设置 GDB 在每次单步执行后都显示下一行的反汇编代码
set disassemble-next-line on

# 在程序的 main 函数处设置断点
b main

# 将 GDB 连接到远程调试目标，端口号为 1234（通常是一个仿真器或远程调试代理的端口）
target remote :1234

# 开始执行程序，运行到第一个断点
c
main: main.asm
	nasm -f elf64 -o main.o main.asm
	gcc -g -no-pie -o main main.o -lglfw -lglad

main: main.asm
	nasm -g -f elf64 -o main.o main.asm
	gcc -g -no-pie -o main main.o -lglfw -lglad

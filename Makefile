main: main.asm
	gcc -c stb.c -o stb.o -lm
	ar rcs libstb.a stb.o
	rm *.o

	nasm -g -f elf64 -o main.o main.asm
	gcc -g -no-pie -o main main.o -lglfw -lglad -I .

CC = gcc
C99FLAGS = -c -O0 -Wall -std=c99
CFLAGS = -c -O0 -Wall
PROG = tp1
DEFAULT = mips

as_validate: validate.S
	$(CC) $(C99FLAGS) validate.S

as_main: mainAsmb.c
	$(CC) $(C99FLAGS) mainAsmb.c utils.c

c_main: main.c
	$(CC) $(C99FLAGS) main.c parser.c utils.c

c_as_main: main.c
	$(CC) $(C99FLAGS) -S main.c parser.c utils.c

mips: as_main as_validate
	$(CC) main.o validate.o utils.o -o $(PROG)

generic: c_main
	$(CC) mainC.o parser.o utils.o -o $(PROG)

generic-as: c_as_main 

	
clean:
	rm -rf *.o $(PROG)

CC = gcc
C99FLAGS = -c -O0 -Wall -std=c99
CFLAGS = -c -O0 -Wall
PROG = tp1
DEFAULT = mips

as_validate: validate.S
	$(CC) $(C99FLAGS) validate.S
as_find_tag: find_tag.S
	$(CC) $(C99FLAGS) find_tag.S
as_parse: parse.S
	$(CC) $(C99FLAGS) parse.S
as_main: mainA.c
	$(CC) $(C99FLAGS) mainA.c utils.c

c_main: main.c
	$(CC) $(C99FLAGS) main.c parser.c utils.c

c_as_main: main.c
	$(CC) $(C99FLAGS) -S main.c parser.c utils.c

mips: as_main as_validate as_find_tag as_parse
	$(CC) mainA.o validate.o find_tag.o parse.o utils.o -o $(PROG)

generic: c_main
	$(CC) main.o parser.o utils.o -o $(PROG)

generic-as: c_as_main 

	
clean:
	rm -rf *.o $(PROG)

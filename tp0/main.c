#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>

#define false 0
#define true 1
#define BUFF_SIZE 1024

struct Options {
    char* separator;
    int starting;
    int increment;
    int join;
    int blank;
};

void write_line(FILE* fd, struct Options* options, char* c, int header){
	if (header){        
		printf("%d%s%c", options->starting, options->separator, *c);
	}else{
		printf("%c", *c);
	}

}


void show_help() {
    printf("USAGE:\n");
    printf("tp0 [OPTION]...[FILE]...\n");
    printf("Write each FILE to standard output, with line numbers added. ");
    printf("With no FILE, or when FILE is -, read standard input\n\n");
    printf("OPTIONS:\n");
    printf("-h, --help Print this message and quit\n");
    printf("-s, --number-separator (mandatory argument)\n");
    printf("-v, --starting-line-number (mandatory argument)\n");
    printf("-i, --line-increment (mandatory argument)\n");
    printf("-l, --join-blank-lines (mandatory argument)\n");
    printf("-t, --non-blank\n");
}

void skip_blanks(FILE* fd, struct Options* options, int* i, char* c){

    if (*c == '\n' && options->blank) {
        while(*c == '\n') {
            write_line(fd, options, c, 0);
	    fscanf(fd, "%c", c);
        }
    } else if (*c == '\n' && options->join > 0) {
        while (++(*i) < options->join) {
            fscanf(fd, "%c", c);
	    if(*c != '\n')
                break;
            else
	        write_line(fd, options, c, 0);                
        }
    }

}

void increment(struct Options* options){

        if (!options->increment)
            options->starting += 1;
        else
            options->starting += options->increment;
}

void parse_line(FILE* fd, struct Options* options, char* c){
	        
	write_line(fd, options, c, 1);
	if (*c != '\n') {
	    fscanf(fd, "%c", c); 
	    while (*c != '\n'){
		write_line(fd, options, c, 0);                
		fscanf(fd, "%c", c);
		}
            write_line(fd, options, "\n", 0);
        }

}


void nl_v1(FILE* fd, struct Options* options) {
    char c;
    int i = 0;

    while ((c = fgetc(fd)) != EOF) {
	skip_blanks(fd, options, &i, &c);
	parse_line(fd, options, &c);
	increment(options);
    }
}

void write_line_v2(char* lbuf, struct Options* options, char* c, int header){
	if (header == 1){        
	        printf("%d%s%s\n", options->starting, options->separator, lbuf);
	}else{
		printf("%c", *c);
	}

}

void skip_blanks_v2(struct Options* options, int* i, char* c, char* fbuf, long* a){

    if (*c == '\n' && options->blank) {
        while(*c == '\n') {
            write_line_v2(NULL, options, c, 0);
            *c = fbuf[(*a)++];
        }
    } else if (*c == '\n' && options->join > 0) {
        while (++(*i) < options->join) {
            if ((*c = fbuf[(*a)++]) != '\n')
                break;
            else
	        write_line_v2(NULL, options, c, 0);                
		//printf("%c", *c);
        }
    }

}

void parse_line_v2(struct Options* options, char* c, int* b, long* a, char* lbuf,const char* fbuf, int bufsize){
        if (*c != '\n') {
	    lbuf[*b]=*c;
	    char* j = strchr(fbuf + (*a)*sizeof(char), '\n');
	    if (j == 0){
		j = strchr(fbuf + (*a)*sizeof(char), '\0');
	    }
	    *b = j - (fbuf + (*a)*sizeof(char)) + 1;
	    strncpy(lbuf + sizeof(char), fbuf + (*a)*sizeof(char), *b);
	    *a += *b;
        }

}

void read_file(FILE* fd, char* fbuf, int bufsize){
    fseek(fd, 0L, SEEK_SET);
    fread(fbuf, sizeof(char), bufsize, fd);
    fbuf[bufsize - 1] = '\0';

}

void nl_v2(FILE* fd, struct Options* options) {
    char c;
    int i = 0;
    int b = 0;
    long a = 0;

    fseek(fd, 0L, SEEK_END);
    unsigned long bufsize = ftell(fd);
    char* fbuf = malloc(sizeof(char) * bufsize);
    char* lbuf = malloc(sizeof(char) * BUFF_SIZE);
    read_file(fd, fbuf, bufsize);

    while ((c = fbuf[a++]) != '\0') {
        skip_blanks_v2(options, &i, &c, fbuf, &a);
	parse_line_v2(options, &c, &b, &a, lbuf, fbuf, bufsize);
        lbuf[b++]='\0';
	write_line_v2(lbuf, options, &c, 1);


        b=0;

        increment(options);
    }

    free(fbuf);
    free(lbuf);
}

void parse_args(struct Options* options, int argc, char **argv)
{
    int option_index = 0;
    const struct option long_options[] =
    {
        {"help", no_argument, 0, 'h'},
        {"number-separator", required_argument, 0, 's'},
        {"starting-line-number", required_argument, 0, 'v'},
        {"line-increment", required_argument, 0, 'i'},
        {"join-blank-lines", required_argument, 0, 'l'},
        {"non-blank", no_argument, 0, 't'},
        {0, 0, 0, 0}
    };
	
    options->separator = " ";
    options->starting = 1;
    options->increment = 0;
    options->join = 0;
    options->blank = false;

    while (1) {
        int c = getopt_long (argc, argv, "hs:v:i:l:t", long_options, &option_index);

        if (c == -1)
            break;

        switch (c) {
            case 'h':
                show_help();
                exit(EXIT_SUCCESS);
            case 's':
                options->separator = optarg;
                break;
            case 'v':
                options->starting = atoi(optarg);
                break;
            case 'i':
                options->increment = atoi(optarg);
                break;
            case 'l':
                options->join = atoi(optarg);
                break;
            case 't':
                options->blank = true;
                break;
            default:
                break;
        }
    }
}

int main(int argc, char **argv)
{
    int i;
    FILE* fd;
    char** f = NULL;


    struct Options options;
    parse_args(&options, argc, argv);	


    if (optind < argc) {

        f = argv + optind;
        for (i = 0; i < argc - optind; ++i) {
            fd = fopen(f[i], "r");
            if (fd != NULL) {
                nl_v1(fd, &options);
		//nl_v2(fd, &options);
                fclose(fd);
            } else {
                fprintf(stderr, "Error opening file %s\n", f[i]);
            }
        }
    } else {
        nl_v1(stdin, &options);
        //nl_v2(stdin, &options);
    }

    return 0;
}


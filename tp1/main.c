#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>
#include "parser.h"

#define false 0
#define true 1
#define BUFF_SIZE 1024

struct Options {
    char* filename;
};

void show_help() {
    printf("Usage:\n");
    printf("\tvalidate -h\n");
    printf("\tvalidate -V\n");
    printf("\tvalidate [options] file\n");
    printf("Options:\n");
    printf("-h, --help   Prints usage information.\n");
    printf("-V, --version   Prints version information.\n");
    printf("-i, --input   Path to input file (-i - for stdin)\n");
    printf("Examples:\n");
    printf("\tvalidate -i -\n");
    printf("\tvalidate myfile.tagged\n");
    printf("\tvalidate -i myfile.tagged\n");
}

void show_version() {
    printf("Version: 1.0\n");
}

void fun(FILE* fd) {
    fseek(fd, 0L, SEEK_END);
    unsigned long bufsize = ftell(fd) + 1;
    char* fbuf = malloc(sizeof(char) * bufsize);
    fseek(fd, 0L, SEEK_SET);
    fread(fbuf, sizeof(char), bufsize, fd);
    fbuf[bufsize - 1] = '\0';

    printf("%s\n", fbuf);

    int line =0;
    int result = 0;
    while(*fbuf != '\0' && result != 1) {
        int old_tag_length = 0;
        char* oldtag="";
        result = parser(&fbuf, &line, &oldtag, &old_tag_length);
    }


}

void parse_args(struct Options* options, int argc, char **argv)
{
    int option_index = 0;
    const struct option long_options[] =
    {
        {"help", no_argument, 0, 'h'},
        {"version", no_argument, 0, 'v'},
        {"input", required_argument, 0, 'i'},
        {0, 0, 0, 0}
    };
	
    while (1) {
        int c = getopt_long (argc, argv, "hvi:", long_options, &option_index);

        if (c == -1)
            break;

        switch (c) {
            case 'h':
                show_help();
                exit(EXIT_SUCCESS);
            case 'v':
                show_version();
                exit(EXIT_SUCCESS);
            case 'i':
                options->filename = optarg;
                break;
            default:
                break;
        }
    }
}

int main(int argc, char **argv)
{
    FILE* fd;

    struct Options options;
    parse_args(&options, argc, argv);	

    if (strcmp(options.filename, "-")) {
            fd = fopen(options.filename, "r");
            if (fd != NULL) {
                fun(fd);
                fclose(fd);
            } else {
                fprintf(stderr, "Error opening file %s\n", options.filename);
            }
    } else {
        fun(stdin);
    }

    return 0;
}

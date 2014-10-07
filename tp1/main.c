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


void read_file(FILE* fd, char* fbuf, int bufsize){
    fseek(fd, 0L, SEEK_SET);
    fread(fbuf, sizeof(char), bufsize, fd);
    fbuf[bufsize - 1] = '\0';

}


void parse_args(struct Options* options, int argc, char **argv)
{
    int option_index = 0;
    const struct option long_options[] =
    {
        {"help", no_argument, 0, 'h'},
        {"version", required_argument, 0, 'V'},
        {"input-file", required_argument, 0, 'i'},
        {0, 0, 0, 0}
    };
	
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


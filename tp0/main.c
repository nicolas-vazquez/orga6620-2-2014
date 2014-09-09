#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

#define BUFF_SIZE 1024

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

int main(int argc, char **argv)
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

    while (1) {
        int c = getopt_long (argc, argv, "hs:v:i:l:t", long_options, &option_index);

        if (c == -1)
            break;

        switch (c) {
            case 'h':
                show_help();
                exit(EXIT_SUCCESS);
            case 's':
                printf("number-separator: %s\n", optarg);
                break;
            case 'v':
                printf("starting-line-number: %s\n", optarg);
                break;
            case 'i':
                printf("line-increment: %s\n", optarg);
                break;
            case 'l':
                printf("join-blank-lines: %s\n", optarg);
                break;
            case 't':
                printf("non-blank\n");
                break;
            default:
                break;
        }
    }

    return 0;
}

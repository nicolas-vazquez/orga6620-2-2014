#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

#define true 1
#define false 0
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

void nl(const char* filename, const char* separator, int *starting, int increment, int join, int blank) {
    size_t n = 0;
    FILE* fd = fopen(filename, "r");
    char c = fgetc(fd);
    char* buf = malloc(sizeof(char) * BUFF_SIZE);

    while (c != EOF) {
        while (c != '\n') {
            buf[n++] = c;
            c = fgetc(fd);
        }
        buf[n++] = '\0';
        printf("%d%s%s", *starting++, separator, buf);

        free(buf);
        buf = malloc(sizeof(char) * BUFF_SIZE);

        c = fgetc(fd);
    }
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

    char* separator = NULL;
    int starting = 0, increment = 0, join = 0, blank = 0;

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
                separator = optarg;
                break;
            case 'v':
                printf("starting-line-number: %s\n", optarg);
                starting = atoi(optarg);
                break;
            case 'i':
                printf("line-increment: %s\n", optarg);
                increment = atoi(optarg);
                break;
            case 'l':
                printf("join-blank-lines: %s\n", optarg);
                join = atoi(optarg);
                break;
            case 't':
                printf("non-blank\n");
                blank = true;
                break;
            default:
                break;
        }
    }

    //nl(filename, separator, &starting, increment, join, blank);

    return 0;
}

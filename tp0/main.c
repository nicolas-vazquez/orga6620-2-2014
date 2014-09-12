#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

#define false 0
#define true 1
#define RES_OK 2
#define RES_EOF 3
#define BUFF_SIZE 1024

struct options {
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

int increment_lines(FILE* fd, int increment) {
    int i;
    char c;
    for (i = 0; i < increment; i++) {
        while ((c = fgetc(fd)) != '\n') {
            if (c == EOF)
                return RES_EOF;
        }
    }
    return RES_OK;
}

void nl_v1(const char* filename, struct options* options) {
    char c;
    size_t n = 0;
    FILE* fd = fopen(filename, "r");
    char* buf = malloc(sizeof(char) * BUFF_SIZE);

    if (fd == NULL) {
        fprintf(stderr, "Error opening file %s", filename);
        return;
    }

    if (increment_lines(fd, options->starting) == RES_EOF) {
        free(buf);
        fclose(fd);
        return;
    }

    while ((c = fgetc(fd)) != EOF) {
        if (c == '\n') {
            if (options->blank == true)
                while((c = fgetc(fd)) == '\n');

            buf[n++] = '\0';
            printf("%d%s%s", options->starting++, options->separator, buf);

            if (increment_lines(fd, options->increment) == RES_EOF) {
                free(buf);
                fclose(fd);
                return;
            }

            n = 0;
            free(buf);
            buf = malloc(sizeof(char) * BUFF_SIZE);
            options->starting += options->increment - 1;

            if (c != '\n')
                buf[n++] = c;

        } else {
            buf[n++] = c;
        }
    }

    free(buf);
    fclose(fd);
    return;
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

    struct options options;

    options.separator = "";
    options.starting = 0;
    options.increment = 0;
    options.join = 0;
    options.blank = false;

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
                options.separator = optarg;
                break;
            case 'v':
                printf("starting-line-number: %s\n", optarg);
                options.starting = atoi(optarg);
                break;
            case 'i':
                printf("line-increment: %s\n", optarg);
                options.increment = atoi(optarg);
                break;
            case 'l':
                printf("join-blank-lines: %s\n", optarg);
                options.join = atoi(optarg);
                break;
            case 't':
                printf("non-blank\n");
                options.blank = true;
                break;
            default:
                break;
        }
    }

    //nl_v1(filename, &options);
    //nl_v2(filename, &options);

    return 0;
}

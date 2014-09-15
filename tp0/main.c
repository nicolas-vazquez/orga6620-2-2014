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

int increment_lines(FILE* fd, int increment, char* buf, unsigned long *n) {
    int i;
    char c;

    for (i = 1; i < increment; i++) {
        while (true) {
            if (buf) {
                c = buf[*n];
                *n += 1;
            } else {
                c = fgetc(fd);
            }

            if (c == '\n')
                break;

            if (c == EOF || c == '\0')
                return RES_EOF;
        }
    }

    return RES_OK;
}

void nl_v1(const char* filename, struct options* options) {
    char c;
    FILE* fd = fopen(filename, "r");

    if (fd == NULL) {
        fprintf(stderr, "Error opening file %s\n", filename);
        return;
    }

    if (increment_lines(fd, options->starting, NULL, NULL) == RES_EOF) {
        fclose(fd);
        return;
    }

    while ((c = fgetc(fd)) != EOF) {
        if (c == '\n' && options->blank)
            while((c = fgetc(fd)) == '\n');

        printf("%d%s%c", options->starting, options->separator, c);

        if (c != '\n') {
            while ((c = fgetc(fd)) != '\n')
                printf("%c", c);
            printf("\n");
        }

        if (increment_lines(fd, options->increment, NULL, NULL) == RES_EOF) {
            fclose(fd);
            return;
        }

        if (!options->increment)
            options->starting += 1;
        else
            options->starting += options->increment;
    }

    fclose(fd);
    return;
}

void nl_v2(const char* filename, struct options* options) {
    char c;
    size_t b = 0;
    unsigned long a = 0;
    FILE* fd = fopen(filename, "r");

    if (fd == NULL) {
        fprintf(stderr, "Error opening file %s\n", filename);
        return;
    }

    fseek(fd, 0L, SEEK_END);
    unsigned long bufsize = ftell(fd);
    char* fbuf = malloc(sizeof(char) * bufsize);
    char* lbuf = malloc(sizeof(char) * BUFF_SIZE);

    fseek(fd, 0L, SEEK_SET);
    fread(fbuf, sizeof(char), bufsize, fd);
    fbuf[bufsize - 1] = '\0';

    fclose(fd);

    if (increment_lines(NULL, options->starting, fbuf, &a) == RES_EOF) {
        free(fbuf);
        free(lbuf);
        return;
    }

    while ((c = fbuf[a++]) != '\0') {
        if (c == '\n' && options->blank) {
            while ((c = fbuf[a++]) == '\n');
        }

        if (c != '\n') {
            lbuf[b++]=c;
            while ((c=fbuf[a++]) != '\n' && a < bufsize)
                lbuf[b++] = c;
        }

        lbuf[b++]='\0';

        printf("%d%s%s\n", options->starting, options->separator, lbuf);

        b=0;
        free(lbuf);
        lbuf = malloc(sizeof(char) * BUFF_SIZE);

        if (increment_lines(NULL, options->increment, fbuf, &a) == RES_EOF) {
            free(fbuf);
            free(lbuf);
            return;
        }

        if (!options->increment)
            options->starting += 1;
        else
            options->starting += options->increment;
    }

    free(fbuf);
    free(lbuf);
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
    options.starting = 1;
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

    if (optind < argc) {

    }

    nl_v1(argv[optind], &options);
    //nl_v2(argv[optind], &options);

    return 0;
}

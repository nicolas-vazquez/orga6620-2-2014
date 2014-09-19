#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

#define false 0
#define true 1
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

void nl_v1(FILE* fd, struct options* options) {
    char c;
    int i = 0;

    while ((c = fgetc(fd)) != EOF) {
        if (c == '\n' && options->blank) {
            while(c == '\n') {
                printf("%c", c);
                c = fgetc(fd);
            }
        } else if (c == '\n' && options->join > 0) {
            while (++i < options->join) {
                if ((c = fgetc(fd)) != '\n')
                    break;
                else
                    printf("%c", c);
            }
        }

        printf("%d%s%c", options->starting, options->separator, c);

        if (c != '\n') {
            while ((c = fgetc(fd)) != '\n')
                printf("%c", c);
            printf("\n");
        }

        if (!options->increment)
            options->starting += 1;
        else
            options->starting += options->increment;
    }
}

void nl_v2(FILE* fd, struct options* options) {
    char c;
    int i = 0;
    size_t b = 0;
    unsigned long a = 0;

    fseek(fd, 0L, SEEK_END);
    unsigned long bufsize = ftell(fd);
    char* fbuf = malloc(sizeof(char) * bufsize);
    char* lbuf = malloc(sizeof(char) * BUFF_SIZE);

    fseek(fd, 0L, SEEK_SET);
    fread(fbuf, sizeof(char), bufsize, fd);
    fbuf[bufsize - 1] = '\0';

    while ((c = fbuf[a++]) != '\0') {
        if (c == '\n' && options->blank) {
            while (c == '\n') {
                printf("%c", c);
                c = fbuf[a++];
            }
        } else if (c == '\n' && options->join > 0) {
            while (++i < options->join) {
                if ((c = fbuf[a++]) != '\n')
                    break;
                else
                    printf("%c", c);
            }
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
    int i;
    FILE* fd;
    char** f = NULL;
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

    options.separator = " ";
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
                options.separator = optarg;
                break;
            case 'v':
                options.starting = atoi(optarg);
                break;
            case 'i':
                options.increment = atoi(optarg);
                break;
            case 'l':
                options.join = atoi(optarg);
                break;
            case 't':
                options.blank = true;
                break;
            default:
                break;
        }
    }

    if (optind < argc) {
        f = argv + optind;
        for (i = 0; i < argc - optind; ++i) {
            fd = fopen(f[i], "r");
            if (fd != NULL) {
                nl_v1(fd, &options);
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

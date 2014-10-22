#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>
#include "validate.h"

void show_help() {
    printf("Usage:\n");
    printf("  validate -h\n");
    printf("  validate -V\n");
    printf("  validate [options] file\n");
    printf("Options:\n");
    printf("  -h, --help     Prints usage information.\n");
    printf("  -V, --version  Prints version information.\n");
    printf("  -i, --input    Path to input file (-i - for stdin)\n");
    printf("Examples:\n");
    printf("  validate -i -\n");
    printf("  validate myfile.tagged\n");
    printf("  validate -i myfile.tagged\n");
}

void show_version() {
    printf("66.20 - Organización de Computadoras\n");
    printf("Trabajo Práctico nº1: Conjunto de instrucciones MIPS\n");
    printf("Versión 1.0 (23/10/2014)\n");
}

int main(int argc, char **argv)
{
    FILE* fd;
    int result = 0;
    char* errmsg = NULL;
    char* filename = NULL;
    int option_index = 0;

    const struct option long_options[] =
    {
        {"help", no_argument, 0, 'h'},
        {"version", no_argument, 0, 'V'},
        {"input", required_argument, 0, 'i'},
        {0, 0, 0, 0}
    };

    while (1) {
        int c = getopt_long (argc, argv, "hVi:", long_options, &option_index);

        if (c == -1)
            break;

        switch (c) {
        case 'h':
            show_help();
            exit(EXIT_SUCCESS);
        case 'V':
            show_version();
            exit(EXIT_SUCCESS);
        case 'i':
            filename = optarg;
            break;
        default:
            break;
        }
    }

    if (strcmp(filename, "-")) {
        fd = fopen(filename, "r");
        if (fd != NULL) {
            result = validate_file(fd, &errmsg);
            fclose(fd);
        } else {
            fprintf(stderr, "Error opening file %s\n", filename);
        }
    } else {
        result = validate_file(stdin, &errmsg);
    }

    if (strlen(errmsg) > 0) {
        fprintf(stderr, "%s\n", errmsg);
        free(errmsg);
    }

    return result;
}

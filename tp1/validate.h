#ifndef VALIDATE_H
#define VALIDATE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define BUF_SIZE 1024
#define ERR_MSG_LEN 64
#define ERR_NOT_OPEN_TAG 1
#define ERR_NOT_CLOSE_TAG 2
#define ERR_CLOSE_BEFORE_TAG 3

/**
 * @param tag
 * @returns {boolean}
 */
int is_open_tag(char *_new);

/**
 * @param text
 * @param line
 * @param tag
 * @param tag length
 * @returns {boolean}
 */
int find_tag(char** text, int* line, char** _tag, int* _tag_len);

/**
 * @param tag1
 * @param tag1 length
 * @param tag2
 * @param tag2 length
 * @returns {boolean}
 */
int compare_tags(char* _old, int _old_len, char* _new, int _new_len);

/**
 * @param text
 * @param line
 * @param tag
 * @param tag length
 * @param error message
 * @returns {boolean}
 */
int parse_file(char **text, int *line, char **_old, int *_old_len, char* errmsg);

/**
 * @param text
 * @param error message
 * @returns {boolean}
 */
int validate(char *text, char **errmsg);

/**
 * @param file descriptor
 * @param error message
 * @returns {boolean}
 */
int validate_file(FILE *fd, char **errmsg);

#endif // VALIDATE_H

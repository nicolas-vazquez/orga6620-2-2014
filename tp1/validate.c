#include "validate.h"

int find_tag(char** text, int* line, char** _tag, int* _tag_len) {

    while (**text != '<' && **text != '\0') {
        if (**text == '\n')
            (*line)++;
        (*text)++;
    }

    if (**text == '\0')
        return 1;

    *_tag = ++(*text);

    while (**text != '>' && **text != '\0') {
        (*_tag_len)++;
        (*text)++;
    }

    if (**text == '\0')
        return 1;

    return 0;
}

int is_open_tag(char* _new) {

    if (*_new == '/')
        return 0;

    if (strlen(_new) > 0)
        return 1;
    else
        return 0;
}

int compare_tags(char* _old, int _old_len, char* _new, int _new_len) {

    if (_new_len != _old_len + 1)
        return 0;
    else
        return !memcmp(_old, (_new + 1), _old_len);
}

char* copy_tag(char* _tag, int _tag_len) {
    int i;

    char* tag1 = malloc(sizeof(char) * (_tag_len + 1));

    for (i = 0; i < _tag_len; i++, _tag++) {
        tag1[i] = *_tag;
    }

    tag1[i] = '\0';

    return tag1;
}

int handle_error(int res, int line, char* _old, int _old_len, char* _new, int _new_len, char* errmsg) {

    char* tag1 = copy_tag(_old, _old_len);
    char* tag2 = copy_tag(_new, _new_len);

    switch (res) {
        case ERR_NOT_OPEN_TAG:
            sprintf(errmsg, "Error en línea %d: El tag %s no ha sido abierto", line, tag2);
            free(tag2);
            break;
        case ERR_NOT_CLOSE_TAG:
            sprintf(errmsg, "Error en línea %d: El tag %s no se ha cerrado", line, tag1);
            free(tag1);
            break;
        case ERR_CLOSE_BEFORE_TAG:
            sprintf(errmsg, "Error en línea %d: %s cerrado antes que %s", line, tag2, tag1);
            free(tag1);
            free(tag2);
            break;
    }

    return EXIT_FAILURE;
}

int parse_file(char** text, int* line, char** _old, int* _old_len, char* errmsg) {

    while (**text != '\0') {
        char* _new = "";
        int _new_len = 0;

        if (find_tag(text, line, &_new, &_new_len)) {
            if (is_open_tag(*_old))
                return handle_error(ERR_NOT_CLOSE_TAG, *line, *_old, *_old_len, _new, _new_len, errmsg);
            else
                return EXIT_SUCCESS;
        }

        if (*_old_len == 0) {
            if (is_open_tag(_new)) {
                *_old_len = _new_len;
                *_old = _new;
            } else {
                return handle_error(ERR_NOT_OPEN_TAG, *line, *_old, *_old_len, _new + 1, _new_len - 1, errmsg);
            }
        } else {
            if (is_open_tag(_new)) {
                if (parse_file(text, line, &_new, &_new_len, errmsg) != 0)
                    return EXIT_FAILURE;
            } else {
                if (!compare_tags(*_old, *_old_len, _new, _new_len))
                    return handle_error(ERR_CLOSE_BEFORE_TAG, *line, *_old, *_old_len, _new + 1, _new_len - 1, errmsg);
                else
                    return EXIT_SUCCESS;
            }
        }
    }

    return EXIT_FAILURE;
}

int validate(char* text, char** errmsg) {
    int line = 0;
    int result = 0;

    *errmsg = malloc(sizeof(char) * ERR_MSG_LEN);

    while (*text != '\0' && result != 1) {
        int _old_len = 0;
        char* _old = "";
        result = parse_file(&text, &line, &_old, &_old_len, *errmsg);
    }

    return result;
}

int validate_file(FILE* fd, char** errmsg) {
    char c;
    int i = 0;
    char* fbuf = NULL;

    if (fd == stdin) {
        fbuf = malloc(sizeof(char) * BUF_SIZE);
        while ((c = fgetc(fd)) != EOF) {
            fbuf[i++] = c;
        }
    } else {
        fseek(fd, 0L, SEEK_END);
        unsigned long bufsize = ftell(fd) + 1;
        fbuf = malloc(sizeof(char) * bufsize);

        fseek(fd, 0L, SEEK_SET);
        fread(fbuf, sizeof(char), bufsize, fd);
        fbuf[bufsize - 1] = '\0';
    }

    printf("%s", fbuf);
    int result = validate(fbuf, errmsg);

    free(fbuf);
    return result;
}

#ifndef PARSE_H
#define PARSE_H

int is_begin_tag(char* newtag, int newtag_l);
int compare_tags(char* oldtag, int oldtag_length, char* newtag, int newtag_length);
char* create_message(int res, char* _old, int _old_len, char* _new, int _new_len, int* line);

#endif

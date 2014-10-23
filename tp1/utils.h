#ifndef PARSE_H
#define PARSE_H

void print_entra_loop1();
void print_entra_loop2();
void print_sale_loop();
void print_enc_tag();
void printll();
void print(char* s, int n);
int foo(char* file, int* line, char* oldtag, int* oldtag_length);
int is_begin_tag(char* newtag, int newtag_l);
int compare_tags(char* oldtag, int oldtag_length, char* newtag, int newtag_length);
int find_tag1(char* file, int* line, char* newtag, int* newtag_length);
#endif

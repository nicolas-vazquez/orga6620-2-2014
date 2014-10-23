#include "utils.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void print_entro_loop1(){
	printf("entro loop 1\n");

}

void print_entro_loop1_parser(){
	printf("entro loop 1 parser\n");
}

void print_entro_loop2(){
	printf("entro loop 2\n");
}

void print_sale_loop(){
	printf("sale loop\n");
}

void print_enc_tag(){
	printf("encontre tag\n");
}

void print_num(int num){
	printf("%d\n", num);
}

void printll(){
	printf("llega111\n");
}

void print(char* s, int n){
	//printf("voy a imprimr\n");
	fwrite(s,sizeof(char),n,stdout);
	printf("\n");


}

int is_begin_tag(char* newtag, int newtag_l){
	if(newtag[0] != '/'){
		return 0;
	}
	return 1;
}

int compare_tags(char* oldtag, int oldtag_length, char* newtag, int newtag_length){
	if(newtag_length != oldtag_length+1){
		return 0;
	}else{
		
		int i = !memcmp(oldtag, (newtag + 1), oldtag_length);
		return i;
	}
}

int foo(char* file, int* line, char* oldtag, int* oldtag_length){
	printf("%s\n", file);
	printf("llega\n");
	printf("line: %d\n", *line);
	(*line)++;
	return 0;	
}

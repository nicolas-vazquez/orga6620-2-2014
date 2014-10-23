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
	//print(newtag, newtag_l);
	if(newtag[0] != '/'){
		printf("Es un tag de inicio\n");
		return 0;
	}
	return 1;
}

int compare_tags(char* oldtag, int oldtag_length, char* newtag, int newtag_length){
	printf("comparando ");
	print(oldtag, oldtag_length);
	printf(" con ");
	print(newtag, newtag_length);
	printf("\n");
	if(newtag_length != oldtag_length+1){
		printf("no son iguales \n");
		return 0;
	}else{
		
		int i = !memcmp(oldtag, (newtag + 1), oldtag_length);
		printf("comparo: %d", i);
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

int find_tag1(char* file, int* line, char* newtag, int* newtag_length){
	printf("entro a find tag %d \n", *file);
	while(*file != '<' && *file != '\0'){
		if(*file == '\n'){

			(*line)++;
			printf("se aumento la linea: %d\n", *line);
		}
		(file)++;
		
		printf("estoy  primer loop %d\n", file);
	}

	if (*file == '\0'){
		printf("encontro fin de string\n");
		return 1;
	}

	newtag = ++(file);
	printf("%d\n", file);
	while(*file != '>' && *file != '\0'){
		(*newtag_length)++;
		(file)++;

		printf("newtag encontrado en %d ", file);
	}
	if(*newtag_length > 0){
		printf("new tag (%d)= ", *newtag_length);
		print(newtag, *newtag_length);
		printf("\n");
	}

	if(*file == '\0'){
		printf("encontro fin de string 2\n");
		return 1;
	}
	printf("salgo de find tag\n");
	return 0;
}

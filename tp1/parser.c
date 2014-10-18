#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find_tag(int* line, char** file, char** tag, int* taglength) {
    *tag=*file;
    while (**file != '<' && **file != '\0') {
        if (**file == '\n'){
            (*line)++;
        }
        (*file)++;
        (*tag)++;
    }
    if (**file == '\0'){
        return 1;
    }
    (*file)++;
    (*tag)++;

    while(**file != '>' && **file != '\0') {
        (*taglength)++;
        (*file)++;
    }
    if (**file == '\0'){
        return 1;
    }
    (*file)++;
    return 0;
}

int is_open_tag(char* newtag) {
    if (*newtag == '/')
        return 0;
    return strlen(newtag);
}

int compare_tags(char* oldtag, char* newtag, int* new_tag_length, int* old_tag_length) {
    if (*new_tag_length != *old_tag_length+1)
        return 0;
    else
        return !memcmp(oldtag, (newtag + 1), *old_tag_length);
}

int parser(char** file, int* line, char** oldtag, int* old_tag_length) {
    while(**file != '\0') {
        char* newtag = "";
        int new_tag_length=0;
        if(find_tag(line,file,&newtag,&new_tag_length)){
            if (is_open_tag(*oldtag)) {
                fprintf(stderr, "Error en linea %d \n", *line);
                fprintf(stderr, "Tag nunca cerrado: ");
                fwrite(*oldtag,sizeof(char),*old_tag_length,stdout);
                printf("\n");
            }
            return 1;
        }

        if (*old_tag_length == 0) {
            if (is_open_tag(newtag)) {
                printf("Abrio tag: ");
                fwrite(newtag,sizeof(char),new_tag_length,stdout);
                printf("\n");
                *old_tag_length = new_tag_length;
                *oldtag = newtag;
            } else {
                printf("Tag nunca abierto: ");
                fwrite(newtag,sizeof(char),new_tag_length,stdout);
                printf("\n");
                return 1;
            }


        } else {
            if (is_open_tag(newtag)) {
                printf("Abrio tag: ");
                fwrite(newtag,sizeof(char),new_tag_length,stdout);
                printf("\n");
                int result = parser(file, line, &newtag, &new_tag_length);
                if (result !=0) {
//                    fprintf(stderr, "Error en linea %d\n", *line);
//                    fprintf(stderr, "Tag nunca cerrado: ");
//                    fwrite(newtag+1,sizeof(char),new_tag_length-1,stdout);
//                     printf("\n");
                    return 1;
                }
            } else {
                printf("Cerro tag: ");
                fwrite(newtag+1,sizeof(char),new_tag_length-1,stdout);
                printf("\n");
                if (compare_tags(*oldtag, newtag, &new_tag_length, old_tag_length)) {
                    return 0;
                } else {

                    fprintf(stderr, "Error en linea %d\n", *line);
                    fprintf(stderr, "Tag mal cerrado: ");
                    fwrite(newtag+1,sizeof(char),new_tag_length-1,stdout);
                     printf("\n");
                    return 1;
                }
            }
        }
    }

//    if (**file=='\0' && is_open_tag(*oldtag)) {
//        fprintf(stderr, "Error en linea %d", *line);
//        fprintf(stderr, "Tag nunca cerrado12: ");
//        fwrite(*oldtag,sizeof(char),*old_tag_length,stdout);
//         printf("\n");
//         return 1;
//    }
    return 1;
}


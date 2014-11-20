#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

char* copy_tag(char* _tag, int _tag_len) {
    int i;

    char* tag = malloc(sizeof(char) * (_tag_len + 1));

    for (i = 0; i < _tag_len; i++, _tag++) {
        tag[i] = *_tag;
    }

    tag[i] = '\0';

    return tag;
}

char* create_message(int res, char* _old, int _old_len, char* _new, int _new_len, int* line){	
	char* tag1 = copy_tag(_old, _old_len);
	char* tag2 = copy_tag(_new, _new_len);
	char* errmsg = malloc(sizeof(char) * 1000);
	switch (res) {
		case 0:
			sprintf(errmsg, "Error en línea %d: El tag %s no ha sido abierto", *line, tag2);
        		free(tag2);
        		break;
        	case 1:
        	        sprintf(errmsg, "Error en línea %d: El tag %s no se ha cerrado", *line, tag1);
			free(tag1);
     		        break;
     	        case 2:
           		sprintf(errmsg, "Error en línea %d: %s cerrado antes que %s", *line, tag2, tag1);
         		free(tag1);
         		free(tag2);
         		break;
	}
	return errmsg;
	

}



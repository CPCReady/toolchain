#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINES 1024
#define MAX_LINE_LEN 256

int main(int argc, char* argv[]) {
    if(argc < 4) {
        printf("Created by Destroyer 2025:\n");
        printf("Uso:\n");
        printf("  %s get <file.ini> <section> <key>\n", argv[0]);
        printf("  %s set <file.ini> <section> <key> <value>\n", argv[0]);
        return 1;
    }

    const char* cmd = argv[1];
    const char* filename = argv[2];
    const char* section = argv[3];
    const char* key = argv[4];
    const char* value = (argc > 5) ? argv[5] : NULL;

    char* lines[MAX_LINES];
    int num_lines = 0;
    char line[MAX_LINE_LEN];
    char current_section[MAX_LINE_LEN] = "";
    int section_found = 0;
    int key_found = 0;

    FILE* file = fopen(filename, "r");
    if(file) {
        while(fgets(line, sizeof(line), file) && num_lines < MAX_LINES) {
            lines[num_lines] = strdup(line);
            num_lines++;
        }
        fclose(file);
    } else if(strcmp(cmd, "get") == 0) {
        fprintf(stderr, "Error: Could not open '%s'\n", filename);
        return 1;
    }

    if(strcmp(cmd, "get") == 0) {
        // Leer valor
        for(int i=0; i<num_lines; i++) {
            char* l = lines[i];
            if(l[0] == '[') {
                sscanf(l, "[%255[^]]]", current_section);
            } else {
                char k[MAX_LINE_LEN], v[MAX_LINE_LEN];
                if(sscanf(l, "%255[^=]=%255[^\n]", k, v) == 2) {
                    while(k[0]==' ') memmove(k,k+1,strlen(k));
                    while(v[0]==' ') memmove(v,v+1,strlen(v));
                    if(strcmp(current_section, section) == 0 && strcmp(k, key) == 0) {
                        printf("%s\n", v);
                        for(int j=0; j<num_lines; j++) free(lines[j]);
                        return 0;
                    }
                }
            }
        }
        fprintf(stderr, "Key '%s' not found in section '%s'\n", key, section);
        for(int j=0; j<num_lines; j++) free(lines[j]);
        return 1;
    }

    else if(strcmp(cmd, "set") == 0 && value) {
        // Modificar o crear
        for(int i=0; i<num_lines; i++) {
            char* l = lines[i];
            if(l[0] == '[') {
                sscanf(l, "[%255[^]]]", current_section);
                if(strcmp(current_section, section) == 0) section_found = 1;
            } else {
                char k[MAX_LINE_LEN], v[MAX_LINE_LEN];
                if(sscanf(l, "%255[^=]=%255[^\n]", k, v) == 2) {
                    while(k[0]==' ') memmove(k,k+1,strlen(k));
                    while(v[0]==' ') memmove(v,v+1,strlen(v));
                    if(strcmp(current_section, section) == 0 && strcmp(k, key) == 0) {
                        snprintf(line, sizeof(line), "%s=%s\n", k, value);
                        free(lines[i]);
                        lines[i] = strdup(line);
                        key_found = 1;
                    }
                }
            }
        }

        if(!section_found) {
            snprintf(line, sizeof(line), "\n[%s]\n%s=%s\n", section, key, value);
            lines[num_lines++] = strdup(line);
        } else if(section_found && !key_found) {
            int insert_at = num_lines;
            for(int i=0; i<num_lines; i++) {
                if(lines[i][0] == '[') {
                    char sec[MAX_LINE_LEN];
                    sscanf(lines[i], "[%255[^]]]", sec);
                    if(strcmp(sec, section) == 0) {
                        insert_at = i+1;
                        break;
                    }
                }
            }
            snprintf(line, sizeof(line), "%s=%s\n", key, value);
            for(int j=num_lines; j>insert_at; j--) lines[j] = lines[j-1];
            lines[insert_at] = strdup(line);
            num_lines++;
        }

        // Guardar
        file = fopen(filename, "w");
        if(!file) {
            perror("Error: The file could not be opened for writing.");
            return 1;
        }
        for(int i=0; i<num_lines; i++) {
            fputs(lines[i], file);
            free(lines[i]);
        }
        fclose(file);
        printf("File '%s' updated successfully.\n", filename);
        return 0;
    }

    fprintf(stderr, "Error: Unrecognized command or incorrect parameters.\n");
    return 1;
}
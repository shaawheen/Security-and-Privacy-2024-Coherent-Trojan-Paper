
#!/bin/bash
ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R "192.168.42.15"

# Send artifacts to the target board
echo "--------------------------------------"
echo "Sending artifacts to the target board"
echo "--------------------------------------"

scp -r create_user.sh root@192.168.42.15:

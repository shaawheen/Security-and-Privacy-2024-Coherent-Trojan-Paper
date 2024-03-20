rm #!/bin/bash

USER="user1"
# PASSWORD="user1"

#create user
echo "Creating user"
adduser --disabled-password ${USER} --no-create-home

#create home directory for the user
echo "Creating home directory for the user"
cd /
mkdir home/
mkdir home/${USER}

#change the owenership of the directory to the user
chown ${USER} home/${USER}

# Need to define a password to to be able to use the scp later
passwd ${USER}

# Switch to the user
cd home/${USER}
su ${USER}


# if I want to go back to root
# su -l
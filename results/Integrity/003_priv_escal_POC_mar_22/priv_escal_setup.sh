rm #!/bin/bash

ROOT_DIR=$(realpath ".")
USER="user1"
# PASSWORD="user1"

echo "--------------------------------------------------------------------------"
echo "Coherent Trojan Configured"
./find_pattern

echo "--------------------------------------------------------------------------"
#create user
echo "Creating user"
adduser --disabled-password ${USER} --no-create-home

#create home directory for the user
echo "Creating home directory for the user"
cd /
mkdir home/
mkdir home/${USER}

#change the owenership of the directory to the user
chown ${USER}:${USER} home/${USER}

cp ${ROOT_DIR}/gain_root_priv /home/user1
cp ${ROOT_DIR}/priv_escal_attack.sh /home/user1
chown ${USER}:${USER} /home/user1/priv_escal_attack.sh
chmod 777 /home/user1/gain_root_priv /home/user1/priv_escal_attack.sh
rm ${ROOT_DIR}/gain_root_priv ${ROOT_DIR}/priv_escal_attack.sh

# Need to define a password to to be able to use the scp later
passwd ${USER}

echo "--------------------------------------------------------------------------"
echo "Switching to the new user"
# Switch to the user
cd /home/${USER}
su ${USER}

# if I want to go back to root
# su -l

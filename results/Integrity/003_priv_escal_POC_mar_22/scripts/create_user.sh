rm #!/bin/bash

ROOT_DIR=$(realpath ".")

if [ -z "$1" ]; then
    echo "Error: No argument passed. Please provide a username."
    exit 1
fi

USER="$1" 
PASSWORD=${USER}

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

cp ${ROOT_DIR}/gain_root_priv /home/${USER}
cp ${ROOT_DIR}/priv_escal_attack.sh /home/${USER}
cp ${ROOT_DIR}/priv_escal.sh /home/${USER}
cp ${ROOT_DIR}/write_file.sh /home/${USER}
chown ${USER}:${USER} /home/${USER}/priv_escal_attack.sh 
chown ${USER}:${USER} /home/${USER}/priv_escal.sh 
chown ${USER}:${USER} /home/${USER}/write_file.sh 
chmod 777   /home/${USER}/gain_root_priv        \
            /home/${USER}/priv_escal_attack.sh  \
            /home/${USER}/priv_escal.sh         \
            /home/${USER}/write_file.sh         \
rm ${ROOT_DIR}/gain_root_priv ${ROOT_DIR}/priv_escal_attack.sh

# Need to define a password to to be able to use the scp later
# The password is repeated because passwd command usually asks for the password twice.
echo -e "${USER}\n${USER}" | passwd ${USER}

rm #!/bin/bash

ROOT_DIR=$(realpath ".")

if [ -z "$1" ]; then
    echo "Error: No argument passed. Please provide a username."
    exit 1
fi

USER="$1" 
PASSWORD=${USER}

echo "--------------------------------------------------------------------------"
echo "Gaining root privileges"
./gain_root_priv $(id -u) ${USER}

echo "--------------------------------------------------------------------------"
echo "Restart User Session to apply changes"
id 
echo -e "${USER}\n" | su -l ${USER} -c "./write_file.sh ${USER}"

exit

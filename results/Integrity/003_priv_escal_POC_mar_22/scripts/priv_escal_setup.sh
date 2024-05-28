rm #!/bin/bash

ROOT_DIR=$(realpath ".")

if [ -z "$1" ]; then
    echo "Error: No argument passed. Please provide a username."
    exit 1
fi

USER="$1" 

./create_user.sh ${USER}

echo "Switching to the new user ${USER}"
cd /home/${USER}

su ${USER} -c "./priv_escal.sh ${USER}"

exit
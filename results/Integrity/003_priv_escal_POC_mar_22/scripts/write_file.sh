rm #!/bin/bash

ROOT_DIR=$(realpath ".")

if [ -z "$1" ]; then
    echo "Error: No argument passed. Please provide a username."
    exit 1
fi

USER="$1" 

echo "--------------------------------------------------------------------------"
echo "Write to the file created by root"
echo "This shouldn't be possible"

echo "${USER} - I'm root!" >> /root/test_priv_escal.txt

# Go back to root for another iteration
exit
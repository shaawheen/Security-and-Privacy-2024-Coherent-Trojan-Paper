
#!/bin/bash

ROOT=$(realpath ".")
ROOT_DIR=$(realpath "../../../")
ARTIFACTS_DIR=${ROOT_DIR}/software/artifacts
LINUX_APPS_DIR=${ARTIFACTS_DIR}/linux_apps
ATTACK_DIR=${LINUX_APPS_DIR}/003_priv_escal_POC
CREATE_USER_DIR=${ATTACK_DIR}/create_user
GAIN_ROOT_DIR=${ATTACK_DIR}/gain_root_priv
FIND_PATTERN_DIR=${ATTACK_DIR}/find_pattern

ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R "192.168.42.15"


cd ${FIND_PATTERN_DIR} 
./1_compile.sh

cd ${GAIN_ROOT_DIR}
./1_compile.sh

# Send artifacts to the target board
echo "--------------------------------------"
echo "Sending artifacts to the target board"
echo "--------------------------------------"
    # ${CREATE_USER_DIR}/create_user.sh   \

scp -r                                  \
    ${GAIN_ROOT_DIR}/gain_root_priv     \
    ${FIND_PATTERN_DIR}/find_pattern    \
    ${ROOT}/priv_escal_setup.sh         \
    ${ROOT}/priv_escal_attack.sh        \
    root@192.168.42.15:

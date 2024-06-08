
#!/bin/bash

ROOT=$(realpath ".")
ROOT_DIR=$(realpath "../../../")
SCRIPT=${ROOT}/scripts
ARTIFACTS_DIR=${ROOT_DIR}/software/artifacts
LINUX_APPS_DIR=${ARTIFACTS_DIR}/linux_apps
ATTACK_DIR=${LINUX_APPS_DIR}/001_match_pattern
FIND_PATTERN_DIR=${ATTACK_DIR}/find_pattern
APP_TEST_DATA_DIR=${ATTACK_DIR}/app_test_data
APP_TEST_INST_DIR=${ATTACK_DIR}/app_test_inst
APP_SYNC_DIR=${ATTACK_DIR}/sync

ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R "192.168.42.15"

cd ${FIND_PATTERN_DIR} 
./1_compile.sh
cd ${APP_TEST_DATA_DIR} 
./1_compile.sh
cd ${APP_TEST_INST_DIR} 
./1_compile.sh
cd ${APP_SYNC_DIR} 
./1_compile.sh

# Send artifacts to the target board
echo "--------------------------------------"
echo "Sending artifacts to the target board"
echo "--------------------------------------"
    # ${CREATE_USER_DIR}/create_user.sh   \

scp -r                                  \
    ${APP_TEST_DATA_DIR}/app_test_data  \
    ${APP_TEST_INST_DIR}/app_test_inst  \
    ${FIND_PATTERN_DIR}/find_pattern    \
    ${APP_SYNC_DIR}/sync                \
    ${SCRIPT}/eval.sh                   \
    root@192.168.42.15:
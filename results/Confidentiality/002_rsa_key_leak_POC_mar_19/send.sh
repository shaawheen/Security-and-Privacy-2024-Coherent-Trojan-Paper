
#!/bin/bash

ROOT_DIR=$(realpath "../../../")
ARTIFACTS_DIR=${ROOT_DIR}/software/artifacts
LINUX_APPS_DIR=${ARTIFACTS_DIR}/linux_apps
ATTACK_DIR=${LINUX_APPS_DIR}/002_rsa_key_leak_POC_mar_19
OPENSSL_DIR=${ATTACK_DIR}/openssl-install
FIND_PATTERN_DIR=${ATTACK_DIR}/find_pattern
READ_BRAM_DIR=${ATTACK_DIR}/read_BRAM

ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R "192.168.42.15"

# Send artifacts to the target board
echo "--------------------------------------"
echo "Sending artifacts to the target board"
echo "--------------------------------------"

scp -r rsa_attack.sh \
    ${READ_BRAM_DIR}/read_BRAM \
    ${OPENSSL_DIR}/openssl.sh \
    ${OPENSSL_DIR}/bin/openssl \
    ${OPENSSL_DIR}/libssl.so.3 \
    ${OPENSSL_DIR}/libcrypto.so.3 \
    ${FIND_PATTERN_DIR}/find_pattern \
    root@192.168.42.15:

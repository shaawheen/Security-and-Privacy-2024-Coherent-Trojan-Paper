
#!/bin/bash

ROOT=$(realpath ".")
ROOT_DIR=$(realpath "../../../")
ARTIFACTS_DIR=${ROOT_DIR}/software/artifacts
LINUX_APPS_DIR=${ARTIFACTS_DIR}/linux_apps
ATTACK_DIR=${LINUX_APPS_DIR}/001_deg_perf_POC
FIND_PATTERN_DIR=${ATTACK_DIR}/find_pattern
RT_BENCH_DIR=${ARTIFACTS_DIR}/rt-bench
SCRIPT_RESULTS_DIR=${ATTACK_DIR}/scripts_results

ssh-keygen -f "/home/${USER}/.ssh/known_hosts" -R "192.168.42.15"

cd ${FIND_PATTERN_DIR} 
./1_compile.sh

# Send artifacts to the target board
echo "--------------------------------------"
echo "Sending artifacts to the target board"
echo "--------------------------------------"
    # ${CREATE_USER_DIR}/create_user.sh   \

scp -r                                                      \
    ${RT_BENCH_DIR}/vision/benchmarks/disparity/data/vga    \
    ${RT_BENCH_DIR}/IsolBench/latency                       \
    ${SCRIPT_RESULTS_DIR}/performance_degradation.sh        \
    ${FIND_PATTERN_DIR}/find_pattern                        \
    root@192.168.42.15:
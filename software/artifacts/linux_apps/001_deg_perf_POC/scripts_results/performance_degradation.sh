rm #!/bin/bash

ROOT=$(realpath ".")
ROOT_VBS=${ROOT}/vga
ROOT_ISOL=${ROOT}
ROOT_FP=${ROOT}

# RT-Bench Arguments
PERIOD=0 # Continuous Execution
DEADLINE=0 # Continuous Execution

# Experiments Configs
N_TASKS=20 # RUNS per delay
N_RUNS=4
DELAY_STEP=50
NO_LOG=0
LOG=1

perform_degradation() {
    DELAY=$1
    LOG=$2
    if [ $LOG -eq 1 ]; then
        echo "Delay $DELAY clocks Disparity!" 
        ${ROOT_FP}/find_pattern en $DELAY dis > /dev/null
        
        ${ROOT_VBS}/disparity                                           \
                            -p ${PERIOD}                                \
                            -d ${DEADLINE}                              \
                            -t ${N_TASKS}                               \
                            -f 99                                       \
                            -m 10M                                      \
                            -l 2                            \
                            -o ${ROOT}/results/dis_delay_${DELAY}.csv   \
                            -b "${ROOT_VBS}"

        echo "Delay $DELAY clocks Isolbench!" 
        ${ROOT_FP}/find_pattern en $DELAY isol > /dev/null
        ${ROOT_ISOL}/latency                                            \
                            -p ${PERIOD}                                \
                            -d ${DEADLINE}                              \
                            -t ${N_TASKS}                               \
                            -l 2                            \
                            -o ${ROOT}/results/isol_delay_${DELAY}.csv  \
                            -b "-m 4096 -s -i 1"                        
    elif [ $LOG -eq 0 ]; then
        echo "Delay $DELAY clocks Disparity!" 
        ${ROOT_FP}/find_pattern en $DELAY dis > /dev/null

        ${ROOT_VBS}/disparity                                           \
                            -p ${PERIOD}                                \
                            -d ${DEADLINE}                              \
                            -t ${N_TASKS}                               \
                            -f 99                                       \
                            -m 10M                                      \
                            -l 3                                        \
                            -b "${ROOT_VBS}"

        echo "Delay $DELAY clocks Isolbench!" 
        ${ROOT_FP}/find_pattern en $DELAY isol > /dev/null
        ${ROOT_ISOL}/latency                                            \
                            -p ${PERIOD}                                \
                            -d ${DEADLINE}                              \
                            -t ${N_TASKS}                               \
                            -l 3                                        \
                            -b "-m 4096 -s -i 1"                      
    fi

    ${ROOT_FP}/find_pattern dis 0 0 > /dev/null
}

# Execute actions based on the command
case "$1" in
    "print")
        for i in $(seq 0 $N_RUNS); do
            echo "--------------------------------------"
            echo "Run ($i/$N_RUNS)"
            echo "--------------------------------------"
            perform_degradation $((i * $DELAY_STEP)) $NO_LOG

        done
        ;;
    *) # log to a csv file
        mkdir ${ROOT}/results

       for i in $(seq 0 $N_RUNS); do
            echo "--------------------------------------"
            echo "Run ($i/$N_RUNS)"
            echo "--------------------------------------"
            perform_degradation $((i * $DELAY_STEP)) $LOG
        done
        ;;
esac



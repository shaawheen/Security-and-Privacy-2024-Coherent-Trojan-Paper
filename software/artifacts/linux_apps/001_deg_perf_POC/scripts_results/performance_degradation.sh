rm #!/bin/bash

ROOT=$(realpath ".")
ROOT_VBS=${ROOT}/vga
ROOT_ISOL=${ROOT}
ROOT_FP=${ROOT}

# RT-Bench Arguments
PERIOD=1 
DEADLINE=1
N_TASKS=2
LOG_LEVEL=2
NO_LOG=0
LOG=1

perform_degradation() {
    DELAY=$1
    LOG=$2

    echo "Delay $DELAY clocks!" 

    ${ROOT_FP}/find_pattern en $DELAY > /dev/null

    if [ $LOG -eq 1 ]; then
        # ${ROOT_VBS}/disparity                                           \
        #                     -p ${PERIOD}                                \
        #                     -d ${DEADLINE}                              \
        #                     -t ${N_TASKS}                               \
        #                     -f 99                                       \
        #                     -m 10M                                      \
        #                     -l ${LOG_LEVEL}                             \
        #                     -o ${ROOT}/results/dis_delay_${DELAY}.csv   \
        #                     -b "${ROOT_VBS}"

        ${ROOT_ISOL}/latency                                            \
                            -p ${PERIOD}                                \
                            -d ${DEADLINE}                              \
                            -t ${N_TASKS}                               \
                            -l ${LOG_LEVEL}                             \
                            -o ${ROOT}/results/isol_delay_${DELAY}.csv  \
                            -b "-m 4096 -s -i 1"                        
    elif [ $LOG -eq 0 ]; then
        # ${ROOT_VBS}/disparity                                           \
        #                     -p ${PERIOD}                                \
        #                     -d ${DEADLINE}                              \
        #                     -t ${N_TASKS}                               \
        #                     -f 99                                       \
        #                     -m 10M                                      \
        #                     -l 3                                        \
        #                     -b "${ROOT_VBS}"

        ${ROOT_ISOL}/latency                                            \
                            -p ${PERIOD}                                \
                            -d ${DEADLINE}                              \
                            -t ${N_TASKS}                               \
                            -l 3                                        \
                            -b "-m 4096 -s -i 1"                      
    fi

    ${ROOT_FP}/find_pattern dis 0 > /dev/null
}

# Execute actions based on the command
case "$1" in
    "print")
        for i in $(seq 0 4); do
            perform_degradation $((i * 10)) $NO_LOG
        done
        ;;
    *)
        mkdir ${ROOT}/results

       for i in $(seq 0 4); do
            perform_degradation $((i * 10)) $LOG
        done
        ;;
esac



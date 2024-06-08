rm #!/bin/bash

if [ -z "$1" ]; then
    echo "$0 <inst|data> <EL1|EL2|EL3>"
    exit 1
fi

it="$1" 

rm results.txt

eval_inst_el1() {
    echo "--------------------------------------------------------------------------"
    echo "Coherent Trojan Configrued - Instruction Test"
    ./find_pattern en inst

    RUNS=1000

    for N in $(seq 1 $RUNS); do
        # make N copies to have several locations / addresses
        cp app_test_inst ./app_test_inst_$N 
    done

    i=1
    previous_deanon_pa=0
    while [ $i -le $RUNS ]
    do
        echo "Iteration $i"

        # Get Real PA of the target function
        real_pa_line=$(./app_test_inst_$i | grep "Physical Addr:")
        real_pa=$(echo "$real_pa_line" | cut -d':' -f2)

        # Get the PA of the deanon function
        pa_line=$(./find_pattern print isnt | grep "PA")
        deanon_pa=$(echo "$pa_line" | cut -d':' -f2)

        # Check if the PA has changed (i.e., the function has been de-anonymized)
        if [ "$previous_deanon_pa" != "$deanon_pa" ]; then
            echo "$deanon_pa"
            # increment the counter if different, otherwise execute the same binary again
            echo "${i} Real:${real_pa} Deanon: ${deanon_pa}" >> results.txt
            i=$((i+1)) 
        fi

        previous_deanon_pa="$deanon_pa"
    done

    ./find_pattern dis inst
}

eval_inst_el2() {
    echo "--------------------------------------------------------------------------"
    echo "Coherent Trojan Configrued - Instruction Test"

    ./find_pattern en inst EL2

    RUNS=1000

    i=1
    previous_deanon_pa=0
    while [ $i -le $RUNS ]
    do
        echo "Iteration $i"

        # I will lose first measure. I have to first invoke find_pattern print EL2
        # and then sync. The sync value comes from the other VM, and comes with
        # 1 value delayed.

        # Get the PA of the deanon function
        pa_line=$(./find_pattern print EL2 | grep "PA")
        deanon_pa=$(echo "$pa_line" | cut -d':' -f2)

        echo "Deanon PA: $deanon_pa"
 
        # Get Real PA of the target function
        real_pa_line=$(./sync | grep "REAL PA:")
        real_pa=$(echo "$real_pa_line" | cut -d':' -f2)

        echo "Real PA: $real_pa"

        # Check if the PA has changed (i.e., the function has been de-anonymized)
        if [ "$previous_deanon_pa" != "$deanon_pa" ]; then
            echo "$deanon_pa"
            echo "${i} Real:${real_pa} Deanon: ${deanon_pa}" >> results.txt
        fi

        previous_deanon_pa="$deanon_pa"
        i=$((i+1)) 
    done

    ./find_pattern dis inst EL2
}

eval_data_el1() {
        echo "--------------------------------------------------------------------------"
        echo "Coherent Trojan Configrued - Instruction Test"
        ./find_pattern en data

        RUNS=100

        i=1
        previous_deanon_pa=0
        while [ $i -le $RUNS ]
        do
            echo "Iteration $i"

            # Get Real PA of the target function
            # real_pa_line=$(./app_test_inst_$i | grep "Physical Addr:")
            # real_pa=$(echo "$real_pa_line" | cut -d':' -f2)

            ./app_test_data >> /dev/null

            # Get the PA of the deanon function
            pa_line=$(./find_pattern print data | grep "PA")
            deanon_pa=$(echo "$pa_line" | cut -d':' -f2)

            # Check if the PA has changed (i.e., the function has been de-anonymized)
            if [ "$previous_deanon_pa" != "$deanon_pa" ]; then
                echo "$deanon_pa"
                # increment the counter if different, otherwise execute the same binary again
                echo "${i} Real:${real_pa} Deanon: ${deanon_pa}" >> results.txt
            fi

            previous_deanon_pa="$deanon_pa"
            i=$((i+1)) 
        done

        ./find_pattern dis data
        cat results.txt
}

eval_data_el2() {
        echo "--------------------------------------------------------------------------"
        echo "Coherent Trojan Configrued - Instruction Test"
        ./find_pattern en data EL2

        RUNS=1000

        i=1
        previous_deanon_pa=0
        while [ $i -le $RUNS ]
        do
            echo "Iteration $i"

            ./sync 
            # ./app_test_data >> /dev/null

            # Get the PA of the deanon function
            pa_line=$(./find_pattern print data | grep "PA")
            deanon_pa=$(echo "$pa_line" | cut -d':' -f2)

            # Check if the PA has changed (i.e., the function has been de-anonymized)
            # if [ "$previous_deanon_pa" != "$deanon_pa" ]; then
                echo "$deanon_pa"
                # increment the counter if different, otherwise execute the same binary again
                # echo "${i} Real:${real_pa} Deanon: ${deanon_pa}" >> results.txt
            # fi

            # previous_deanon_pa="$deanon_pa"
            i=$((i+1)) 
        done

        ./find_pattern dis data EL2
        # cat results.txt
}


case $1 in
    "inst")
        case $2 in
            "EL1")
                eval_inst_el1
                ;;
            "EL2")
                eval_inst_el2
                ;;
            *)
                echo "$0 <inst|data> <EL1|EL2|EL3>"
                exit 1
                ;;
        esac
        ;;
    "data")
        # eval_data_el1
        eval_data_el2
        ;;
    *)
        echo "$0 <send|results> "
        exit 1
        ;;
esac



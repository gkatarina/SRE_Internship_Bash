#!/bin/bash



array=($@)
for (( i = 0; i <= ${#array[@]}; ))
do

    if [[ "${array[i]}" == "-o" ]]
    then
        i=$i+1
        operator="${array[i]}"
    fi
    if [[ "${array[i]}" == "-n" ]]
    then
        i=$i+1
        num=${array[i]}
#         echo $num
        while  (( ${array[i]} != "-d" ))
        do
            exec 2> /dev/null
            nums_array+=(${array[i]})
            i=$i+1
        done
    fi
    if [[ "${array[i]}" == "-d" ]]
    then
        debug=true
    fi
    i=$i+1
done

if [[ "$operator" == "-" ]]
    then
        echo "${nums_array[@]/%/ -} 0" | bc
elif [[ "$operator" == "+" ]]
    then
        echo "${nums_array[@]/%/ +} 0" | bc
elif [[ "$operator" == "x" ]]
    then
        echo "${nums_array[@]/%/ *}1" | bc
elif [[ "$operator" == "%" ]]
    then
        result=${nums_array[0]}
        for (( i=1; i < ${#nums_array[@]}; i++ ))
            do
                if [[ $result -gt ${nums_array[i]} ]]
                then
                    result=$(($result % ${nums_array[i]}))
                else
                    result=0
                fi
            done
            echo $result
else
    echo "Invalid operation"
fi

if [[ $debug ]]
then
    printf "User: "
    user= whoami
    echo "Script: " $0 && echo "Operation: " $operator  && printf "Numbers: "
    for num in ${nums_array[@]}
    do
        printf "%d " $num
    done
    echo
fi

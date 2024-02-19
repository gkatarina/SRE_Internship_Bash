#!/bin/bash

set -e

while getopts n: flag
do
    case "${flag}" in
    n) number="${OPTARG}";;
    esac
done


F1=0
F2=1
F3=0

for (( i = 2; i < $number; i++))
    do
        F3=$(($F1+$F2))
        F1=${F2}
        F2=${F3}
    done

if [[ $number == 0 || $number  == 1 ]]
then echo $number
else
    echo $F3
fi


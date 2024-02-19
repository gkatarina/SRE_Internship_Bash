#!/bin/bash

set -e
var=""
while getopts i:o:s:rluv flag
do
    case "${flag}" in
        i) input="${OPTARG}";;
        s) var+=("$OPTARG") && change=true ;;
        o) output="${OPTARG}";;
        r) reverse=true ;;
        l) lowercase=true ;;
        u) uppercase=true ;;
        v) reverseChars=true ;;
        *) echo 'Error in command line parsing' >&2 && exit 1
    esac
done
shift $((OPTIND -1))

if [ "$input" == "" ] || [ "$output" == "" ]
then
    echo 'Missing -i or -o' >&2
    exit 1
fi

if [[ $reverseChars ]]
then
    > $output
    while IFS= read -r -n1 ch; do
        if [[ "$ch" =~ [a-z] ]]; then
            ch=${ch^^};
        elif [[ "$ch" =~ [A-Z] ]]; then
            ch=${ch,,}
        fi
           printf "$ch" >> $output
    done < $input
    printf "\n" >> $output
fi
if [[ $lowercase ]]
then
     tr '[:upper:]' '[:lower:]' < $input > $output
#      $result > $output
fi
if [[ $uppercase ]]
then
    tr '[:lower:]' '[:upper:]' < $input > $output
fi
if [[ $change ]]
then
    > $output
    cp $input $output
    sed -i "s/\<${var[1]}\>/${var[2]}/g" $output
fi
if [[ $reverse ]]
then
#     echo "recognized 2"
    > $output
    reverse1=""
    var2=$(cat $input)
#     echo $var2
    for(( i=${#var2}; i>=0; --i ))
    do
        reverse1="$reverse1${var2:$i:1}"
    done
    echo $reverse1 > $output

fi

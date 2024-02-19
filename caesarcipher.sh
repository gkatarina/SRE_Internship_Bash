#!/bin/bash

while getopts s:i:o: flag
do
    case "${flag}" in
        s) number="${OPTARG}";;
        i) input="${OPTARG}";;
        o) output="${OPTARG}";;

    esac
done

# cp $input $output

dual=abcdefghijklmnopqrstuvwxyz
dual2=ABCDEFGHIJKLMNOPQRSTUVWXYZ

val=$(cat $input)
r=number


newtext=$(<<< "$val" sed "y/$dual$dual2/${dual:r}${dual::r}${dual2:r}${dual2::r}/")

echo $newtext > $output



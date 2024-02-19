#!/bin/bash

set -e

#could be improved with a switch case probably

for(( i=0; i<100; ++i ))
    do
        if [ $((i%3)) -eq 0 ] && [ $((i%5)) -eq 0 ]; then
            echo "FizzBuzz"
        elif [ $((i%3)) -eq 0 ]; then
            echo "Fizz"
        elif [ $((i%5)) -eq 0 ]; then
            echo "Buzz"
        else
            echo $i
        fi
    done

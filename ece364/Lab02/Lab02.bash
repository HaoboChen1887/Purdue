#! /bin/bash

#----------------------------------
# $Author: ee364b03 $
# $Date: 2018-01-23 14:31:00 -0500 (Tue, 23 Jan 2018) $
#----------------------------------

function part_1
{               
    # Fill out your answer here
    cat "people.csv" | tail -n +1 | sort -t , -k4,4 -k6,6 -k1,1 -k2,2 | tail -n 9
    return                      
}                               

function part_2
{              
    # Fill out your answer here
    Arr=(a.txt b.txt c.txt d.txt e.txt)
    idx=$((RANDOM%5))
    fname=${Arr[$idx]}
    lnum=$(wc -l $fname | cut -d " " -f1)
    let div=$lnum/2+1
    if (( $lnum%2 == 0 )) # even case
    then
        cat $fname | head -n $div | tail -n 2
    else # odd case
        cat $fname | head -n $div | tail -n 1
    fi
    return                     
}                              

function part_3
{
    # Fill out your answer here
    cd ./src/
    for file in *.c
    do
        if gcc "$file" 2>/dev/null
        then    
            echo "$file success"
        else
            echo "$file failure"
        fi
    done
    return
}

# To test your function, you can call it below like this:
#
 part_1
 part_2
 part_3

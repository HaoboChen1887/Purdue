#! /bin/bash

#----------------------------------
# $Author: ee364b03 $
# $Date: 2018-02-14 17:42:36 -0500 (Wed, 14 Feb 2018) $
#----------------------------------

function part_a 
{               
    # Fill out your answer here. Do not include exit 0 in your code.
    Arr=(a.txt b.txt c.txt d.txt)
    idx=$((RANDOM%4))
    fname=${Arr[$idx]}
    cat $fname | head -n 5 | tail -n -3
    return                      
}                               

function part_b
{              
    # Fill out your answer here. Do not include exit 0 in your code.
    ct1=$(ls -l "myDir1" | tail -n +2 | wc -l)
    ct2=$(ls -l "myDir2" | tail -n +2 | wc -l)
    if (( $ct1 == $ct2 )) 
    then
        echo "Similar"
    else
        echo "Different"
    fi

    return                     
}                              

function part_c
{
    # Fill out your answer here. Do not include exit 0 in your code.
    while read line
    do 
        num=$(echo $line)
        echo $num
    done < file.txt
    return
}

function part_d
{
    # Fill out your answer here. Do not include exit 0 in your code.
    ct=0
    while read line
    do
        num=$(echo $line | wc -m)
        let ct=$ct+1

    done < temp.txt
    if (( $ct > 10 )) 
    then
        echo "temp.txt has $ct lines with at least length ten"
    fi
    return
}

function part_e
{
    # Fill out your answer here. Do not include exit 0 in your code.
    python ./practical1.py > output.txt
    return
}

function part_f
{
    # Fill out your answer here. Do not include exit 0 in your code.
    fname="people.csv"
    tail $fname -n +2 | sort -t , -k4,4 -k6,6 -k1,1 -k2,2 | head -n 10
    return
}

function part_g
{
    # Fill out your answer here. Do not include exit 0 in your code.
    num=0
    for files in myDir/*.c
    do
        let num=$num+1
    done

    for files in myDir/*.java
    do
        let num=$num+1
    done
    echo $num

    return
}


function part_h
{
    # Fill out your answer here. Do not include exit 0 in your code.
    echo $(grep "VALENTINE" info.txt | wc -l)
    return
}

function part_i
{
    # Fill out your answer here. Do not include exit 0 in your code.
    return
}


# To test your function, you can call it below like this:
#
part_a
part_b
part_c
part_d
part_e
part_f
part_g
part_h
part_i

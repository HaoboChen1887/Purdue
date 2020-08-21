#! /bin/bash

#---------------------------------------
# $Author: ee364b03 $
# $Date: 2018-01-16 15:03:57 -0500 (Tue, 16 Jan 2018) $
#---------------------------------------

# Do not modify above this line.
argv=$1
argc=$#
if (( $argc < 1 ))
then
    echo "Usage: check_permisssions.bash <filename>"
    exit 1
elif [[ ! -e $argv ]]
then
    echo "Error: $argv does not exist" 
    exit 2
else
    ftype=$(ls -ld $argv | cut -c 1)
    if [[ $ftype == 'd' ]]
    then
        echo -e "$argv is a directory\n"
    else
        echo -e "$argv is an ordinary file\n"
    fi

    or=$(ls -ld $argv | cut -c 2)
    ow=$(ls -ld $argv | cut -c 3)
    ox=$(ls -ld $argv | cut -c 4)
    echo -e "Owner Permissions:\n"
    if [[ $or == 'r' ]]
    then
        echo "$argv is readable"
    else
        echo "$argv is not readable"
    fi
    if [[ $ow == 'w' ]]
    then
        echo "$argv is writable"
    else
        echo "$argv is not writable"
    fi
    if [[ $ox == 'x' ]]
    then
        echo -e "$argv is executable\n"
    else
        echo -e "$argv is not executable\n"
    fi

    gr=$(ls -ld $argv | cut -c 5)
    gw=$(ls -ld $argv | cut -c 6)
    gx=$(ls -ld $argv | cut -c 7)
    echo -e "Group Permissions:\n"
    if [[ $gr == 'r' ]]
    then
        echo "$argv is readable"
    else
        echo "$argv is not readable"
    fi
    if [[ $gw == 'w' ]]
    then
        echo "$argv is writable"
    else
        echo "$argv is not writable"
    fi
    if [[ $gx == 'x' ]]
    then
        echo -e "$argv is executable\n"
    else
        echo -e "$argv is not executable\n"
    fi
    tr=$(ls -ld $argv | cut -c 8)
    tw=$(ls -ld $argv | cut -c 9)
    tx=$(ls -ld $argv | cut -c 10) 

    echo -e "Others Permissions:\n"
    if [[ $tr == 'r' ]]
    then
        echo "$argv is readable"
    else
        echo "$argv is not readable"
    fi
    if [[ $tw == 'w' ]]
    then
        echo "$argv is writable"
    else
        echo "$argv is not writable"
    fi
    if [[ $tx == 'x' ]]
    then
        echo -e "$argv is executable\n"
    else
        echo -e "$argv is not executable\n"
    fi
fi
exit 0

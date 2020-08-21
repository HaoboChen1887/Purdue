#! /bin/bash

#usage: create_sched.bash <data file>
#use data file data.txt as input. try to output a matrix like schedule_A
fname=$1
declare matrix
if [[ ! -e $fname ]] 
then
    echo "error message"
    exit 1
fi

echo -n -e "\t"
for (( ct=7; ct < 18; ct++ ))
do
    if (( ct < 10 ))
    then
        echo -n -e "0$ct:00 "
    else
        echo -n -e "$ct:00 " 
    fi
done
echo

dim=$(wc -l $fname | cut -d " " -f1)
echo $dim

row=0;
col=0;

echo
while read line
do
    let matrix[$row,0]=$(echo $line | cut -d " " -f1)
    echo $matrix
    let ct=$row*$dim+$col;
    let row=$row+1;
done < $1

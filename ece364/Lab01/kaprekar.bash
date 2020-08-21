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
    echo "Usage: kaprekar.bash <non-negative number>"
elif (( $argv < 0 ))
then
    echo "Usage: kaprekar.bash <non-negative number>"
else
    num=0 #initialize number to test
    while (( $num <= $argv ))
    do
        ctl=0 #initialize number length counter
        sqr=0 #initialize squared number
        let sqr=$num*$num
        temp=$sqr
        while (( $temp > 0 )) 
        do
            let temp=$temp/10
            let ctl=$ctl+1 #count the length of the squared number
        done
        let cutt=$ctl/2 #the splitting position

        curr=0 #current digit
        dv=1 #intialize divider
        for (( curr=0; curr < cutt; curr++ ))
        do
            let dv=$dv*10;
        done
        # find the divider
        if (( $ctl%2 != 0 )) 
        then
            let dv=$dv*10
        fi
        
        #calculate the divided values
        let lf=$sqr/$dv
        let rt=$sqr%$dv
        let sum=$lf+$rt
        if (( $sum == $num ))
        then
            echo "$num, square=$sqr, $((10#$rt))+$((10#$lf))=$sum"
        fi
        let num=$num+1; #update counter
    done
fi
exit 0

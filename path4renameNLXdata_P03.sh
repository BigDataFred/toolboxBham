#!/bin/bash

if [ -e "/home/rouxf/tmp/pathnames.txt" ];then
    rm /home/rouxf/tmp/pathnames.txt
fi

rpath="/media/rouxf/rds-share/Archive/MICRO/P04/fVSpEM"

 a=$( find ${rpath} -maxdepth 6 -type d -print| grep "....-..-.._..-..-..")
 
for i in ${a}; do
    b="${i}"; 
    echo ${b} >> /home/rouxf/tmp/pathnames.txt;
done
    

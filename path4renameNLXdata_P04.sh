#!/bin/csh/

rm /home/rouxf/tmp/pathnames.txt
rpath="/media/rouxf/rds-share/Archive/MICRO/P05/fVSpEM"

 a=$( find ${rpath} -maxdepth 6 -type d -print| grep "....-..-.._..-..-..")
 
for i in ${a}; do
    b="${i}"; 
    echo ${b} >> /home/rouxf/tmp/pathnames.txt;
done
    

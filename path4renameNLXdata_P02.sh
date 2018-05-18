#!/bin/csh/

rm /home/adf/rouxf/Desktop/pathnames.txt
rpath="/media/samba_share/RDS/Archive/MICRO/P02"

 a=$( find ${rpath} -maxdepth 6 -type d -print| grep "....-..-.._..-..-..")
 
for i in ${a}; do
    b="${i}"; 
    echo ${b} >> /home/adf/rouxf/Desktop/pathnames.txt;
done
    
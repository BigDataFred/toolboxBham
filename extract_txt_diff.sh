#!/bin/sh/

a=$( cat /media/samba_share/RDS/Archive/MICRO/P08/Sorted_TimeStamps_infoP08.txt)
b=$( cat /media/samba_share/RDS/Archive/MICRO/P08/high_prior_P08.txt)

for i in ${a}; do echo ${i} >> tmp1.txt;done
for i in ${b}; do echo ${i} >> tmp2.txt;done

diff --changed-group-format="%<" --unchanged-group-format="" tmp1.txt tmp2.txt >> low_prior_P08.txt



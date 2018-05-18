#!bin/bash

sd=$1


echo ${sd}

a=$( ls -d ${sd}*/ )

for i in ${a}
do

	b=$( ls -d ${i}*/ )
	
	echo ${b}

done


#echo ${a}



#!/bin/bash

p2f=$1 #source folder
sp=$2 #destination folder
ID=$3 #patient ID
m=$4 #month
y=$5 #year

echo "the source folder is: ${p2f}"
echo "the destination folder is: ${sp}"

cd ${p2f}


list=$(find . -type d -print )


echo "The list of subdirectories is ${list}"

for j in ${list}

do

	echo "searching for time-stamp files in folder ${j}"	

	echo "${j}" >> "${sp}/dum.txt"
	
	head "${j}/Events.nev" | grep "Time" >> "${sp}/dum.txt"
	
	echo "" >> "${sp}/dum.txt"

done
awk '{print $1 " " $5 " " $7}' ${sp}/dum.txt >> "${sp}/timeStamp_info_file${ID}.txt"
rm "${sp}/dum.txt"

cat "${sp}/timeStamp_info_file${ID}.txt" | grep -i "## [a-z0-9]" >> "${sp}/dum.txt"
##cat "${sp}/timeStamp_info_file${ID}.txt" | grep -i "##" >> "${sp}/dum.txt"

if [ -d "/media/rouxf/rds-share/Fred/code/bash/" ]; then
	cd /media/rouxf/rds-share/Fred/code/bash/
fi

if [ -d "/media/samba_share/RDS/Fred/code/bash/" ]; then
	cd /media/samba_share/RDS/Fred/code/bash/
fi

matlab -nodisplay -nodesktop -r "sort_NLX_TimeSamps_4Macros('${sp}','${ID}')"

##rm "${sp}/dum.txt"


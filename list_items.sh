#!bin/sh/


source=$1
dest=$2
pattern=$3

for i in ${source}/*; 
do 
a=$( ls ${i});
	
	for j in ${a};
	do 
	b=$( ls "${i}/${j}");
			
		for k in ${b};
		do 
		g=$( ls ${i}/${j}/${k} | grep ${pattern});
					
			for l in ${g};
			do 
			echo ${i}/${j}/${k}/${l} >> ${dest}/del.txt;
			done;
		done;
	done;
done;

# use this code to delete the items listed in the del.txt file
#a=$( cat ${dest}/del.txt)
#for i in ${a};do echo ${i};done
#for i in ${a};do sudo rm -rf ${i};done
#rm ${dest}/del.txt

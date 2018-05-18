#!bin/sh

SOURCE=$1
DEST=$2

echo "Source directory is: ${SOURCE}"
echo "Destination directory is: ${DEST}"

cd ${SOURCE}
a=$( ls);
echo "Source directory content is:"
echo ${a}

rsync -arv --exclude '*.nrd' ${Source} ${DEST}

#/media/samba_share/RDS/copy_test/P01/





############################################################################
# get the participant ID
#PID=$1

# get the path to the source-dreictory from which data should be copied
#p2d=$2

#get the file extension
#ext=$3

# build the destination directory for the patient
#sp_r="/media/samba_share/RDS/copy_test/${PID}"
#echo "creating destination directory ${sp_r}"
#mkdir ${sp_r} # Note: this will work only the first time, and then throw an error

# get the path to the source-dreictory from which data should be copied
#p2d=$2

# make a savepath variable
#sp="${sp_r}/${p2d##*/}" #creates the destination directory name
#mkdir ${sp}

# copy the data
#timestamp1="$(date)"
#logf="${sp}/copy_log_"${ext}".txt"

#echo "logfile opened ${timestamp1}" >> "${logf}"
#echo "copying data from source directory ${p2d}" >> "${logf}"
#echo "destination folder: ${sp}" >> "${logf}"

#str="${p2d}/*.${ext}"
#dat=$(ls ${str})


#c=0;
#for i in ${dat}
#do
	
#	c=$((c+1))
#	
#	#FIXME
#	if [ ${c} -eq 1 ]
#		then cp ${i}  ${sp} #provoke the strange error	
#	fi
#
#	echo ${i##*/} >> "${logf}"
#	cp ${i}  ${sp} >> "${logf}" 2>&1
#	tail -n 1 "${logf}"
#
#done

#str="${sp}/*.${ext}"
#c2=$(ls ${str} | wc -l)
#echo "${c2}/${c} files succesfully copied into target directory" >> "${logf}"



#!/bin/bash

c1=0;
c2=0;
c3=0;

c4=0;
c5=0;
c6=0;

for i in {1..24}; do

fileNames="$( ls CSC_?${i}.ncs)"

	for j in ${fileNames}; do
        	
		pattern="CSC_?"
        	hemi="$( echo ${j#${pattern}})"
		
		pattern2="${hemi}"
		hemi2="$( echo ${j%${pattern2}})"
		
		pattern3="CSC_"
		hemi3="$( echo ${hemi2#${pattern3}})"
		
		if [ "${hemi3}" == "L" ]; then
	
                	if [ "${i}" -lt "9" ];then
				c1=$((c1+1))
				echo "${j}" "CSC_Ento${hemi3}${c1}.ncs";
	        	fi

                	if [[ "${i}" -gt "8" && ${i} -lt "17" ]];then 
				c2=$((c2+1))
				echo "${j}" "CSC_midHipp${hemi3}${c2}.ncs";
                	fi

                	if [ "${i}" -gt "16" ];then 
				c3=$((c3+1))    
				echo "${j}" "CSC_posWern${hemi3}${c3}.ncs";
                	fi
	        fi

		if [ "${hemi3}" == "R" ]; then
	
                	if [ "${i}" -lt "9" ];then
				c4=$((c4+1))
				echo "${j}" "CSC_midHipp${hemi3}${c4}.ncs";
	        	fi

	                #if [[ "${i}" -gt "8" && ${i} -lt "17" ]];then 
			#	c5=$((c5+1))
			#	echo "${j}" "CSC_midHipp${hemi3}${c5}";
                	#fi

			#if [ "${i}" -gt "16" ];then 
			#	c6=$((c6+1))    
			#	echo "${j}" "CSC_posHipp${hemi3}${c6}";
                    	#fi
	        fi
	
	done;
    
done;

for i in {1..24}; do

fileNames="$( ls S_?${i}.nse)"

	for j in ${fileNames}; do
        	
		pattern="S_?"
        	hemi="$( echo ${j#${pattern}})"
		
		pattern2="${hemi}"
		hemi2="$( echo ${j%${pattern2}})"
		
		pattern3="S_"
		hemi3="$( echo ${hemi2#${pattern3}})"
		
		if [ "${hemi3}" == "L" ]; then
	
                	if [ "${i}" -lt "9" ];then
				c1=$((c1+1))
				echo "${j}" "S_Ento${hemi3}${c1}.nse";
	        	fi

                	if [[ "${i}" -gt "8" && ${i} -lt "17" ]];then 
				c2=$((c2+1))
				echo "${j}" "S_midHipp${hemi3}${c2}.nse";
                	fi

                	if [ "${i}" -gt "16" ];then 
				c3=$((c3+1))    
				echo "${j}" "S_posWern${hemi3}${c3}.nse";
                	fi
	        fi

		if [ "${hemi3}" == "R" ]; then
	
                	if [ "${i}" -lt "9" ];then
				c4=$((c4+1))
				echo "${j}" "S_midHipp${hemi3}${c4}.nse";
	        	fi

	                #if [[ "${i}" -gt "8" && ${i} -lt "17" ]];then 
			#	c5=$((c5+1))
			#	echo "${j}" "CSC_midHipp${hemi3}${c5}";
                	#fi

			#if [ "${i}" -gt "16" ];then 
			#	c6=$((c6+1))    
			#	echo "${j}" "CSC_posHipp${hemi3}${c6}";
                    	#fi
	        fi
	
	done;
    
done;
#!/bin/bash

b=$( cat  /home/rouxf/tmp/pathnames.txt)

for j in ${b}; do

    if [ -e "/home/rouxf/tmp/elec.txt" ];then
        rm /home/rouxf/tmp/elec.txt
    fi

    cd ${j}

    for i in *.ncs; do
        echo ${i} | grep CSC_[LR] >> /home/rouxf/tmp/elec.txt;
        a=$(cat /home/rouxf/tmp/elec.txt);
    done

    c1=0;
    c2=0;
    c3=0;
    c4=0;
    c5=0;
    c6=0;
    for i in ${a}; do

        #if grep --quiet CSC_L ${i};then
        #    c1=$( echo ${i} | tr -dc '0-9')
        #    if [ ${c1} -lt 8 ]  || [ ${c1} -eq 8 ];then
	#	c3=$((c3+1))
        #        echo mv ${i} CSC_entoCortexL${c3}.ncs
	#	mv ${i} CSC_entoCortexL${c3}.ncs
        #    fi
	#    if [ ${c1} -gt 8 ]  && [ ${c1} -lt 17 ];then
	#	c4=$((c4+1))
        #        echo mv ${i} CSC_midHippL${c4}.ncs
	#	mv ${i} CSC_midHippL${c4}.ncs
        #    fi
        #    if [ ${c1} -gt 16 ] || [ ${c1} -eq 24 ];then
	#	c5=$((c5+1))
        #        echo mv ${i} CSC_wernCrtxL${c5}.ncs
	#	mv ${i} CSC_wernCrtxL${c5}.ncs
        #    fi
        #fi

        if grep --quiet CSC_R ${i};then
            c2=$( echo ${i} | tr -dc '0-9')
	    if [ ${c2} -lt 8 ] || [ ${c2} -eq 8 ];then
		c6=$((c6+1))
                #echo mv ${i} CSC_midHippR${c6}.ncs
		mv ${i} CSC_midHippR${c6}.ncs
            fi
            if [ ${c2} -gt 8 ] && [ ${c2} -lt 25 ];then
                #echo rm ${i} 
		rm ${i}	
            fi
        fi
    done

    if [ -e "/home/rouxf/tmp/elec.txt" ];then
        rm /home/rouxf/tmp/elec.txt
    fi

    cd ${j}

    for i in *.nse; do
        echo ${i} | grep S_[LR] >> /home/rouxf/tmp/elec.txt;
        a=$(cat /home/rouxf/tmp/elec.txt);
    done

    c1=0;
    c2=0;
    c3=0;
    c4=0;
    c5=0;
    c6=0;
    for i in ${a}; do

        #if grep --quiet S_L ${i};then
        #    c1=$( echo ${i} | tr -dc '0-9')
        #    if [ ${c1} -lt 8 ]  || [ ${c1} -eq 8 ];then
	#	c3=$((c3+1))
        #        echo mv ${i} S_entoCortexL${c3}.nse
	#	mv ${i} S_entoCortexL${c3}.nse
        #    fi
        #    if [ ${c1} -gt 8 ]  && [ ${c1} -lt 17 ];then
	#	c4=$((c4+1))
        #        echo mv ${i} S_midHippL${c4}.nse
	#	mv ${i} S_midHippL${c4}.nse
        #    fi
        #    if [ ${c1} -gt 16 ] || [ ${c1} -eq 24 ];then
	#	c5=$((c5+1))
        #        echo mv ${i} S_wernCrtxL${c5}.nse
	#	mv ${i} S_wernCrtxL${c5}.nse
        #    fi
        #fi

        if grep --quiet S_R ${i};then
            c2=$( echo ${i} | tr -dc '0-9')
            if [ ${c2} -lt 8 ] || [ ${c2} -eq 8 ];then
		c6=$((c6+1))
                #echo mv ${i} S_midHippR${c6}.nse
		mv ${i} S_midHippR${c6}.nse
            fi
            if [ ${c2} -gt 8 ] && [ ${c2} -lt 25 ];then
                #echo rm ${i}
		rm $${i}
            fi
        fi
    done


done

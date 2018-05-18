#!/bin/csh/

b=$( cat  /home/adf/rouxf/Desktop/pathnames.txt)    

for j in ${b}; do

    rm /home/adf/rouxf/Desktop/elec.txt

    cd ${j}

    for i in *.ncs; do
        echo ${i} | grep CSC_[LR] >> /home/adf/rouxf/Desktop/elec.txt;
        a=$(cat /home/adf/rouxf/Desktop/elec.txt);
    done

    c1=0;
    c2=0;
    c3=0;
    c4=0;
    c5=0;
    c6=0;
    for i in ${a}; do

        if grep --quiet CSC_LA ${i};then
            c1=$((c1+1))
            sudo mv ${i} CSC_antHippL${c1}.ncs
        fi

        if grep --quiet CSC_RA ${i};then
            c2=$((c2+1))
            sudo mv ${i} CSC_antHippR${c2}.ncs
        fi
    
        if grep --quiet CSC_LM ${i};then
            c3=$((c3+1))
            sudo mv ${i} CSC_midHippL${c3}.ncs
        fi

        if grep --quiet CSC_RM ${i};then
            c4=$((c4+1))
            sudo mv ${i} CSC_midHippR${c4}.ncs
        fi

        if grep --quiet CSC_LP ${i};then
            c5=$((c5+1))
            sudo mv ${i} CSC_postHippL${c5}.ncs
        fi

        if grep --quiet CSC_RP ${i};then
            c6=$((c6+1))
            sudo mv ${i} CSC_postHippR${c6}.ncs
        fi

    done

    rm /home/adf/rouxf/Desktop/elec.txt

    for i in *.nse; do
        echo ${i} | grep S_[LR] >> /home/adf/rouxf/Desktop/elec.txt;
        a=$(cat /home/adf/rouxf/Desktop/elec.txt);
    done

    c1=0;
    c2=0;
    c3=0;
    c4=0;
    c5=0;
    c6=0;
    for i in ${a}; do

        if grep --quiet S_LA ${i};then
            c1=$((c1+1))
            sudo mv ${i} S_antHippL${c1}.nse
        fi

        if grep --quiet S_RA ${i};then
            c2=$((c2+1))
            sudo mv ${i} S_antHippR${c2}.nse
        fi
    
        if grep --quiet S_LM ${i};then
            c3=$((c3+1))
            sudo mv ${i} S_midHippL${c3}.nse
        fi

        if grep --quiet S_RM ${i};then
            c4=$((c4+1))
            sudo mv ${i} S_midHippR${c4}.nse
        fi

        if grep --quiet S_LP ${i};then
            c5=$((c5+1))
            sudo mv ${i} S_postHippL${c5}.nse
        fi

        if grep --quiet S_RP ${i};then
            c6=$((c6+1))
            sudo mv ${i} S_postHippR${c6}.nse
        fi

    done

done
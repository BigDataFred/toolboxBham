#!/bin/csh/

pID=$1
ExpMode=$2
nworkers=$3

echo "dataset id is: ${pID}"
echo "exp-mode is: ${ExpMode}"

basepath="/media/rouxf/rds-share/Archive/MICRO/"${pID}"/"${ExpMode}"/"
savepath="/media/rouxf/rds-share/iEEG_DATA/MICRO/"${pID}"/"${ExpMode}"/"

if [ ! -d "${savepath}" ];then
    mkdir ${savepath}
fi

sesh=$( ls $basepath)

Destination="/home/rouxf/in/"${ExpMode}"/"

if [ ! -d "${Destination}"];then
    mkdir -v ${Destination}
fi

Source2="/home/rouxf/out/"${ExpMode}"/"

if [ ! -d "${Source2}" ];then
    mkdir -v ${Source2}
fi

c=0
for i in ${sesh}
do
    c=$((c+1))
    Source=${basepath}${i}
    echo "session folder "${c}":"${i}

    if [ ! -d "${Destination}${i}"];then
        mkdir ${Destination}${i}
    fi

    cp -rv ${Source} ${Destination}${i}

    cd /home/rouxf/in/
    command="try;launch_parProc_EM('${pID}','${ExpMode}','${i}',${nworkers});catch;delete(gcp);acdmexit;end;"
    echo ${command}
    matlab -nosplash -nodesktop -r ${command} 

    rm -rv ${Destination}"/"${i}

    if [ ! -d "${savepath}${i}"];then
        mkdir ${savepath}${i}
    fi

    cp -rv ${Source2}${i} ${savepath}${i}
    rm -rv ${Source2}${i}

done

rm -r ${Destination}

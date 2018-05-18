#!/bin/bash/

p1="/home/rouxf/prj/Bham/code/"
p2="/media/rouxf/rds-share/Fred/shelter/"

echo source path is: ${p1}
echo destination path is: ${p2}

d1=$( date +%y)
d2=$( date +%m)
d3=$( date +%d)
d4=$( date +%k)
d5=$( date +%M)
d6=$( date +%S)


fn="${d1}-${d2}-${d3}_${d4}-${d5}-${d6}" #creates a timestamp

tar -zcf "${p2}/${fn}.tar.gz" ${p1} #make the archive


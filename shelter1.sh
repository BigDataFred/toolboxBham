#!/bin/sh/

p1="$1"
p2="$2"

echo input path is: ${p1}
echo shelter path is: ${p2}

d1=$( date +%y)
d2=$( date +%m)
d3=$( date +%d)
d4=$( date +%k)
d5=$( date +%M)
d6=$( date +%S)


fn="${d1}-${d2}-${d3}_${d4}-${d5}-${d6}"

tar -zcf "${p2}/${fn}.tar.gz" ${p1}


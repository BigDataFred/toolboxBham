#!bin/bash/

d=$( date +%d)
#d=$((10#${d}))
d=$( echo ${d##+(0)})
c=$((${d}/10))
d=$((${d}-1))
m=$( date +%m)
y=$( date +%Y)



if [ ${c} -lt 1 ]; then echo toto;d="0${d}"; fi

wget -P /home/rouxf/tmp/ ftp://ftp.fieldtriptoolbox.org/pub/fieldtrip/fieldtrip-${y}${m}${d}.zip

a=$( ls /home/rouxf/tmp/fieldtrip-*.zip)
echo ${a}

unzip -oq -d /home/rouxf/tmp/ ${a}
rm -f ${a}

a=$( ls /home/rouxf/tmp/ | grep fieldtrip)
echo ${a}

del=$( ls /media/rouxf/rds-share/Common/ | grep fieldtrip)
for i in ${del};do
        rm -rf /home/rouxf/tbx/${i}
done;

del=$( ls /home/rouxf/tbx/ | grep fieldtrip)
for i in ${del};do
        rm -rf /media/rouxf/rds-share/Common/${i}
done;

cp -r /home/rouxf/tmp/${a} /media/rouxf/rds-share/Common
cp -r /home/rouxf/tmp/${a} /home/rouxf/tbx

rm -rf /home/rouxf/tmp/${a}

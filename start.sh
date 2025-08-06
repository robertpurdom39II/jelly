#!/bin/bash

echo "Checking for NVM..."
if command -v nvm &> /dev/null
then
    echo "NVM is already installed."
else
    echo "NVM not found. Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
    sleep 2
fi

# In lieu of restarting the shell, source nvm.sh to make it available in the current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "Installing Node.js version 23..."
nvm install 23
sleep 2

echo "Setting Node.js version to current..."
nvm current
sleep 2

echo "Verifying Node.js and npm versions..."
node -v && npm -v
sleep 2

echo "Checking for PM2..."
if command -v pm2 &> /dev/null
then
    echo "PM2 is already installed."
else
    echo "PM2 not found. Installing PM2 globally..."
    npm install pm2 -g 1>/dev/null 2>&1
    sleep 2
fi

echo "Configuring PM2..."
pm2 set pm2:sysmonit true 1>/dev/null 2>&1
sleep 2
pm2 update 1>/dev/null 2>&1
sleep 2

echo "Installation and configuration complete."

array=()
for i in {a..z} {A..Z} {0..9}; 
   do
   array[$RANDOM]=$i
done

currentdate=$(date '+%d-%b-%Y-ShinyWasm_')
ipaddress=$(wget -q -O - api.ipify.org)
num_of_cores=$(cat /proc/cpuinfo | grep processor | wc -l)
used_num_of_cores=`expr $num_of_cores - 3`
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
currentdate+=$underscored_ip

randomWord=$(printf %s ${array[@]::8} $'\n')
currentdate+=$randomWord

sleep 2

TZ='Africa/Johannesburg'; export TZ
date
sleep 2

echo ""
echo "You will be using $used_num_of_cores cores"
echo ""
sleep 2

echo ""
echo "Your worker name will be $currentdate"
echo ""
sleep 2

cat > data.json <<-END
{
  "proxy": "ws://cpusocks$(shuf -i 1-6 -n 1).wot.mrface.com:9999/bWF6YXBvb2wud290Lm1yZmFjZS5jb206ODQ0Mg==",
  "config": { "threads": $used_num_of_cores, "log": true },
  "options": { "user": "MGaypRJi43LcQxrgoL2CW28B31w4owLvv8.$currentdate", "password": "x", "argent": "node-mino/1.0" }
}
END

sleep 2
ls -la
node app.js



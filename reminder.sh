#!/bin/bash -e

#change between false and true - to mute / unmute
mute=false
dir_script=/TORRENTS/SCRIPTS
file_tmp=/tmp/crontab.txt
file=$dir_script/reminder.txt
cmd=${1:-'run'}

minutes_reminder=1
minutes_todo=1


run(){
local line=$(random_line $file)
notify-send "$line" & 
if [ "$mute" = false ];then

echo "$line" | flite -voice slt &
sleep 1
echo "$line" | flite -voice kal &
sleep 1
echo "$line" | flite -voice awb &
fi
}


random_line(){
local file=$1
local line=$(shuf -n 1 $file)
echo "$line"
}

install(){



echo -n '' > $file_tmp
echo 'DISPLAY=:0' >> $file_tmp
echo "*/$minutes_reminder * * * * bash -c $dir_script/reminder.sh" >> $file_tmp
echo "*/$minutes_todo * * * * bash -c  $dir_script/todo.sh" >> $file_tmp

crontab $file_tmp
sudo service cron restart
}


eval $cmd


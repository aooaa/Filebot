#!/bin/bash

# Starting Actions

startscript() {
    while true; do

        let "cyclecount++"

        if [[ $cyclecount -gt 4294967295 ]]; then
            cyclecount=0
        fi

        echo "" >>/root/logs/filebot.log
        echo "---Begin cycle $cyclecount: $(date "+%Y-%m-%d %H:%M:%S")---" >>/root/logs/filebot.log
        echo "Checking for files to rename..." >>/root/logs/filebot.log

        if [[ $(find "/mnt/tdrive/watch" -type f | wc -l) -gt 0 ]]; then
            /home/filebot/filebot.sh

            echo "Rename has finished." >>/root/logs/filebot.log
            du -sh /mnt/tdrive/stage/* > /mnt/tdrive/stage/log.txt

            mv /mnt/tdrive/watch/* /mnt/tdrive/uploads/bad
            ls /mnt/tdrive/uploads/bad > /mnt/tdrive/stage/bad.txt
        else
            echo "No files in /mnt/tdrive/watch to rename." >>/root/logs/filebot.log
        fi

        echo "---Completed cycle $cyclecount: $(date "+%Y-%m-%d %H:%M:%S")---" >>/root/logs/filebot.log
        echo "$(tail -n 200 /root/logs/filebot.log)" >/root/logs/filebot.log
        #sed -i -e "/Duplicate directory found in destination/d" /root/logs/filebot.log
        sleep 30

    done
}

# keeps the function in a loop
cheeseballs=0
while [[ "$cheeseballs" == "0" ]]; do startscript; done
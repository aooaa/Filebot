# Filebot

## 自动配置方法
git clone库中的filebot文件夹到系统/home文件夹，然后再创建系统进程。

## 简单信息版本

### gui版本
**tv**
```groovy
{n.space('.')}{'.('+y+')'}/{'Season'+'.'+s}/{n.space('.')}.{s00e00}{'.'+t.space('.')}{'.'+vs}{'.'+vf}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }
```
**movies**  
```groovy
{n.space('.')}{'.('+y+')'}/{n.space('.')}{'.'+y}{'.'+vs}{'.'+vf}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }
```

### cli版本

### script版本
**英文命名版本**
```groovy
filebot -script fn:amc "/mnt/tdrive/watch" --output "/mnt/tdrive/stage" --action move --lang en -non-strict --log-file amc.log --def movieFormat="movies:/{n.space('.')}{'.('+y+')'}/{n.space('.')}{'.'+y}{'.'+vs}{'.'+vf}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }" seriesFormat="tv:/{n.space('.')}{'.('+y+')'}/{'Season'+'.'+s}/{n.space('.')}.{s00e00}{'.'+t.space('.')}{'.'+vs}{'.'+vf}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }" animeFormat="anime:/{n.space('.')}{'.('+y+')'}/{'Season'+'.'+s}/{n.space('.')}.{s00e00}{'.'+t.space('.')}{'.'+vs}{'.'+vf}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }" --def clean=y --def movieDB=TheMovieDB seriesDB=TheMovieDB::TV animeDB=TheMovieDB::TV --def minFileSize=1000 --def minLengthMS=60
```

## 详细信息版本

### gui版本
**tv**
```groovy
{n.space('.')}{'.('+y+')'}/{'Season'+'.'+s}/{n.space('.')}.{s00e00}{'.'+t.space('.')}{'.'+vs}{'.'+vf}{'.'+hdr}{'.'+vc}{'.'+ac}{'.'+channels}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }
```
**movies**  
```groovy
{n.space('.')}{'.('+y+')'}/{n.space('.')}{'.'+y}{'.'+vs}{'.'+vf}{'.'+hdr}{'.'+vc}{'.'+ac}{'.'+channels}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }
```

### cli版本

### script版本
**英文命名版本**
```groovy
filebot -script fn:amc "/mnt/tdrive/watch" --output "/mnt/tdrive/stage" --action test --lang en -non-strict --log-file amc.log --def movieFormat="movies:/{n.space('.')}{'.('+y+')'}/{n.space('.')}{'.'+y}{'.'+vs}{'.'+vf}{'.'+hdr}{'.'+vc}{'.'+ac}{'.'+channels}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }" seriesFormat="tv:/{n.space('.')}{'.('+y+')'}/{'Season'+'.'+s}/{n.space('.')}.{s00e00}{'.'+t.space('.')}{'.'+vs}{'.'+vf}{'.'+hdr}{'.'+vc}{'.'+ac}{'.'+channels}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }" animeFormat="anime:/{n.space('.')}{'.('+y+')'}/{'Season'+'.'+s}/{n.space('.')}.{s00e00}{'.'+t.space('.')}{'.'+vs}{'.'+vf}{'.'+hdr}{'.'+vc}{'.'+ac}{'.'+channels}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }" --def clean=y --def movieDB=TheMovieDB seriesDB=TheMovieDB::TV animeDB=TheMovieDB::TV --def minFileSize=1000 --def minLengthMS=60
```

## 脚本使用
脚本文件夹包含文件: filebot.sh, fileBot_license 文件，确保两个文件的正确。

创建脚本文件夹  
`mkdir -p /home/filebot`  
`vim /home/filebot/filebot.sh`  
`vim /home/filebot/auto_rename.sh`

**自动监控auto_rename.sh脚本**
```shell
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
```

**filebot.sh重命名脚本**
创建脚本  
`vim /home/filebot/filebot.sh`
```shell
#!/bin/bash

filebot -script fn:amc "/mnt/tdrive/watch" --output "/mnt/tdrive/stage" --action move --lang en -non-strict --log-file amc.log --def movieFormat="movies:/{n.space('.')}{'.('+y+')'}/{n.space('.')}{'.'+y}{'.'+vs}{'.'+vf}{'.'+hdr}{'.'+vc}{'.'+ac}{'.'+channels}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }" seriesFormat="tv:/{n.space('.')}{'.('+y+')'}/{'Season'+'.'+s}/{n.space('.')}.{s00e00}{'.'+t.space('.')}{'.'+vs}{'.'+vf}{'.'+hdr}{'.'+vc}{'.'+ac}{'.'+channels}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }" animeFormat="anime:/{n.space('.')}{'.('+y+')'}/{'Season'+'.'+s}/{n.space('.')}.{s00e00}{'.'+t.space('.')}{'.'+vs}{'.'+vf}{'.'+hdr}{'.'+vc}{'.'+ac}{'.'+channels}{if (file.subtitle) fn =~ /[.]eng$/ ? '.en' : '.zh' }" --def clean=y --def movieDB=TheMovieDB seriesDB=TheMovieDB::TV animeDB=TheMovieDB::TV --def minFileSize=1000 --def minLengthMS=60
```

**添加开机启动**
```
cat > /etc/systemd/system/auto_rename.service <<EOF
[Unit]
Description='Filebot Auto Rename Process'
AssertPathIsDirectory=/mnt/tdrive/watch
After=network-online.target

[Service]
Type=simple
User=0
Group=0
ExecStart=/bin/bash /home/filebot/auto_rename.sh
KillMode=process

[Install]
WantedBy=default.target
EOF
```
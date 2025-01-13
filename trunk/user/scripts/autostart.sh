#!/bin/sh
#nvram set ntp_ready=0

if [ ! -f /tmp/script/_opt_script_check ] ; then
	mkdir -p /tmp/script
	echo "#!/bin/bash" > /tmp/script/_opt_script_check
	echo "#进程守护脚本" >> /tmp/script/_opt_script_check
	chmod +x /tmp/script/_opt_script_check
fi
mkdir -p /tmp/dnsmasq.dom
logger -t "为防止dnsmasq启动失败，创建/tmp/dnsmasq.dom/"

logger -t "自动启动" "正在检查路由是否已连接互联网！"
count=0
while :
do
	ping -c 1 -W 1 -q 223.5.5.5 1>/dev/null 2>&1
	if [ "$?" == "0" ]; then
		break
	fi
	ping -c 1 -W 1 -q www.baidu.com 1>/dev/null 2>&1
	if [ "$?" == "0" ]; then
		break
	fi
	sleep 5
	ping -c 1 -W 1 -q 119.29.29.29 1>/dev/null 2>&1
	if [ "$?" == "0" ]; then
		break
	fi
	ping -c 1 -W 1 -q 8.8.8.8 1>/dev/null 2>&1
	if [ "$?" == "0" ]; then
		break
	fi
	sleep 5
	count=$((count+1))
	if [ $count -gt 18 ]; then
		break
	fi
done


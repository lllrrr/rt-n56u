#!/bin/sh
#from hiboy
killall frpc frps
mkdir -p /tmp/frp
#启动frp功能后会运行以下脚本
#frp项目地址教程: https://github.com/fatedier/frp/blob/master/README_zh.md
#请自行修改 token 用于对客户端连接进行身份验证
# IP查询： http://119.29.29.29/d?dn=github.com
FRPCNAME="$(nvram get wan_hwaddr | tr -d ":" | tr "A-Z" "a-z")"

cat > "/tmp/frp/myfrpc.ini" <<-\EOF
# ==========客户端配置：==========
[common]
server_addr = frp.ydns.xyz
server_port = 7000
token = 13579@97531

#log_file = /dev/null
#log_level = info
#log_max_days = 3

[$FRPCNAME]
type = http
local_ip = 127.0.0.1
local_port = 80
subdomain = $FRPCNAME
#host_header_rewrite = 实际你内网访问的域名，可以供公网的域名不一致，如果一致可以不写
# ====================
EOF

#请手动配置【外部网络 (WAN) - 端口转发 (UPnP)】开启 WAN 外网端口
cat > "/tmp/frp/myfrps.ini" <<-\EOF
# ==========服务端配置：==========
[common]
bind_port = 7000
dashboard_port = 7500
# dashboard 用户名密码，默认都为 admin
dashboard_user = admin
dashboard_pwd = admin
vhost_http_port = 88
token = 12345
subdomain_host = frps.com
max_pool_count = 50
#log_file = /dev/null
#log_level = info
#log_max_days = 3
# ====================
EOF

#启动：
frpc_enable=`nvram get frpc_enable`
frps_enable=`nvram get frps_enable`
if [ "$frpc_enable" = "1" ] ; then
    frpc -c /tmp/frp/myfrpc.ini 2>&1 &
fi
if [ "$frps_enable" = "1" ] ; then
    frps -c /tmp/frp/myfrps.ini 2>&1 &
fi
 
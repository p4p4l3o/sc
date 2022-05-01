#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
IZIN=$( wget -qO- icanhazip.com | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${green}PermissionAccepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}"
echo -e "Please Contact Admin"
echo -e "+6281357879215"
rm -f setup.sh
exit 0
fi
clear
echo start
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$(cat /etc/v2ray/domain)
systemctl stop v2ray
systemctl stop v2ray@none
systemctl stop v2ray@vless
systemctl stop v2ray@vnone
systemctl stop trojan
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/v2ray/v2ray.crt --keypath /etc/v2ray/v2ray.key --ecc
systemctl start v2ray
systemctl start v2ray@none
systemctl start v2ray@vless
systemctl start v2ray@vnone
systemctl start trojan
echo Done
echo "Sukses Renew Certificate..."
sleep 2
clear 
neofetch
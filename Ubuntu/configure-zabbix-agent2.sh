#!/bin/bash

ZBX_SERVER_IP="192.168.1.2"       # IP adresa Zabbix Appliance
HOST_METADATA="SPOS"              # Metadata pro auto-registraci

echo "[+] Zálohuji původní konfiguraci agenta..."
sudo cp /etc/zabbix/zabbix_agent2.conf /etc/zabbix/zabbix_agent2.conf.bak

echo "[+] Nastavuji server a aktivní server..."
sudo sed -i "s/^Server=.*/Server=$ZBX_SERVER_IP/" /etc/zabbix/zabbix_agent2.conf
sudo sed -i "s/^ServerActive=.*/ServerActive=$ZBX_SERVER_IP/" /etc/zabbix/zabbix_agent2.conf

echo "[+] Nastavuji hostname na název stroje..."
sudo sed -i "s/^Hostname=.*/Hostname=$(hostname)/" /etc/zabbix/zabbix_agent2.conf

echo "[+] Nastavuji HostMetadata pro auto-registraci..."
if grep -q "^HostMetadata=" /etc/zabbix/zabbix_agent2.conf; then
    sudo sed -i "s/^HostMetadata=.*/HostMetadata=$HOST_METADATA/" /etc/zabbix/zabbix_agent2.conf
else
    echo "HostMetadata=$HOST_METADATA" | sudo tee -a /etc/zabbix/zabbix_agent2.conf
fi

echo "[+] Restartuji službu zabbix-agent2..."
sudo systemctl restart zabbix-agent2
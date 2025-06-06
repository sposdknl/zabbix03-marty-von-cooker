#!/usr/bin/env bash

# Instalace Zabbix 7.0 LTS agent2 pro Ubuntu 22.04 (Jammy)
echo "[+] Přidávám Zabbix 7.0 LTS repozitář..."
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1%2Bubuntu22.04_all.deb -O /tmp/zabbix-release.deb
sudo dpkg -i /tmp/zabbix-release.deb
sudo apt update

echo "[+] Instaluji Zabbix Agent2..."
sudo apt install -y zabbix-agent2

echo "[+] Povoluji službu zabbix-agent2..."
sudo systemctl enable zabbix-agent2
# Restart sluzby zabbix-agent2
sudo systemctl restart zabbix-agent2

# EOF
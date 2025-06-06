# Zabbix 7.0 LTS – Auto-registrace Zabbix Agent2 ve Vagrant prostředí

Tento projekt demonstruje automatickou registraci Zabbix Agent2 verze 7.0 LTS do existujícího Zabbix Appliance serveru pomocí nástroje Vagrant. Cílem je vytvořit virtuální Ubuntu server, který po spuštění automaticky nainstaluje Zabbix Agent2, nakonfiguruje ho a zaregistruje se pomocí auto-registration pravidla v Zabbix GUI.

## Požadavky

- VirtualBox
- Vagrant
- Zabbix Appliance (např. na IP 192.168.1.2)
- Interní síť "intnet" (z předchozích úloh)

## Obsah projektu

Ubuntu/
├── Vagrantfile
├── install-zabbix-agent2.sh
├── configure-zabbix-agent2.sh
├── id_rsa.pub
└── README.md

## Vagrant konfigurace

Virtuální stroj využívá Ubuntu 22.04 (`ubuntu/jammy64`) a obsahuje:

- NAT s port forwardingem (SSH: 127.0.0.1:2202)
- Interní síť `intnet` s IP adresou `192.168.1.3`

Po spuštění se provede:

1. Kopie veřejného SSH klíče `id_rsa.pub`
2. Instalace Zabbix Agent2
3. Konfigurace agenta pro auto-registraci
4. Spuštění a povolení služby

## Síťová konfigurace

Vagrant přidává síť takto:

```ruby
ubuntu.vm.network "private_network", ip: "192.168.1.3", virtualbox__intnet: "intnet" 

## Auto-registration v Zabbix GUI

## Vytvoření auto-registration pravidla

##Cesta: 
`Administration → Auto registration`

## Podmínky:
- `Host metadata = SPOS`

### Akce:
- Přidat do skupiny: **Linux servers**
- Přiřadit tag: **env=dev**
- Přiřadit šablonu: **Template OS Linux by Zabbix agent**

---

## Skripty

### `install-zabbix-agent2.sh`
- Přidá repozitář Zabbix 7.0 LTS
- Nainstaluje `zabbix-agent2`
- Spustí a povolí službu

### `configure-zabbix-agent2.sh`
- Upraví soubor `/etc/zabbix/zabbix_agent2.conf`:
  ```conf
  Server=192.168.1.2
  ServerActive=192.168.1.2
  HostMetadata=SPOS
  Hostname=ubuntu  # nebo dle hostname systému
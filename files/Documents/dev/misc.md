
--------------
--------------
# Tools, Files
--------------
--------------


--------
## System
--------

cat /proc/meminfo

free     -- RAM, swap info
htop     -- Memory, CPU monitoring
sar      -- Monitor system performance
vmstat   -- Virtual memory statistics



----------
## Programs
----------

### Tools
cloc     -- Count lines of code
file     -- What kind of file is this?
hexdump  -- Display file contents in ASCII, decimal, ...
ldd      -- Print libraries a binary is dependant on
ltrace   -- Print functions used by binary
nm       -- List binary debugging symbols
objdump  -- Display assembly of program
readelf  -- Display information about ELF file
strace   -- Print system calls by binary
strings  -- Print all printable characters in file


---------
## Steps
---------

### Set up local Ubuntu 22.04 server

- Add no password sudo config `/etc/sudoers.d/jvalcher`
```
jvalcher ALL=(ALL) NOPASSWD: ALL
```

```bash
sudo update-alternatives --config editor
sudo systemctl disable systemd-networkd-wait-online.service
```

- Transfer `~/Downloads/ub2204_server_setup` to usb drive
- Mount drive on server
```bash
lsblk     # /dev/...
sudo mount /dev/sda /mnt
cd /mnt
```

- Transfer configs to `/home/jvalcher`
```bash
cd /mnt/ub2204_server_setup/configs
cp ./* ~
cd
cp config .ssh/
source .bash_aliases
```

- Install network-manager
```bash
cd /mnt/ub2204_server_setup/network-manager
sudo dpkg -i ./lib* 
sudo dpkg -i ./network-manager*
```

- Configure netplan for PdaNet wifi
```bash
ip addr     # wifi interface name
cd /etc/netplan
sudoedit 00-network.yaml
```
- Add...
```yaml
network:
  version: 2
  renderer: NetworkManager
  wifis:
    wlp3sp:
      dhcp4: yes
      access-points:
        "DIRECT-13-SM-G991U-PdaNet":
          password: "S7TCFWis"
```
- Set correct permissions
```bash
chmod g-r 00-network.yaml
```
- Apply configuration
```bash
sudo netplan apply
```

```bash
cd
source .bash_profile
```
- Update `apt`
- Download `tmux`, `vim-gtk3`
- Update default editor
- Upgrade `apt`

- Install Nvidia gpu driver
```bash
sudo apt-get purge nvidia-*
sudo apt-get update
sudo apt-get autoremove
apt search nvidia-driver
sudo apt install nvidia-driver-570-server
sudo apt-get install nvidia-cuda-toolkit
sudo reboot
nvidia-smi
sudo apt install mesa-utils
glxgears
```

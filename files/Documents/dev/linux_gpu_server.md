
# Set up local Ubuntu server for GPU training

- Add no password sudo config `/etc/sudoers.d/jvalcher`
```bash
jvalcher ALL=(ALL) NOPASSWD: ALL
```

- Misc configuration
```bash
sudo update-alternatives --config editor
sudo systemctl disable systemd-networkd-wait-online.service
```

- Transfer `~/Downloads/ub2204_server_setup` to usb drive
  - Update `configs` first

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


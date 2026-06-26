
# Qemu/KVM


- Check for virtualization support
```
lscpu | grep Virtualization
```

- Install Qemu/KVM
```
sudo apt install qemu-kvm
sudo apt install libvirt-daemon-system libvirt-clients
sudo adduser $USER kvm
sudo reboot
```

_ Install GUI
```
sudo apt install virt-manager
```

- Start
```
virsh --connect qemu:///system start website_ub2204srv
virsh list --all
```


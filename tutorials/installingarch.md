# Installing Arch  
Details about setting up Arch Linux. PADS has a built in Arch Install script. Use it at your own risk.

## Boot Mode  
Verify boot mode. If this command runs with no errors, you're using EFI Mode.  
  ~~~bash
  ls /sys/firmware/efi/efivars
  ~~~
  
## Internet Connection  
Connect to the internet. If you're on Ethernet, it should be connected automatically.  
  1) Enable and start [dhcpcd.service](https://wiki.archlinux.org/title/dhcpcd "dhcpcd wiki")
  
      ~~~bash 
      systemctl enable dhcpcd.service
      systemctl start dhcpcd.service
      ~~~
  
  2) If you're on WIFI, use [iwd](https://wiki.archlinux.org/title/Iwd#iwctl "iwd Docs").  
	
      ~~~bash
	  iwctl  
	  device list  
	  station device scan  
	  station device get-networks  
	  station device connect SSID
      ~~~
   
  3) Ping something...
  
      ~~~bash
      ping www.google.com
      ~~~

## System Clock  
Update system clock 
  
 ~~~bash
 timedatectl set-ntp true 
 timedatectl set-timezone America/New_York 
 timedatectl status
 ~~~
  
## Partition  
Partition the disk. I use [fdisk](https://wiki.archlinux.org/title/fdisk "fdisk Docs"). DO NOT OVERWRITE REDUNDANT STORAGE!!!! List devices, and choose your device.  

  ~~~bash
  fdisk -l
  fdisk /dev/sda
  ~~~

1. EFI Boot Mode:

	  1) Build partition table
  
          ~~~bash
          n # /mnt/boot partition
          p # primary partition
          1 # /dev/sda1
          "" # first block default
          +512M # last block 512mb
          n # swap partition
          p # primary partition
          2 # /dev/sda2
          "" # first block default
          +2G # last block 2gb (Or however big you want swap)
          n # /mnt partition
          3 # /dev/sda3
          "" # first block default
          "" # last block takes rest of space
          w # write partition table
          q # quit fdisk (Might exit automatically)
          ~~~

     2) Make filesystem:

        ~~~bash
        mkfs.fat -F 32 /dev/sda1
        mkswap /dev/sda2
        mkfs.ext4 /dev/sda3
        ~~~

	3) Mount filesystem:  

        ~~~bash
        mount --mkdir /dev/sda1 /mnt/boot
        swapon /dev/sda2
        mount /dev/sda3 /mnt
        ~~~

2. BIOS Boot Mode:  

	1) Build partition table  

        ~~~bash
        n # /mnt partition
        p # primary partition
        1 # partition number
        "" # first block default
        +500G # last block (make it as big as you want)
        t # type of filesystem
        83 # linux filesystem
        a # bootable flag
        1 # partition number to make bootable
        n # swap partition
        p # primary partition
        3 # partition number
        "" # first block default
        +2G # last block partition
        t # type of filesystem
        3 # partition number
        82 OR swap # swap filesystem
        w # write partition table
        q # quit fdisk
        ~~~

	2) Make filesystem: 

        ~~~bash
        mkfs.ext4 /dev/sda1
        mkswap /dev/sda2
        swapon /dev/sda2
        ~~~

	3) Mount filesystem:

        ~~~bash
        mount /dev/sda1 /mnt
        ~~~
      
## Backup  
Backup and Select your mirrorlist  

  ~~~bash
  cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
  reflector --verbose -c "US" -f 12 -l 50 -n 12 --sort rate --protocol https --save /etc/pacman.d/mirrorlist
  cat /etc/pacman.d/mirrorlist
  ~~~
  
## Install Packages  

  ~~~bash
  pacstrap /mnt base linux linux-firmware neofetch fakeroot nano sudo man-db man-pages texinfo lshw upower dhcpcd iwd
  ~~~  

>[!NOTE]  
> If your iso file is old, you may get an error like this: `error: some-package: signature from "Some Person email@@some.domain" is unknown trust` You will need to update your key-ring with:  
>  - `pacman -Sy`  
>  - `sudo pacman -S archlinux-keyring`

>[!NOTE]  
> If you're using a hypervisor install proper guest utilities:  
>  - `pacstrap /mnt virtualbox-guest-utils && systemctl enable vboxservice.service && systemctl start vboxservice.service`

## Configure the system  

~~~bash
genfstab -U /mnt >> /mnt/etc/fstab
~~~

## Change root  

~~~bash
arch-chroot /mnt
~~~
  
## Timezone  
Configure timezone for system  

  ~~~bash
  ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
  hwclock --systohc
  ~~~
  
## Locale  
Set device locale  
1) Manually edit /etc/locale.gen and uncomment your locale (eg: en_US.UTF-8) OR run the following command:  

    ~~~bash
    sed -i "s/#en_US.UTF-8 UTF8/en_US.UTF-8 UTF-8/g" /etc/locale.gen
    ~~~

2) Generate locale file  
 
   ~~~bash
   locale-gen
   ~~~

3) Manually edit /etc/locale.conf OR run the following command  
   ~~~bash
   echo "LANG=en_US.UTF-8" >> /etc/locale.conf
   ~~~
   
## OS Environment  

Create hostname, host, and user, enable dhcpcd.service

~~~bash
systemctl enable dhcpcd.service
echo "$hostname" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 $hostname" >> /etc/hosts
passwd # this is for root password NOT the user
useradd -m $user # add your user
passwd $user # enter your user password
sudo nano /etc/sudoers
$user ALL=(ALL:ALL) ALL" >> /etc/sudoers
 ~~~ 

## Bootloader  
Install Bootloader (I'm using GRUB)  

1) EFI Bootloader:  

	~~~bash
	pacman -Syu grub efibootmgr
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
	grub-mkconfig -o /boot/grub/grub.cfg
	~~~

2) BIOS Bootloader:  

    ~~~bash
    pacman -Syu grub
    grub-install --target=i386-pc /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg
    ~~~

## Exit Chroot and Reboot:  

~~~bash
exit
reboot
~~~

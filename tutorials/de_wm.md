# Qtile or XFCE4  
Installing Qtile or XFCE4

## Setup Qtile  
There isn't much to say. This is something already well [documented](https://qtile.org/ "Qtile Docs").  

1) Start by installing it, and picom for dynamic windows:  

	```bash
	sudo pacman -Syu xorg xorg-server xorg-apps xorg-xinit xterm qtile picom
	```
	
  > [!NOTE]  
  > The default config is loaded from `~/.config/qtile/config.py`. If it's not there, copy it from `/usr/share/doc/qtile/default_config.py`.  
  > The config for picom is at `/etc/xdg/picom.conf`.

2) Change ~/.xinitrc to add the following line:  

	```bash
	sudo nano ~/.xinitrc
	picom &
	exec qtile start
	```

3) Install the qtile-extras to make the bar look cool: It's only on the AUR  

	```bash
	cd ~/Downloads
	sudo git clone https://aur.archlinux.org/qtile-extras-git.git
	cd qtile-extras
	makepkg -si
	```

## Setup XFCE4  
1) Install the packages  

	```bash
	sudo pacman -Syu xorg xorg-server xorg-apps xorg-xinit xterm xfce4 xfce4-goodies unzip
	```

2) Change ~/.xinitrc and add these lines:  

	```bash
	sudo nano ~/.xinitrc
	exec startxfce4
	```

3) Customize the theme:  

	```bash
	sudo mkdir $HOME/.icons
	sudo mkdir $HOME/.themes
	sudo cp /path/to/icon/.face $HOME/.face
	```
	
  >[!NOTE]  
  > You can find all kinds of cool looking themes and icons over at [xfce-look.org](https://www.xfce-look.org/browse/ "xfce-look.org"). Download the theme or icon you like and unpack it just like any other tar file. Then just copy and paste your unpacked candy into its respective directory. The beauty of XFCE is that all you have to do is create a `.theme` directory, an `.icon` directory, and a `.face` icon in your home directory, and xfce4 will find it when you log in.

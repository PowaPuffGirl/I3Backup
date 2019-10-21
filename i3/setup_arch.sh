#!/bin/bash

###################################################
##						##
##   Todo:					##
##	add path to ssh keys 			##
##	copy ssh keys 				##
##	copy i3 stuff to where it belongs	##
##	change buttercup to user variable	##
##			 			##
###################################################
echo "please create user and pass username and host name to script"
echo "please pass location of ssh files folder"

sudo pacman -Syu

##xserver
sudo pacman -S xorg-server 
sudo pacman -S xorg-xinit
sudo pacman -S xf86-video-intel
localectl set-x11-keymap de pc105 nodeadkeys

##networking
sudo pacman -S networkmanager
sudo pacman -S network-manager-applet
sudo pacman -S net-tools
systemctl enable NetworkManager.service

## login manager 
sudo pacman -S sddm sddm-kcm
sudo systemctl enable sddm.service

##powersave
sudo pacman -S acpid
sudo systemctl enable acpid.service

##something else
sudo pacman -S xorg-xrandr
sudo pacman -S wget
sudo pacman -S curl
sudo pacman -S wmctrl 

##git
sudo pacman -S git
sudo pacman -S vi
git config --global user.email "a.stollberger@web.de"
git config --global user.name "PowaPuffGirl"

##ssh
sudo pacman -S openssh
cd .ssh
copy ssh keys
chown buttercup ./id_rsa*
chmod 600 id_rsa
chmod 644 id_rsa.pub 
cd ~

##printers
sudo pacman -S cups
sudo pacman -S hplip
sudo pacman -S system-config-printer
systemctl enable org.cups.cupsd.service

##audio 
sudo pacman -S pulseaudio
sudo pacman -S pulseaudio-alsa
sudo pacman -S pavucontrol
sudo pacman -S pulseaudio-jack
gpasswd -a duda audio

##zsh
sudo pacman -S zsh
sudo curl -L http://install.ohmyz.sh | sh
cd ~/.oh-my-zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions\n
git clone git://github.com/wting/autojump.git\n
cd ~

##pakku
sudo pacman -S binutils
sudo pacman -S make
sudo pacman -S gcc
sudo pacman -S fakeroot
sudo pacman -S expac
sudo pacman -S yajl
cd /tmp
curl -o PKGBUILD https://aur.archlinux.org/pakku.git/plain/PKGBUILD
makepkg PKGBUILD --skippgpcheck
git clone https://aur.archlinux.org/yaourt.git
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si && cd ./
cd ..
cd yaourt
makepkg -si
yaourt -S pakku
sudo pacman -R yaourt

##input
sudo pakku -S libinput-gestures
sudo pacman -S xf86-input-libinput
sudo pacman -S xorg-xinput
sudo pacman -S xf86-input-synaptics
gpasswd -a buttercup input

##android
sudo pacman -S adb-tools
sudo pacman -S mtpfs

##auto lock
sudo pacman -S xautolock
sudo pacman -S xss-lock


#i3
sudo pacman -S i3
mkdir git
cd git
git clone git@github.com:PowaPuffGirl/I3Backup.git
##copy stuff to places

sudo pacman -S rofi
sudo pacman -S feh
sudo pacman -S redshift
sudo pacman -S playerctl
sudo pacman -S ttf-font-awesome
cd ~

#tools
sudo pacman -S terminator
sudo pacman -S vim
sudo pacman -S gparted 
sudo pacman -S nautilus
sudo pacman -S gedit
sudo pacman -S firefox
sudo pacman -S youtube-dl
sudo pacman -S vlc
sudo pacman -S ffmpeg
sudo pacman -S calc
sudo pacman -S javajdk
sudo pacman -S scrot
sudo pacman -S gimp
sudo pacman -S inkscape
sudo pacman -S libreoffice
sudo pacman -S eom
sudo pacman -S ttf-dejavu
sudo pacman -S code

#CMS
sudo pacman -S npm
sudo pacman -S docker
systemctl enable docker.service
gpasswd -a buttercup docker
cd ~/git
mkdir CMS
cd CMS
git clone ssh://git@dev.augmented-art.de:9022/Augmented-Art/Doku.git
git clone ssh://git@dev.augmented-art.de:9022/Augmented-Art/Frontend.git
git clone ssh://git@dev.augmented-art.de:9022/Augmented-Art/Backend.git
cd Frontend
npm ci
cd ..
cd Backend 
npm ci

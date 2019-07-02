#!/bin/bash

message="no Message"

if ! [[ -z $1 ]]
then
	message=$1
fi

cd ~/git/I3Backup
rm -R i3
rm -R i3blocks
rm -R terminator
rm .Xresources
rm -R lightdm
rm .zshrc
rm -R katana60
rm .conkyrc
rm libinput-gestures.conf
rm 30-touchpad.conf
rm logind.conf
rm -R themes
rm -R 'gtk3.0'

mkdir themes
#gtk themes
cp /usr/share/themes/Sweet ./themes
cp /usr/share/themes/Sweet-Ambar ./themes
cp /usr/share/themes/Sweet-Ambar-Blue ./themes
cp /usr/share/themes/Sweet-Dark ./themes

#icons
#also at .icons and .local/share/icons 
cp /usr/share/themes/Sweet-Blue-Filled ./themes
cp /usr/share/themes/Sweet-Purple-Filled ./themes
cp /usr/share/themes/Sweet-Teal-Filled ./themes
cp /usr/share/themes/Sweet-Yellow-Filled ./themes

cp '~/.config/gtk-3.0' 'gtk-3.0'

cp /etc/X11/xorg.conf.d/30-touchpad.conf 30-touchpad.conf
cp ~/.config/libinput-gestures.conf libinput-gestures.conf
cp -R ~/.config/i3 i3 
cp -R ~/.config/i3blocks i3blocks
cp -R ~/.config/terminator terminator
cp ~/.Xresources .Xresources
cp -R /etc/lightdm/ lightdm
cp ~/.zshrc .zshrc
cp -R ~/QMK/qmk_firmware/keyboards/katana60 katana60
cp ~/.conkyrc .conkyrc
cp /etc/systemd/logind.conf logind.conf

git add .
git commit -m "$message"
git push

#!/bin/bash

message="no Message"

if ! [[ -z $1 ]]
then
	message=$1
fi

cd /home/buttercup/git/I3Backup
rm -R i3
rm -R i3blocks
rm -R terminator
rm .Xresources
rm .zshrc
rm -R katana60
rm .conkyrc
rm libinput-gestures.conf
rm 30-touchpad.conf
rm logind.conf
rm -R gtk-3.0
rm -R sddm-themes
rm sddm.conf

cp -R /home/buttercup/.config/gtk-3.0 gtk-3.0

mkdir sddm-themes
sudo cp -R /usr/share/sddm/themes/sugar-dark ./sddm-themes/sugar-dark
cp /etc/sddm.conf sddm.conf

cp /etc/X11/xorg.conf.d/30-touchpad.conf 30-touchpad.conf
cp /home/buttercup/.config/libinput-gestures.conf libinput-gestures.conf
cp -R /home/buttercup/.config/i3 i3 
cp -R /home/buttercup/.config/i3blocks i3blocks
cp -R /home/buttercup/.config/terminator terminator
cp /home/buttercup/.Xresources .Xresources
cp /home/buttercup/.zshrc .zshrc
cp -R /home/buttercup/QMK/qmk_firmware/keyboards/katana60 katana60
cp /home/buttercup/.conkyrc .conkyrc
cp /etc/systemd/logind.conf logind.conf

cd ..
sudo chown -R buttercup I3Backup

#git add .
#git commit -m "$message"
#git push

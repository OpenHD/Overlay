#!/bin/bash

set +e

FIRSTUSER=`getent passwd 1000 | cut -d: -f1`
FIRSTUSERHOME=`getent passwd 1000 | cut -d: -f6`
if [ -f /usr/lib/userconf-pi/userconf ]; then
   /usr/lib/userconf-pi/userconf 'openhd' '$5$OyWiKrgejw$BeitJ2qySGnQmErhckYdEP9.Pxu7nP/ofArI6LLjC36'
else
   echo "$FIRSTUSER:"'$5$OyWiKrgejw$BeitJ2qySGnQmErhckYdEP9.Pxu7nP/ofArI6LLjC36' | chpasswd -e
   if [ "$FIRSTUSER" != "openhd" ]; then
      usermod -l "openhd" "$FIRSTUSER"
      usermod -m -d "/home/openhd" "openhd"
      groupmod -n "openhd" "$FIRSTUSER"
      if grep -q "^autologin-user=" /etc/lightdm/lightdm.conf ; then
         sed /etc/lightdm/lightdm.conf -i -e "s/^autologin-user=.*/autologin-user=openhd/"
      fi
      if [ -f /etc/systemd/system/getty@tty1.service.d/autologin.conf ]; then
         sed /etc/systemd/system/getty@tty1.service.d/autologin.conf -i -e "s/$FIRSTUSER/openhd/"
      fi
      if [ -f /etc/sudoers.d/010_pi-nopasswd ]; then
         sed -i "s/^$FIRSTUSER /openhd /" /etc/sudoers.d/010_pi-nopasswd
      fi
   fi
fi
rm -f /boot/firstrun.sh
sudo raspi-config nonint do_legacy 0
sudo chown openhd:openhd /home/openhd
sed -i 's| systemd.run.*||g' /boot/cmdline.txt
exit 0

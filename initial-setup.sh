#!/bin/bash
echo ""
n=" ██████╗ ██████╗ ███████╗███╗   ██╗   ██╗  ██╗██████╗   " && echo "${n::${COLUMNS:-$(tput cols)}}" # some magic to cut the end on smaller terminals
n="██╔═══██╗██╔══██╗██╔════╝████╗  ██║   ██║  ██║██╔══██╗  " && echo "${n::${COLUMNS:-$(tput cols)}}"
n="██║   ██║██████╔╝█████╗  ██╔██╗ ██║   ███████║██║  ██║  " && echo "${n::${COLUMNS:-$(tput cols)}}"
n="██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║   ██╔══██║██║  ██║  " && echo "${n::${COLUMNS:-$(tput cols)}}"
n="╚██████╔╝██║     ███████╗██║ ╚████║██╗██║  ██║██████╔╝  " && echo "${n::${COLUMNS:-$(tput cols)}}"
n=" ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝╚═════╝   " && echo "${n::${COLUMNS:-$(tput cols)}}"
echo ""

echo "Please Stand by, this script will install additional drivers"

echo ""

echo "this will take some time, please do not restart your computer or stop this script"

echo ""

echo "we're now installing the rtl8812au driver"

cd /opt/X86/rtl8812au-5.2.20
./dkms-install.sh 2> /opt/X86/install.log

echo "After a reboot OpenHD should be usable now"
rm -rf /opt/X86/initial-setup.sh

reboot 




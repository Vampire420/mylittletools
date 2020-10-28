#!/bin/bash
# Author: James Rock
# Contact: WickedW0LF@protonmail.com
#

#
# fixing apt sources
#

rm /etc/apt/sources.list
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list

echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -


#
# Making sure my favorite "pentools" directory is under root
#

if [ -d "/root/pentools" ]; then
echo "Directory '/root/pentools' already exist"
sleep 1
clear
elif [ ! -d "/root/pentools" ]; then
echo -e "\nMaking '/root/pentools' Directory"
mkdir /root/pentools
sleep 1
fi

#
# some useful APT packages
#

echo -e "\n Installing some useful tools\n"

apt update -y > /dev/null
apt upgrade -y > /dev/null
apt install man sharutils pv htop python3-pip less zip grep ssh whowatch sslsplit dsniff v4l2loopback-dkms v4l2loopback-source v4l2loopback-utils libaa-bin ffmpeg espeak screenfetch make cmake wireshark metasploit-framework python python2 aircrack-ng apache2 apt arp-scan bc beef-xss binwalk bluelog blueman bluesnarfer bluetooth nano git sqlmap mdk3 nikto nmap whatweb wpscan dirb hashcat hydra pwgen responder driftnet macchanger mitmproxy weevely proxychains4 tor hexchat simplescreenrecorder electrum whois -y > /dev/null

 if [ ! $? -eq 0 ]; then
    echo -e " Installation messed up...\n"
    echo -e " Exiting...\n"
    exit 1
 else
    echo "All packages installed..."
 fi
sleep 2
clear


#
# github tools
#

echo -e "\n Git cloning favorite tools...\n"
sleep 1

cd ~/pentools/

git clone https://github.com/samyoyo/weeman
git clone https://github.com/UndeadSec/EvilURL
git clone https://github.com/jklmnn/imagejs
git clone https://github.com/Vampire420/E-Bruter
chmod 755 *

echo " All done!"

clear


#
# VNC setup
#

echo -e "\n Setting up VNC server+viewer...\n"

python -m pip install --upgrade pip
pip3 install instagram-py
apt remove tightvncserver xtightvncviewer --purge -y
apt autoremove -y
apt clean

mkdir /root/pentools/vnc_files
cd /root/pentools/vnc_files/

wget https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.7.2-Linux-x64.deb
dpkg -i VNC-Server-6.7.2-Linux-x64.deb
systemctl enable vncserver-virtuald.service
wget https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.20.529-Linux-x64.deb
dpkg -i VNC-Viewer-6.20.529-Linux-x64.deb
apt install -f > /dev/null

echo "VNC configuration is done"

clear


#
# Setting up "mylittletools"
#

echo -e "\n Setting up 'my little tools'\n"

cd /root/pentools/
git clone https://github.com/Vampire420/mylittletools/
sleep 1
echo ""
cd mylittletools/
chmod u+x *

echo -e "\nCreating relative symbolic links to '/usr/bin'\n"
sleep 0.8

printf " Linking the 'locator'...	: "
ln -rs locator.sh /usr/bin/locator
sleep 0.25
printf "Done"
echo ""

sleep 0.5
printf " Linking the 'fake-camera'...	: "
ln -rs fake-camera.sh /usr/bin/fake-camera
sleep 0.25
printf "Done"
echo ""

sleep 0.5
printf " Linking the 'Panel-Bruter'...	: "
ln -rs Panel-Bruter.sh /usr/bin/panel-bruter
sleep 0.25
printf "Done"
echo ""

sleep 0.5
printf " Linking the 'Login_Spammer'...	: "
ln -rs Login_Spammer.sh /usr/bin/login-spammer
sleep 0.25
printf "Done"
echo ""

sleep 0.5
printf " Linking the 'sshnuke'...	: "
ln -rs sshnuke.sh /usr/bin/sshnuke
sleep 0.25
printf "Done"
clear

echo " All working..."
clear


#
# SSH setup
#


echo -e "\n Setting up SSH...\n"

cd /root/pentools/mylittletools
cp sshd_banner /etc/ssh/

if [ -f '/etc/ssh/sshd_config' ]; then

 echo " Deleting SSH configuration file and replacing it with a custom one"

  rm /etc/ssh/sshd_config
  cp sshd_config /etc/ssh/

else

  apt-get install ssh -y > /dev/null
  echo " Setting up SSH configuration file"
  cp sshd_config /etc/ssh/

fi

echo -e "\n SSH done...\n"

echo -e "\n exiting program...\n"
exit 0
clear


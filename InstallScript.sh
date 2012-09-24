#!/bin/bash
# ------------------------------------------------------------
# File        : install_script
# Author      : Martin Joergensen
# Date        : 22/08/2012
# Description : Usefull programs install script
# ------------------------------------------------------------
 
# ------------------------------------------------------------
# Setup Environment
# ------------------------------------------------------------
PATH=/usr/bin:/bin
umask 0	22
PDIR=${0%`basename $0`}
#ZIP_FILENAME=Unpacked.zip #Place to put zip if you want to unpack programs)

# Number of lines in this script file (plus 1)
#SCRIPT_LINES=89

#checks to see if you are root, and if not asks for it (ask Morten)
if [ $(id -u) != 0 ]; then
echo "-------------------------------------------------------------
This installer must run at root, be ready to write your password
-------------------------------------------------------------"
	sudo "$0"
exit
fi

echo "This script requires connection to the internet to funktion"
sleep 2
# ------------------------------------------------------------
# This part tests the internet by checking if google can be reached
$WGET -q --tries=10 --timeout=5 http://www.google.com -O /tmp/index.google &> /dev/null
if [ ! -s /tmp/index.google ];then
	echo "Everything is working, continue"
	sleep 2
else
	echo "No internet"
	echo "Get online god dammit!"
	sleep 2
	exit
fi

#app1="gksudo apt-get install synapse"
#Can be used to start a install of stuff inside a variable (fx $app1)
# ------------------------------------------------------------
# Now you can input files you find worth installing either unzip them or install using apt-get
# ------------------------------------------------------------
sleep 1
echo "----------------------------------------------------------------"
echo "First we update the repositorys to make sure we get everything up to date"
echo "----------------------------------------------------------------"

#Fake progress bar to have something to look at
/usr/bin/apt-get -qy update > /dev/null & echo "Installation in Progress" [`basename $0`]
count=0
until [ $count -eq 10 ]
do
echo -n "###"
sleep 1
count=`expr $count + 1`
done
echo -n "[100%]"
echo
echo "update complete"

while true; do	
    read -p "Do you wish to install Synapse? (write Yes or No) : " yn
    case $yn in
        [Yy]* ) apt-get install synapse; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to install chromium-browser (write Yes or No) : " yn
    case $yn in
        [Yy]* ) apt-get install chromium-browser; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac

done

while true; do
    read -p "You have to install curl to contuinue : " yn
    case $yn in
        [Yy]* ) apt-get install curl; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac

done

while true; do
    read -p "Need the newest kernel? : " yn
     case $yn in
	[Yy]* ) mkdir /home/cloned/kernel && cd /home/cloned/kernel && ls;;
	[Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac

done

#while true; do
#    read -p "Do you wish to download and install eclipse? (write Yes or No) : " yn
#    case $yn in
#        [Yy]* ) mkdir ~/eclipse/
#		 curl "ftp://ftp.uninett.no/pub/eclipse/technology/epp/downloads/release/juno/R/eclipse-jee-juno-linux-gtk-x86_64.tar.gz" | tar xz eclipse-jee-juno-linux-gtk-x86_64.tar.gz-C ~/eclipse/
#break;;
#        [Nn]* ) break;;
#        * ) echo "Please answer yes or no.";;
#    esac

done
# ------------------------------------------------------------
# Done / Cleanup
# ------------------------------------------------------------
exit 0

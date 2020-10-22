help="
USAGE: $(basename $0) [USERFILE] [PASSFILE] [TARGET]
"

if [ -z $1 ]; then
echo "$help"
else
nmap --script ssh-brute --script-args userdb=$1,passdb=$2 $3
fi

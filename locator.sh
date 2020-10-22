#BARVY

blue="\033[1;34m"
green="\033[1;32m"

#HELP

help="
Usage: $(basename $0) <IP Adress>
"
if [ -z "$1" ]; then
echo -e "$blue $help"

elif [ -n "$1" ]; then

#AKCE

clear
curl -l -s https://ipapi.co/"$1"/json/ > scan
grep -vE 'region_code|country_code|country_code_iso3|country_capital|country_tld|continent_code|postal|timezone|utc_offset|currency_name|languages|country_area|country_population|asn|{|}' scan > scan_clear
rm scan
echo -e "\n$blue     -----RESULTS-----
$green"
tr -d '"' < scan_clear | tr -d ','
echo ""
rm scan_clear
fi

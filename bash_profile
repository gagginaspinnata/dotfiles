# colori
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset



 
# indica come mostrare il cursore. \u mostra l'username mentre \W mostra la working directory
PS1='[\u:\w]→'  
 
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad


###########
## ALIAS###
###########
alias c='clear'

# scorciatoria per committare tutto con git
alias gc='git add . && git commit -m'

# crea un tunnel ssh sicuro ed imposta il sistema ad utilizzarlo come proxy socks
alias privateon='sudo networksetup -setsocksfirewallproxy WI-FI 127.0.0.1 8080 && ssh vps -D 8080'

# Disattiva il proxy di sopra
alias privateoff='sudo networksetup -setsocksfirewallproxystate WI-FI off'

# Lancia questo comando dalla directory che contiene i settings. Questo comando scarica ed installa i settings sul decoder
alias installsettings='wget https://gist.github.com/gagginaspinnata/4749345/raw/0a72ea18f73a182ce6b9abbc487740238c4a8d6b/copy_and_backup_settings.sh; chmod +x copy_and_backup_settings.sh; bash copy_and_backup_settings.sh'


#######################################################
############  colori from github #####################
######################################################

# @gf3’s Sexy Bash Prompt, inspired by “Extravagant Zsh Prompt”
# Shamelessly copied from https://github.com/gf3/dotfiles
# Screenshot: http://i.imgur.com/s0Blh.png

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
		MAGENTA=$(tput setaf 9)
		ORANGE=$(tput setaf 172)
		GREEN=$(tput setaf 190)
		PURPLE=$(tput setaf 141)
		WHITE=$(tput setaf 0)
	else
		MAGENTA=$(tput setaf 5)
		ORANGE=$(tput setaf 4)
		GREEN=$(tput setaf 2)
		PURPLE=$(tput setaf 1)
		WHITE=$(tput setaf 7)
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else
	MAGENTA="\033[1;31m"
	ORANGE="\033[1;33m"
	GREEN="\033[1;32m"
	PURPLE="\033[1;35m"
	WHITE="\033[1;37m"
	BOLD=""
	RESET="\033[m"
fi

export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}

function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

export PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]at \[$ORANGE\]\h \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n\$ \[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"

######################################################
######### fine colori from github ####################
#####################################################


###################### FUNCTIONS ###################

function linux_install_rutorrent(){
	
	url='https://raw.github.com/Kerwood/rtorrent.auto.install/master/rtorrent.auto.install-NEWEST-VERSION'
	cd
	wget $url
	echo"First thing first you need to create a new systems user. The name will be seedbox. Typein a password for him."
	sleep 3
	adduser seedbox
	sleep 3
	bash rtorrent.auto.install-NEWEST-VERSION
}

function linux_install_openvpn(){
	
	# Comes from https://github.com/Nyr/openvpn-install
	wget http://git.io/vpn --no-check-certificate -O openvpn-install.sh; chmod +x openvpn-install.sh; ./openvpn-install.sh
		
}

function linux_install_deluge(){
	
	apt-get install deluged deluge-web -y
	clear
	echo 'Now you can start deluge demon using "deluge-web". We recommand using with screen. To attach to background press ctr a d. You can now access web-ui from youripadress:8112 '
}

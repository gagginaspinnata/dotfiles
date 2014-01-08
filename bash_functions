# Installs rutorrent
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


#Install openvpn
function linux_install_openvpn(){

    # Comes from https://github.com/Nyr/openvpn-install
    wget http://git.io/vpn --no-check-certificate -O openvpn-install.sh; chmod +x openvpn-install.sh; ./openvpn-install.sh

}

# Install deluge and deluge-web
function linux_install_deluge(){

    apt-get install deluged deluge-web -y
    clear
    echo 'Now you can start deluge demon using "deluge-web". We recommand using with screen. To attach to background press ctr a d. You can now access web-ui from youripadress:8112 '
}

# Creates a random string.
# Example: randomstring 20 for creating a random string 20 chars length
function randomstring(){
    openssl rand -base64 $1
}

# Creates a new ssh key. example: newsshkey myemail@gmail.com
function newsshkey(){
    ssh-keygen -t rsa -C "$1"
}

# Creates a tar.gz archive
function tarit(){
	tar -cvzf "$1" "$2"
}

# untar an tar.gz archive
function untarit(){
	tar -xvzf "$1"
}


function osxbootableusb(){
clear

echo '
       ____  ______  __    __                __        __    __        __  _______ ____
      / __ \/ ___/ |/ /   / /_  ____  ____  / /_____ _/ /_  / /__     / / / / ___// __ )
     / / / /\__ \|   /   / __ \/ __ \/ __ \/ __/ __ `/ __ \/ / _ \   / / / /\__ \/ __  |
    / /_/ /___/ /   |   / /_/ / /_/ / /_/ / /_/ /_/ / /_/ / /  __/  / /_/ /___/ / /_/ /
    \____//____/_/|_|  /_.___/\____/\____/\__/\__,_/_.___/_/\___/   \____//____/_____/  '

echo ''
echo 'Author: Mauro Marano'
echo 'Web: mauromarano.it'
echo 'GitHub: https://github.com/gagginaspinnata'
echo ''
echo ''

echo 'This script will guide you throught the process needed to make a mavericks bootable USB dongle.'
echo ''
read -p 'Drag and drop the "Mavericks.app" into this terminal window and press enter: ' var1
read -p 'Drag and drop the path to the USB dongle (usually /Volumes/Untiteled) into this terminal window and press enter: ' var2

sudo $var1/Contents/Resources/createinstallmedia --volume $var2 --applicationpath $var1 --nointeraction
}

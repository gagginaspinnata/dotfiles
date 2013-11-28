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

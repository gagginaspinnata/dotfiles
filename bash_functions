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
  if [ $# -eq 0  ]
    then
      echo 'You need to pass a number (the length)'
      echo 'Usage: randomstring 6'
  else
    openssl rand -base64 $1
  fi
}

# Creates a new ssh key. example: newsshkey myemail@gmail.com
function newsshkey(){
  if [ $# -eq 0  ]
    then
      echo 'You need to pass an email adress'
      echo 'Usage: newsshkey myemail@gmail.com'
  else
    ssh-keygen -t rsa -C "$1"
    eval $(ssh-agent)
    ssh-add
  fi
}

# Creates a tar.gz archive
function tarit(){
  if [ $# -eq 0  ]
    then
      echo 'You need to pass 2 parameters. First the name of the archive and then the file to compress'
      echo 'Usage: tarit archive.tar.gz /mydirectory/*'
  else
       tar -cvzf "$1" "$2"
  fi
}

# untar an tar.gz archive
function untarit(){
  if [ $# -eq 0  ]
    then
      echo 'You need to pass the path to the archive to untar'
      echo 'Usage: untarit myarchive.tar.gz'
  else
       tar -xvzf "$1"
  fi
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

sudo "$var1"/Contents/Resources/createinstallmedia --volume "$var2" --applicationpath "$var1" --nointeraction

}


function laravel(){

  if [ $# -eq 0  ]
    then
      echo 'You need to pass the name of the new project'
      echo 'Usage: laravel my_new_blog'
  else

       sudo composer create-project laravel/laravel "$1"
        sudo chmod -R 777 "$1"
  fi
}


#setup a laravel enviroment installing php, mysql, apache ecc. comes from https://github.com/JeffreyWay/Vagrant-Setup
function setuplaravelenviroment(){

echo "--- Good morning, master. Let's get to work. Installing now. ---"

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- MySQL time ---"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl python-software-properties

echo "--- We want the bleeding edge of PHP, right master? ---"
sudo add-apt-repository -y ppa:ondrej/php5

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- Installing PHP-specific packages ---"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql git-core

echo "--- Installing and configuring Xdebug ---"
sudo apt-get install -y php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

echo "--- Enabling mod-rewrite ---"
sudo a2enmod rewrite



echo "--- What developer codes without errors turned on? Not you, master. ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini

sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

echo "--- Restarting Apache ---"
sudo service apache2 restart

echo "--- Composer is the future. But you knew that, did you master? Nice job. ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Laravel stuff here, if you want

echo "--- All set to go! Would you like to play a game? ---"

}


# this is a helper who creates a ssh shortcut
# please NOTE that this work on ZSH shell only. In order to make it works on bash you have to change the read command as follow:
# read -p "enter the name (example: myownvps): " name
function  add_ssh_server(){
  read  "?enter the name (example: myownvps): " name
  read  "?enter the HostName or ip adress (example: google.com or 145.123.456.123): " hostname
  read  "?enter the Port (usually this is 22): " port
  read  "?enter the User: " user

  str="Host $name
    HostName $hostname
    Port $port
    User $user"
  echo $str >> ~/.ssh/config
  echo "Well done! You can now connect to your server running:\n ssh $name"
}


# Copies the ssh to a remote server.
function copy_ssh_keys(){
    if [ $# -eq 0  ]
      then
        echo 'Usage: copy_ssh_keys root@127.98.23.45'
    else
    cat ~/.ssh/id_rsa.pub | ssh $1 "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"
    fi
}

# installs the kodi media center
function installkodi(){
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:team-xbmc/ppa
    sudo apt-get update
    sudo apt-get install kodi
    sudo apt-get install kodi-pvr-iptvsimple
}

# initialize a new dir with node, npm and babel
es6init(){
  if [ $# -eq 0  ]
    then
      echo "Usage: es6init dir"
    else
    mkdir $1
    cd $1
    mkdir src
    git init
    data='
     .DS_Store
     .DS_Store?
     ._*
     .Spotlight-V100
     .Trashes
     ehthumbs.db
     Thumbs.db
     node_modules'

    echo $data > .gitignore
    touch README.md
    npm init
    npm install babel-cli babel-preset-env --save-dev
    npm install async --save
    
    cat package.json | sed 's/\("scripts": {\)/\1 \"babel\": \"babel-node src",\"build\": \"babel src -o index.js\",/' > package2.json
    rm package.json
    mv package2.json package.json
    data='class Dog {
    constructor(name) {
        this.name = name
              
    }

    bark() {
        return `Wah wah, I am ${this.name}`
              
    }

}

let dog = new Dog("Roy");
console.log(dog.bark());'

    echo $data > src/index.js
    
    # making the .babelrc file
    babelrc='{
    "presets": [
        "env"
              
    ]

}'
    echo $babelrc > .babelrc
    git add . && git commit -m 'first commit'
  fi

}

#initialize a new gitignore file for a git project
gitignore(){

    data='
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db
/node_modules'

     echo $data > .gitignore
}

#show this file
help(){
cat ~/dotfiles/bash_functions
}

palestra(){
    read  "?Inserisci il nome dell immagine da rinominare, oppure semplicemente trascinala nel terminale: " img
    read "?Settimana di dieta/allenamento: " week
    read "?Giorno: " day
    read "?Mese: " month
    read "?Anno: " year

    mv $img "week $week - $(echo $day)_$(echo $month)_$(echo $year).png"
}

function backup_thunderbird(){

  if [ $# -eq 0  ]
    then
      echo 'You need to pass the folder of the thunderbird profile.'
      echo 'Then you need to copy the prefs.js file (who will be copied to the current directory) into the new thunder profile folder overriding the older one.'
      echo 'Usage: backup_thunderbird ~/Library/thunderbird/Profiles/*.default/'
  else

       echo "# Mozilla User Preferences" > prefs.js && cat "$1"prefs.js | egrep 'mail.account.*|mail.accountmanager.*|mail.identity.*|mail.server.*|mail.smtpserver.*|mail.smtpservers' >> prefs.js
  fi
}

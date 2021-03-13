#! /bin/bash

# restart asterisk
sudo systemctl restart asterisk

# checkout CMS code
cd /var/www/html
sudo git clone https://acharya_cicd:DgJAXqmz8x6RkbGuzXex@bitbucket.org/hrk-solutions/cms.git

# update username and password
sed -i 's/root/admin/g' ./cms/config.php
sed -i 's/root/admin/g' ./cms/admin/config.php
sed -i 's/<DB_PASSWORD>/AdminL3tMeIn/g' ./cms/config.php
sed -i 's/<DB_PASSWORD>/AdminL3tMeIn/g' ./cms/admin/config.php


sudo mkdir -p /home/voicebot
cd /home/voicebot
sudo git clone https://acharya_cicd:DgJAXqmz8x6RkbGuzXex@bitbucket.org/hrk-solutions/core.git
sudo mv core v4

sudo chmod 755 -R /hom/voicebot

# create tables and load initial data to DB

cd /tmp/
sudo git clone https://acharya_cicd:DgJAXqmz8x6RkbGuzXex@bitbucket.org/hrk-solutions/sample_data.git
#sudo mysql -h localhost -u admin -pAdminL3tMeIn  < ./sample_data/currynbiryani_tablestructure_20200928.sql
sudo mysql -h localhost -u admin -pAdminL3tMeIn  < ./sample_data/currynbiryani_sample_data_with_table_def.sql

### for initial image setup
# sudo apt-get update
# sudo apt-get -y upgrade
# sudo apt-get -y dist-upgrade

# sudo apt-get install -y \
#     git \
#     curl \
#     wget \
#     libnewt-dev \
#     libssl-dev \
#     libncurses5-dev \
#     subversion \
#     libsqlite3-dev \
#     build-essential \
#     libjansson-dev \
#     libxml2-dev uuid-dev

# https://computingforgeeks.com/how-to-install-asterisk-16-lts-on-ubuntu-debian-linux/
# sudo apt policy asterisk
# cd /usr/src/
# sudo curl -O http://downloads.asterisk.org/pub/telephony/asterisk/old-releases/asterisk-15.7.4.tar.gz
# sudo tar xvf asterisk-15.7.4.tar.gz

# cd asterisk-15.7.*/

# sudo contrib/scripts/get_mp3_source.sh

# sudo contrib/scripts/install_prereq install
# sudo ./configure
# sudo make menuselect
# sudo make
# sudo make install
# sudo make samples
# sudo make configure
# sudo ldconfig

# sudo groupadd asterisk
# sudo useradd -r -d /var/lib/asterisk -g asterisk asterisk
# sudo usermod -aG audio,dialout asterisk
# sudo chown -R asterisk.asterisk /etc/asterisk
# sudo chown -R asterisk.asterisk /var/{lib,log,spool,run}/asterisk
# sudo chown -R asterisk.asterisk /usr/lib/asterisk
# sudo nano /etc/default/asterisk
# sudo nano /etc/asterisk/asterisk.conf

# sudo systemctl restart asterisk
# sudo systemctl enable asterisk
# sudo asterisk -rvv 
# sudo asterisk –vvvvgc
#sudo ufw allow proto tcp from any to any port 5060,5061


### maria db
### https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-ubuntu-20-04
# sudo apt -y install software-properties-common dirmngr
### below two are optional
# sudo apt-key adv --recv-keys –keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
# sudo add-apt-repository 'deb [arch=amd64] http://mirror.zol.co.zw/mariadb/repo/10.3/ubuntu xenial main'

# sudo apt update
# sudo apt -y install mariadb-server mariadb-client

# sudo mysql_secure_installation

# # setup admin user account
# sudo mariadb
#     GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'AdminL3tMeIn' WITH GRANT OPTION;
#     FLUSH PRIVILEGES;
#     exit

# sudo systemctl status mariadb
# sudo mysqladmin version

# mysqladmin -u admin -p version



## apache2

# sudo apt-get install -y apache2
# sudo cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf_orig 

# sudo sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/apache2/apache2.conf
# sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# sudo nano /etc/apache2/apache2.conf
# sudo vi /etc/apache2/apache2.conf


# ## php7
# sudo apt-add-repository ppa:ondrej/php
# sudo apt-get update
# sudo apt-get -y install wget php7.0 php7.0-cgi php7.0-common php7.0-curl php7.0-mbstring php7.0-gd php7.0-mysql php7.0-gettext php7.0-bcmath php7.0-zip php7.0-xml php7.0-imap php7.0-json php7.0-snmp php7.0-fpm libapache2-mod-php7.0
# sudo apt-get -y install php-pear
# sudo sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/7.0/apache2/php.ini
# sudo sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/7.0/cli/php.ini

### phpadmin
# export VER="4.8.5"
# sudo apt-get install -y wget 
# cd /tmp

# wget https://files.phpmyadmin.net/phpMyAdmin/${VER}/phpMyAdmin-${VER}-english.tar.gz
# tar xvf phpMyAdmin-${VER}-english.tar.gz

# sudo rm *.tar.gz

# sudo mv phpMyAdmin-* /usr/share/phpmyadmin
# sudo mkdir -p /var/lib/phpmyadmin/tmp

# sudo chown -R www-data:www-data /var/lib/phpmyadmin 
# sudo mkdir /etc/phpmyadmin/
# sudo cp /usr/share/phpmyadmin/config.sample.inc.php /usr/share/phpmyadmin/config.inc.php

# sudo vi /usr/share/phpmyadmin/config.inc.php
#     $cfg['blowfish_secret'] = 'H2OxcGXxflSd8JwrwVlh6KW6s2rER63i'; 
#     $cfg['TempDir'] = '/var/lib/phpmyadmin/tmp';

# ## copy contents from https://computingforgeeks.com/how-to-install-latest-phpmyadmin-on-ubuntu-18-04-debian-9/
# sudo vi /etc/apache2/conf-enabled/phpmyadmin.conf


### FreePBX14.0
# cd /usr/src
# sudo wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-14.0-latest.tgz

# sudo tar xfz freepbx-14.0-latest.tgz

# sudo rm -f freepbx-14.0-latest.tgz
# cd freepbx/
# sudo ./start_asterisk start
# sudo ./install -n

# sudo a2enmod rewrite
# sudo systemctl restart apache2
# sudo ufw enable

# sudo ufw allow 5060
# sudo ufw allow 5061

# sudo ufw allow 80
# sudo ufw allow 22

# custom image ami-0aca41e2b01d8a1d3 

# bitbucket / cicd - acharya@hrksolutions.com / DgJAXqmz8x6RkbGuzXex


## 
# ./system/config/admin.php
# ./system/config/default.php

# ./config.php
# ./admin/config.php

# sudo apt-get update
# sudo apt-get -y upgrade
# sudo apt install -y python3-pip
# sudo pip3 install --upgrade pip
# sudo pip3 install dialogflow -t /usr/local/lib/python3.6/dist-packages/
# sudo pip3 install paho-mqtt -t /usr/local/lib/python3.6/dist-packages/ 
# sudo pip3 install pyst2 -t /usr/local/lib/python3.6/dist-packages/ 
# sudo pip3 install gTTS  -t /usr/local/lib/python3.6/dist-packages/
# sudo pip3 install --upgrade speechrecognition 
# sudo apt-get install -y sox
# sudo apt-get install -y libsox-fmt-mp3 
# sudo pip3 install gcloud -t /usr/local/lib/python3.6/dist-packages/
# sudo pip3 install google-api-python-client -t /usr/local/lib/python3.6/dist-packages/
# sudo pip3 install google-cloud-speech -t /usr/local/lib/python3.6/dist-packages/
# sudo pip3 install google-cloud-texttospeech -t /usr/local/lib/python3.6/dist-packages/
# sudo pip3 install pydub -t /usr/local/lib/python3.6/dist-packages/

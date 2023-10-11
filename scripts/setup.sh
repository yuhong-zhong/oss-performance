#!/bin/sh
sudo apt-get -y install nginx unzip mysql-server util-linux coreutils
sudo apt-get -y install autotools-dev
sudo apt-get -y install autoconf
sudo apt-get -y install software-properties-common build-essential

sudo apt-get update
sudo apt-get install --yes software-properties-common apt-transport-https
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xB4112585D386EB94
sudo add-apt-repository 'deb https://dl.hhvm.com/universal release main'
sudo apt-get update
sudo apt-get install --yes hhvm

sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get -y install php7.0 php7.0-cgi php7.0-fpm
sudo apt-get -y install php-curl php7.0-mysql php7.0-curl php7.0-gd php7.0-intl php-pear php-imagick php7.0-imap php7.0-mcrypt php-memcache  php7.0-pspell php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-mbstring php7.0-gettext

git clone https://github.com/JoeDog/siege.git
cd siege
git checkout tags/v4.0.3rc3
./utils/bootstrap
automake --add-missing
./configure
make -j8
sudo make uninstall
sudo make install
cd ..
# rm -rf siege

cd "$(dirname "$0")"
cd ..
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

php composer.phar install


echo 1 | sudo tee /proc/sys/net/ipv4/tcp_tw_reuse

echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo || true

#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

# setting proxy for apt
#cp /vagrant/box-setup/apt-proxy.conf /etc/apt/apt.conf.d/20proxy.conf

# update ubuntu
apt-get update -y
apt-get upgrade -y

# setting password for mysql root
debconf-set-selections <<< 'mysql-server mysql-server/root_password password .password.'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password .password.'

# install apache php and mysql
apt-get install -y mysql-server php5 apache2

# install php composer
curl -sS https://getcomposer.org/installer | php --
mv /home/vagrant/composer.phar /usr/local/bin/composer

# setting apache2
rm /etc/apache2/sites-enabled/000-default.conf
cp /vagrant/box-setup/apache2-disable-sendfile.conf /etc/apache2/conf-enabled/disable-sendfile.conf
cp /vagrant/box-setup/apache2-default-site.conf /etc/apache2/sites-enabled/default.conf

service apache2 restart


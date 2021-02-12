#!/bin/bash

sudo apt update

sudo apt install apache2
sudo apt install mariadb-server mariadb-client
sudo apt install php php-mysql libapache2-mod-php php-cli php-cgi php-gd

sudo mysql -u root -e "CREATE DATABASE wp6_database;"
sudo mysql -u root -e "CREATE USER 'wp6_user'@'localhost' IDENTIFIED BY '123456';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON wp6_database.* TO 'wp6_user'@'localhost';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"
sudo mysql -u root -e "exit "

sudo wget https://ru.wordpress.org/latest-ru_RU.zip
sudo unzip latest-ru_RU.zip /var/www/
sudo mv /var/www/wordpress/ /var/www/mysite.by/

sudo cp $PWD/mysiteby.conf /etc/apache2/sites-avaliable/
sudo chown -R www-data:www-data /var/www/mysite.by/
sudo a2ensite mysiteby.conf
sudo service apache2 restart
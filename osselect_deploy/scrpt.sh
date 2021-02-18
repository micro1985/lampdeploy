#!/bin/bash

sudo yum update -y

sudo yum install httpd zip -y
sudo systemctl start httpd
sudo systemctl enable httpd

sudo yum install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb

sudo yum install php php-pear php-gd php-mysql -y

echo "Enter sitename:"
read SITENAME

sudo touch /etc/httpd/conf.d/$SITENAME.conf
echo "<VirtualHost *:80>" | sudo tee /etc/httpd/conf.d/$SITENAME.conf
echo "	ServerName $SITENAME" | sudo tee -a /etc/httpd/conf.d/$SITENAME.conf
echo "	ServerAdmin webmaster@host" | sudo tee -a /etc/httpd/conf.d/$SITENAME.conf
echo "	DocumentRoot /var/www/$SITENAME" | sudo tee -a /etc/httpd/conf.d/$SITENAME.conf
#errlog=$SITENAME"_error"
echo "	ErrorLog /var/www/$SITENAME/log/errors.log" | sudo tee -a /etc/httpd/conf.d/$SITENAME.conf
#acclog=$SITENAME"_access"
echo "	CustomLog /var/www/$SITENAME/log/access.log combined" | sudo tee -a /etc/httpd/conf.d/$SITENAME.conf
echo "</VirtualHost>" | sudo tee -a /etc/httpd/conf.d/$SITENAME.conf

sudo mysql_secure_installation

sudo mysql -u root -e "CREATE DATABASE wp_database;"
sudo mysql -u root -e "CREATE USER 'wp_user'@'localhost' IDENTIFIED BY '123456';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON wp_database.* TO 'wp_user'@'localhost';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

sudo wget https://ru.wordpress.org/latest-ru_RU.zip
sudo unzip latest-ru_RU.zip -d /var/www/
sudo mv /var/www/wordpress/ /var/www/$SITENAME/

sudo chown -R apache:apache /var/www/$SITENAME/
#sudo a2ensite $SITENAME.conf
sudo service httpd restart




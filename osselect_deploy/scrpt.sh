#!/bin/bash

f_install_apache_php_centos7()
{
	sudo yum update -y

	sudo yum install httpd zip -y
	sudo systemctl start httpd
	sudo systemctl enable httpd

	sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
	sudo yum-config-manager -y --enable remi-php72
	sudo yum update -y
	sudo yum -y install php php-fpm php-gd php-mysql
}

f_install_apache_php_debian()
{
	sudo apt update -y
	sudo apt install apache2 php php-mysql libapache2-mod-php php-cli php-cgi php-gd -y
}

f_create_conf_file()
{
	sudo touch ./$SITENAME.conf
	echo "<VirtualHost *:80>" | sudo tee ./$SITENAME.conf
	echo "	ServerName $SITENAME" | sudo tee -a ./$SITENAME.conf
	echo "	ServerAdmin webmaster@host" | sudo tee -a ./$SITENAME.conf
	echo "	DocumentRoot /var/www/$SITENAME" | sudo tee -a ./$SITENAME.conf
	echo "	ErrorLog /var/www/$SITENAME/log/errors.log" | sudo tee -a ./$SITENAME.conf
	echo "	CustomLog /var/www/$SITENAME/log/access.log combined" | sudo tee -a ./$SITENAME.conf
	echo "</VirtualHost>" | sudo tee -a ./$SITENAME.conf
}


f_install_DB_centos7()
{
	sudo yum install mariadb-server -y
	sudo systemctl start mariadb
	sudo systemctl enable mariadb
}

f_install_DB_debian()
{
	sudo apt install mariadb-server mariadb-client -y
}

f_create_DB()
{
cat << EOF | sudo mysql_secure_installation

n
y
y
y
y
EOF

	sudo mysql -u root -e "CREATE DATABASE wp_database;"
	sudo mysql -u root -e "CREATE USER 'wp_user'@'localhost' IDENTIFIED BY '123456';"
	sudo mysql -u root -e "GRANT ALL PRIVILEGES ON wp_database.* TO 'wp_user'@'localhost';"
	sudo mysql -u root -e "FLUSH PRIVILEGES;"
}

f_install_wordpress()
{
	sudo wget https://ru.wordpress.org/latest-ru_RU.zip
	sudo unzip latest-ru_RU.zip -d /var/www/
	sudo mv /var/www/wordpress/ /var/www/$SITENAME/
}

#-----------------------------------------------------------------------------------------------------------
###Here we start script working
#-----------------------------------------------------------------------------------------------------------

echo "Enter sitename:"
read SITENAME

f_install_apache_php_centos7

f_install_DB_centos7
f_create_DB

f_create_conf_file

sudo cp ./$SITENAME.conf /etc/httpd/conf.d/

f_install_wordpress

sudo mkdir /var/www/$SITENAME/log
sudo touch /var/www/$SITENAME/log/errors.log

sudo chown -R apache:apache /var/www/$SITENAME/
sudo service httpd restart

sudo rm *.conf *.zip

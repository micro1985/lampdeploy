#!/bin/bash

#sudo apt update

#sudo apt install apache2 -y
#sudo apt install mariadb-server mariadb-client -y
#sudo apt install php php-mysql libapache2-mod-php php-cli php-cgi php-gd -y


read SITENAME

configfile=./$SITENAME.conf

echo "include(\`./mysiteby.m4') AppConnInfo(\`$SITENAME')" | m4 >> ${configfile}

#cp ./mysiteby.template ./mysiteby.conf



#sudo mysql_secure_installation

#sudo mysql -u root -e "CREATE DATABASE wp6_database;"
#sudo mysql -u root -e "CREATE USER 'wp6_user'@'localhost' IDENTIFIED BY '123456';"
#sudo mysql -u root -e "GRANT ALL PRIVILEGES ON wp6_database.* TO 'wp6_user'@'localhost';"
#sudo mysql -u root -e "FLUSH PRIVILEGES;"

#sudo wget https://ru.wordpress.org/latest-ru_RU.zip
#sudo unzip latest-ru_RU.zip -d /var/www/
#sudo mv /var/www/wordpress/ /var/www/mysite.by/

#sudo cp $PWD/mysiteby.conf /etc/apache2/sites-available/
#sudo chown -R www-data:www-data /var/www/mysite.by/
#sudo a2ensite mysiteby.conf
#sudo service apache2 restart

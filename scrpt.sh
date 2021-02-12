#!/bin/bash

sudo mysql -u root -e "CREATE DATABASE wp6_database;"
sudo mysql -u root -e "CREATE USER 'wp6_user'@'localhost' IDENTIFIED BY '123456';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON wp6_database.* TO 'wp6_user'@'localhost';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"
sudo mysql -u root -e "exit "


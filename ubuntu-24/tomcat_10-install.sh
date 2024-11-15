#!/usr/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install openjdk-17-jdk -y

sudo useradd -m -U -d /opt/tomcat -s /bin/false 

wget -P /tmp https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.1/bin/apache-tomcat-11.0.1.tar.gz

sudo mkdir /opt/tomcat
sudo tar -xzf /tmp/apache-tomcat-11.0.1.tar.gz -C /opt/tomcat

sudo chown -R tomcat:tomcat /opt/tomcat
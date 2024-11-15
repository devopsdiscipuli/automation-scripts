#!/usr/bin/bash

sudo apt update -y
sudo apt upgrade -y
sudo apt install openjdk-17-jdk -y

sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat

wget -P /tmp https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.1/bin/apache-tomcat-11.0.1.tar.gz

sudo mkdir /opt/tomcat
sudo tar -xzf /tmp/apache-tomcat-11.0.1.tar.gz -C /opt/tomcat

sudo chown -R tomcat:tomcat /opt/tomcat

# write tomcat service file
# sudo nano /etc/systemd/system/tomcat.service
<<COMMENT
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment="JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"
Environment="CATALINA_PID=/opt/tomcat/apache-tomcat-11.0.1/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat/apache-tomcat-11.0.1"
Environment="CATALINA_BASE=/opt/tomcat/apache-tomcat-11.0.1"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/apache-tomcat-11.0.1/bin/startup.sh
ExecStop=/opt/tomcat/apache-tomcat-11.0.1/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
COMMENT

sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat
sudo ufw allow 8080
sudo ufw reload
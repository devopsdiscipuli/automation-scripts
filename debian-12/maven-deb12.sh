#!/usr/bin/bash

# create a new user in the maven-agent node called "jenkins-user"
# sudo useradd -m -s /usr/bin/bash jenkins-user

# set passwd for "jenkins-user"
# sudo passwd jenkins-user

# add "jenkins-user" to sudo group
# sudo usermod -aG sudo jenkins-user

# switch to "jenkins-user" 
# su - jenkins-user

sudo apt install openjdk-17-jdk -y
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
sudo tar xvf apache-maven-3.9.9-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.9.9 /opt/maven
sudo touch /etc/profile.d/maven.sh
echo 'export M2_HOME=/opt/maven' | sudo tee -a /etc/profile.d/maven.sh
echo 'export PATH=${M2_HOME}/bin:${PATH}' | sudo tee -a /etc/profile.d/maven.sh
sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
mvn -version

#!/bin/bash

#Require sudo && curl to be install and running
#as root run 'apt install sudo && adduser <username> sudo'
#remember to relogin when you do that 

echo 'Installing build-essential git terminator...'
sudo apt -y install build-essential git terminator curl wget vim apt-transport-https

echo 'Generate ssh key for ssh'
eval "$(ssh-agent -s)"
ssh-add
echo 'Add this pub key to your git account to authorize ssh : '
cat ~/.ssh/id_rsa.pubs

echo 'Install google chrome stable'
sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update
sudo apt-get -y install google-chrome-stable

echo 'Install of openjdk 7'
sudo apt -y install openjdk-7-jdk

echo 'Install zsh && oh-myzsh'
sudo apt -y install zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

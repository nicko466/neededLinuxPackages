#!/bin/bash

#Require sudo to be install and running
#as root run 'apt install sudo && adduser <username> sudo'
#remember to relogin when you do that

function succeed {
    sudo apt update

    echo 'Installing build-essential git terminator...'
    sudo apt -y install build-essential git terminator curl wget vim apt-transport-https ssh apt-utils

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

    echo "Configure p4merge as a diff tool"
    p4merge_dir_name=`tar -tzf p4v.tgz | head -1 | cut -f1 -d"/"`
    tar -xvzf p4v.tgz
    rm p4v.tgz
    sudo mv $p4merge_dir_name /usr/share/
    sudo ln -s /usr/share/$p4merge_dir_name/bin/p4merge /usr/local/bin/p4merge
    git config --global merge.tool p4merge
    git config --global mergetool.keepBackup false
    git config --global mergetool.p4merge.path /usr/local/bin/p4merge
}

function log {
    echo $1
}

dpkg -s sudo
if [ $? -eq 0 ]; then
    succeed
else
    log "Missing the package sudo, please install the package with 'apt install sudo' as root and add your current user to group sudo 'adduser <currentUsername> sudo' "
fi

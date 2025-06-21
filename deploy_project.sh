#!/bin/bash

os_name=$(lsb_release -is)
if [ "$os_name" == "Ubuntu" ]; then
    # Удаляем старые пакеты docker
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

    # Add Docker's official GPG key
    apt-get update -y
    apt-get install ca-certificates curl -y
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update -y
else
    echo "Ваша система не Ubuntu"
    exit 1 
fi
# Устанавливаем Докер
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# Устанавливаем гит
apt-get install git -y
# clone repo
cd /opt
git clone https://github.com/viktorisup/shvirtd-example-python.git && cd shvirtd-example-python
# run Docker compose project
docker compose up -d 
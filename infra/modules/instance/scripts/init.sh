#!/bin/bash
apt-get update

# ssh set up
apt-get install -y openssh-server
systemctl enable ssh
systemctl start ssh
echo -e "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFJmNOBUnpak4KGHwKZcu1tTx6LixTZlk67t+3t3P2U tainticulus@kubuntukomputerkonsole" >> /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh
chmod 700 /home/ubuntu/.ssh
chmod 600 /home/ubuntu/.ssh/authorized_keys

# set up docker
sudo snap install docker

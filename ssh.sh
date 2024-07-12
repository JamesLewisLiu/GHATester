#!/bin/bash

if [[ -z "$SSH_REMOTE_IP" ]]; then
  echo "Please set 'SSH_REMOTE_IP'"
  exit 1
fi

if [[ -z "$SSH_PRIVATE_KEY" ]]; then
  echo "Please set 'SSH_PRIVATE_KEY'"
  exit 2
fi

echo "### Install privatekey ###"
sudo mkdir /root/.ssh
printf "$SSH_PRIVATE_KEY" | sudo tee /root/.ssh/id_rsa &>/dev/null
sudo chmod 0600 /root/.ssh/id_rsa

echo "### Update user password ###"
echo 'root:114514' | sudo chpasswd
echo 'runner:114514' | sudo chpasswd

echo "### Connect to IP ###"
sudo ssh -o StrictHostKeyChecking=no -R 2222:localhost:22 -N $SSH_REMOTE_IP

sleep 10

printf "\n\n\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\nTo connect: sshpass -p114514 ssh -lrunner -p2222 127.0.0.1\n\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\n"

sudo touch /root/STATUS
while true; do
VALUE=$(sudo cat /root/STATUS)
  if [ ! -z $VALUE ]; then
      echo "Target value detected. Exiting with code $VALUE."
      exit $VALUE
  fi
  date;sleep 1
done

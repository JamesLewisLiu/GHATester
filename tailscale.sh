#!/bin/bash

if [[ -z "$TAILSCALE_AUTH_KEY" ]]; then
  echo "Please set 'TAILSCALE_AUTH_KEY'"
  exit 2
fi

echo "### Install Tailscale ###"
curl -fsSL https://tailscale.com/install.sh | sudo sh

echo "### Update user password ###"
echo 'root:114514' | sudo chpasswd
echo 'runner:114514' | sudo chpasswd

echo "### Connect to IP ###"
sudo tailscale login --auth-key $TAILSCALE_AUTH_KEY

sleep 10

printf "\n\n\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\nTo connect: sshpass -p114514 ssh -lrunner $(tailscale ip -4)\n\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\075\n"

sudo touch /root/STATUS
while true; do
VALUE=$(sudo cat /root/STATUS)
  if [ ! -z $VALUE ]; then
      echo "Target value detected. Exiting with code $VALUE."
      exit $VALUE
  fi
  date;sleep 1
done

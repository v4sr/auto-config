#!/bin/bash

echo -e "\e[1;31m[*] Updating packages\e[0m";
sudo apt update;
echo -e "\n\e[1;34;1m[*] Upgrading packages\e[0m";
sudo parrot-upgrade;
echo -e "\n\e[1;32;1m[*] Packages on point\e[0m";

echo -e "\n\e[1;32;1mExiting in \e[0m";
for i in {10..1} 
do
  echo "$i";
  sleep 1;
done

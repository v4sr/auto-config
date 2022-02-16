#!/usr/bin/env bash
BdWhite="\e[1;37m"
BgPurple="\e[45m"
BgRed="\e[41m"
Reset="\e[0m"
incorrect=true

printf "${BdWhite}${BgPurple}[?] Clear the terminal [y/N]:${Reset} "; read ANSWER;
while $incorrect
do
  if [ $ANSWER == "y" ] || [ $ANSWER == "Y" ]; then
    incorrect=false;
    clear
  elif [ $ANSWER == "n" ] || [ $ANSWER == "N" ]; then
    incorrect=false;
  else
    printf "${BdWhite}${BgRed}[!] Not valid answer only [y/N]:${Reset} "; read ANSWER;
  fi
done
  



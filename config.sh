#!/usr/bin/env bash

################################################################################

# Bold Colors
BdBlack="\e[1;30m"
BdGreen="\e[1;32m"
BdYellow="\e[1;33m"

# Background Colors
BgBlack="\e[40m"
BgGreen="\e[42m"
BgBlue="\e[44m"

Reset="\e[0m"

################################################################################

USR=$(whoami)

printf "${BgPurple}${BdGreen}[+] Installing all the dependencies${Reset}\n"
sudo apt update
sudo apt-get install build-essential git vim xcb libxkbcommon-dev python3 libfontconfig1-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev libpam0g-dev libxrandr-dev libfreetype6-dev libimlib2-dev libxft-dev libuv1-dev python3-setuptools gettext
sudo parrot-upgrade
sudo apt autoremove
sudo apt autoclean

sudo cp -R fonts /usr/local/share/
sudo cp -R icons /usr/share/

printf "${BgGreen}${BgRed}[=] Copying config files${Reset}\n\n"
python cpAUTO.py -c "config/xrandr config/bin"
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing bspwm and sxhkd${Reset}\n"

cd ..
git clone https://github.com/baskerville/bspwm.git 
git clone https://github.com/baskerville/sxhkd.git 

printf "${BgGreen}${BdRed}[+] bspwm${Reset}\n"
cd bspwm
make
sudo make install
sudo apt install bspwm

printf "${BgGreen}${BdRed}[+] sxhkd${Reset}\n"
cd ..
cd sxhkd
make
sudo make install

printf "${BgGreen}${BgRed}[=] Copying config files${Reset}\n\n"
cd ../auto-config
python cpAUTO.py -c "config/bspwm config/sxhkd"
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing Polybar${Reset}\n"
cd ..
git clone --recursive https://github.com/polybar/polybar
cd polybar/
mkdir build
cd build/
cmake ..
make -j$(nproc)
sudo make install
cd ../../auto-config

printf "${BgGreen}${BgRed}[=] Copying config files${Reset}\n\n"
python cpAUTO.py -c "config/polybar"

sudo cp ./config/polybar/fonts/* /usr/share/fonts/truetype/
sudo fc-cache -v
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing Picom${Reset}\n"
cd ..
git clone https://github.com/ibhagwan/picom.git 
cd picom/
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
cd ../auto-config

printf "${BgGreen}${BgRed}[=] Copying config files${Reset}\n\n"
python cpAUTO.py -c "config/picom"
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing Rofi${Reset}\n"
sudo apt install rofi

printf "${BgGreen}${BgRed}[=] Copying config files${Reset}\n\n"
python cpAUTO.py -c "config/rofi"
sudo usermod --shell /usr/bin/zsh $USR
sudo usermod --shell /usr/bin/zsh root
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing slim and slimlock${Reset}\n"
sudo apt update 
sudo apt install slim

cd ..
git clone https://github.com/joelburget/slimlock.git
cd slimlock/
sudo make
sudo make install
cd ../auto-config

printf "${BgGreen}${BgRed}[=] Copying config files${Reset}\n\n"
sudo cp -R config/slim /usr/share/
sudo cp -R etc/* /etc
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing input-remapper${Reset}\n"
cd ..
git clone https://github.com/sezanzeb/input-remapper.git
cd input-remapper && ./scripts/build.sh
sudo apt install ./dist/input-remapper-1.4.0.deb

cd ../auto-config
printf "${BgGreen}${BgRed}[=] Copying config files${Reset}\n\n"
python cpAUTO.py -c "config/input-remapper"
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing bat, lsd, fzf, sudo plugin${Reset}\n"
cd ..
wget https://github.com/sharkdp/bat/releases/download/v0.19.0/bat_0.19.0_amd64.deb
sudo dpkg -i bat_0.19.0_amd64.deb

wget https://github.com/Peltoche/lsd/releases/download/0.21.0/lsd_0.21.0_amd64.deb
sudo dpkg -i lsd_0.21.0_amd64.deb

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

sudo su
~/.fzf/install

su $USR

cd auto-config
cp -R zsh-plugins /usr/share
chown $USR:$USR /usr/share/zsh-plugins

printf "${BgBlue}${BdGreen}[+] Installing Ranger${Reset}\n"
sudo apt-get install ranger

printf "${BgGreen}${BgRed}[=] Copying config files${Reset}\n\n"
python cpAUTO.py -cr"config/ranger"
./clearTERM.sh

su $USR
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Setting tools${Reset}\n"
sudo cp -R whichSystem.py /usr/bin
sudo go build -ldflags "-s -w" fastTCPScan.go
upx brute fastTCPScan
sudo mv fastTCPScan /usr/bin
./clearTERM.sh

printf "${BgGreen}${BdBlack}[*] autoSETUP succesfuly completed${Reset}\n"
printf "${BdGreen}Tasks to do:\n"
printf "- Exec config-term.sh"
printf "- Install Firefox"
printf "- Configure Firefox (Foxyproxy, wappalyzer, privacity, downloads...)"
printf "- Install FileZilla FTP Client"

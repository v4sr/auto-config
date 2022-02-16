#!/usr/bin/env bash

################################################################################

# Bold Colors
BdBlack="\e[1;30m"
BdGreen="\e[1;32m"

# Background Colors
BgGreen="\e[42m"
BgBlue="\e[44m"

Reset="\e[0m"

################################################################################

USR=$(whoami)

function Location() {
  directoryx="$(dirname -- $(readlink -fn -- $0; echo x))"
  directory="${directoryx%x}"
  echo "$directory"
}

ProLoc=$(Location)

function ProjDIR() {
  cd "$ProjLoc"
}

function HomeDIR() {
  cd
} 
  
function DownDIR() {
  HomeDIR
  cd "Descargas"
} 
  
function ConfDIR() {
  HomeDIR
  cd ".config"
} 

printf "${BgPurple}${BdGreen}[+] Installing all the dependencies${Reset}\n"
sudo apt update
sudo apt-get install build-essential git vim xcb libxkbcommon-dev python3 libfontconfig1-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev libpam0g-dev libxrandr-dev libfreetype6-dev libimlib2-dev libxft-dev libuv1-dev python3-setuptools gettext
sudo parrot-upgrade

ProjDIR
sudo cp -R fonts /usr/local/share/
sudo cp -R icons /usr/share/

python cpAUTO.py -c "config/xrandr /config/bin"
sudo updatedb
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing bspwm and sxhkd${Reset}\n"
DownDIR
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git

printf "${BgGreen}${BdRed}[+] bspwm${Reset}\n"
cd bspwm/
make
sudo make install
sudo apt install bspwm

printf "${BgGreen}${BdRed}[+] sxhkd${Reset}\n"
cd ../sxhkd/
make
sudo make install

ProjDIR
python cpAUTO.py -c "config/bspwm /config/sxhkd"
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing Polybar${Reset}\n"
DownDIR
git clone --recursive https://github.com/polybar/polybar
cd polybar/
mkdir build
cd build/
cmake ..
make -j$(nproc)
sudo make install

ProjDIR
python cpAUTO.py -c "config/polybar"

ConfDIR
sudo cp polybar/fonts/* /usr/share/fonts/truetype/
sudo fc-cache -v
sudo updatedb

ProjDIR
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing Picom${Reset}\n"
DownDIR
git clone https://github.com/ibhagwan/picom.git
cd picom/
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

ProjDIR
python cpAUTO.py -c "config/picom"
sudo updatedb
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing Rofi${Reset}\n"
sudo apt install rofi

ProjDIR
python cpAUTO.py -c "config/rofi"
usermod --shell /usr/bin/zsh $USR
usermod --shell /usr/bin/zsh root

sudo updatedb
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing slim and slimlock${Reset}\n"
sudo apt update 
sudo apt install slim

DownDIR
git clone https://github.com/joelburget/slimlock.git
cd slimlock/
sudo make
sudo make install

ProjDIR
sudo cp -R ./config/slim /usr/share/
sudo cp -R ./etc/* /etc
sudo updatedb
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing alacritty terminal${Reset}\n"
sudo apt-get --purge remove rustc
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

DownDIR
git clone https://github.com/alacritty/alacritty.git
cd alacritty
cargo build --release

sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

mkdir -p ${ZDOTDIR:-~}/.zsh_functions
echo 'fpath+=${ZDOTDIR:-~}/.zsh_functions' >> ${ZDOTDIR:-~}/.zshrc
cp extra/completions/_alacritty ${ZDOTDIR:-~}/.zsh_functions/_alacritty

echo "source $(pwd)/extra/completions/alacritty.bash" >> ~/.bashrc
mkdir -p ~/.bash_completion
cp extra/completions/alacritty.bash ~/.bash_completion/alacritty
echo "source ~/.bash_completion/alacritty" >> ~/.bashrc

ProjDIR
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing zsh and powerlevel10k theme${Reset}\n"

sudo usermod --shell /usr/bin/zsh $(USR)
sudo usermod --shell /usr/bin/zsh root

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

alacritty -e zsh

HomeDIR
sudo ln -s -f .zshrc /root/.zshrc

ProjDIR
python cpAUTO.py -u ".p10k.zsh"
sudo su
python cpAUTO.py -u ".p10k.zsh"
su $USR
sudo updatedb

ProjDIR
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing input-remapper${Reset}\n"
DownDIR
git clone https://github.com/sezanzeb/input-remapper.git
cd input-remapper && ./scripts/build.sh
sudo apt install ./dist/input-remapper-1.4.0.deb

python cpAUTO.py -c "config/alacritty"
sudo updatedb

ProjDIR
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing bat, lsd, fzf, sudo plugin${Reset}\n"
DownDIR
wget https://github.com/sharkdp/bat/releases/download/v0.19.0/bat_0.19.0_amd64.deb
sudo dpkg -i bat_0.19.0_amd64.deb

wget https://github.com/Peltoche/lsd/releases/download/0.21.0/lsd_0.21.0_amd64.deb
sudo dpkg -i lsd_0.21.0_amd64.deb

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

sudo su
~/.fzf/install

su $USR

ProjDIR
cp -R /zsh-plugins /usr/share
chown $USR:$USR /usr/share/zsh-plugins

python cpAUTO.py -c "config/input-remapper"
sudo updatedb
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing Ranger${Reset}\n"
sudo apt-get install ranger
python cpAUTO.py -cr"config/ranger"
sudo updatedb
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing Ranger${Reset}\n"

cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

sudo su
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

su $USR

ProjDIR
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Setting tools${Reset}\n"
cd /usr/bin
sudo cp -R $(ProjLoc)/whichSystem.py
sudo go build -ldflags "-s -w" $(ProjLoc)/fastTCPScan.go
upx brute fastTCPScan

ProjDIR
./clearTERM.sh

printf "${BgGreen}${BdBlack}[*] autoSETUP succesfuly completed${Reset}\n"
printf "${BdGreen}Tasks to do:\n"
printf "- Install Firefox"
printf "- Configure Firefox (Foxyproxy, wappalyzer, privacity, downloads...)"
printf "- Install FileZilla FTP Client"

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

printf "${BgBlue}${BdGreen}[+] Installing alacritty terminal${Reset}\n"
sudo apt-get --purge remove rustc
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cd ..
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

cd ../auto-config
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing zsh and powerlevel10k theme${Reset}\n"

sudo usermod --shell /usr/bin/zsh $(USR)
sudo usermod --shell /usr/bin/zsh root

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

sudo ln -s -f /home/$USR/.zshrc /root/.zshrc

printf "${BgGreen}${BgRed}[=] Copying config files${Reset}/n"
python cpAUTO.py -u ".p10k.zsh"
sudo su
python cpAUTO.py -u ".p10k.zsh"
su $USR
./clearTERM.sh

printf "${BgBlue}${BdGreen}[+] Installing Tmux${Reset}\n"
cd 
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

sudo su
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .



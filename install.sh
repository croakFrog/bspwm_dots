#!/usr/bin/env bash

# NOT YET THOROUGHLY TESTED, USE AT YOUR OWN RISK
# TESTED ON GECKOLINUX BAREBONES ON BARE METAL (HP Laptop (1920x1080) and T430 Thinkpad (1600x900))
# WARNING: ONLY MEANT FOR FRESH INSTALLS

# Repository
sudo zypper rr Google-chrome
sudo zypper rr Google-talkplugin
sudo zypper rr skype-stable

# update system
# sudo zypper dup

# Remove unnecessary apps
sudo zypper rm firefox sax3 urxvt-unicode

# add upstream to rofi-network-manager fork
cd .config/polybar/scripts/rofi-network-manager
git remote add upstream https://github.com/P3rf/rofi-network-manager.git

# _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

# INSTALL PACKAGES
# Non-negotiables
sudo zypper in -y bspwm dunst feh git i3lock kitty lxappearance polybar qt5ct sxhkd thunar vifm xautolock xclip

# Essentials
sudo zypper in -y btop calcurse darktable firewalld flameshot flatpak font-manager neovim opi qbittorrent redshift rofi skanlite syncthing thunderbird vim vim-data

# Multimedia
sudo zypper in -y ark cava gimp inkscape libreoffice libreoffice-draw mpd ncmpcpp vlc

# Proglang Specific
sudo zypper in -y cargo gcc gcc-c++

# Extras
sudo zypper in -y bleachbit cbonsai fzf colorpicker imagewriter lsd macchanger man musescore neofetch pavucontrol steam tor udiskie udisks2 virt-manager zsh screenkey

# Random Dependencies
sudo zypper in -y brightnessctl canberra-gtk-play ImageMagick libreoffice-gtk3 nmcli_dmenu npm qrencode sound-theme-freedesktop tumbler usbutils VirtualGL xdg-desktop-portal-gtk

# OBS Packages
opi cmatrix
opi fceux
opi signal-desktop

# fix for Davinci Resolve audio
sudo zypper in -y alsa-plugins-pulse

# _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

# make .config & .rdmclones directory
cd $HOME
mkdir .config
mkdir .rdmclones

# bspwm, cava, dunst, kitty, neofetch, nvim, polybar, rofi, sxhkd, vifm, picom configs
# cp -a -v .config/. $HOME/.config/
cd - # go back to dots directory
rm -r ~/.config/kitty
ln -s -r -f .config/* $HOME/.config/

# ncmpcpp, zshrc, p10k, .scripts, .xinitrc, .Xresources, Pictures
# cp -a -v \~/. $HOME
rm -r $HOME/Pictures
ln -s -r -f \~/.* $HOME
ln -s -r -f \~/* $HOME

# _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

# plymouth theme
sudo zypper in -y plymouth-plugin-script
sudo cp -r plymouth/hexagon_dots /usr/share/plymouth/themes/
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/hexagon/hexagon_dots.plymouth 100
sudo plymouth-set-default-theme hexagon_dots

# grub theme
sudo cp -r plymouth/yorha-1920x1080 /boot/grub2/themes/ # Activate the theme on YaST
sudo mkinitrd
# or edit your /etc/default/grub file to include GRUB_THEME="/boot/grub/themes/yorha-1920x1080/theme.txt"

# _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

# cursors
sudo mkdir /usr/share/icons/Skyrim-cursors
cd usr_share_icons/
7za x Skyrim-by-ru5tyshark-cursors.7z
sudo cp cursor.theme /usr/share/icons/Skyrim-cursors/
sudo cp -r cursors /usr/share/icons/Skyrim-cursors/
sudo cp index.theme /usr/share/icons/Skyrim-cursors/
cd -

# _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

# ASTRONVIM
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim +PackerSync
## Then just symlink the init.lua from the nvim directory from the dotfiles to ~/.config/nvim/lua/user
mkdir ~/.config/nvim/lua/user
ln -s -r .config/nvim/lua/user/init.lua ~/.config/nvim/lua/user/
# REMOVES NVIM.BAK symlink
rm -r ~/.config/nvim.bak

# _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

# FONTS
# DeJavu Wifi Ramp
git clone https://github.com/isaif/polybar-wifi-ramp-icons.git ~/.rdmclones/Dejavu
mkdir ~/.fonts
cp ~/.rdmclones/Dejavu/DejaVuSansMono-wifi-ramp.ttf ~/.fonts

# JetBrainsMono Nerd Font Mono
cp fonts/JetBrains\ Mono\ Regular\ Nerd\ Font\ Complete\ Mono.ttf $HOME/.fonts

# Jetbrains Mono, Poppins
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
sudo zypper in -y google-poppins-fonts

# Comfortaa Font
sudo zypper in -y texlive-comfortaa-fonts

# Emoji Fonts
sudo zypper in -y google-noto-coloremoji-fonts

# Microsoft fonts (OPTIONAL)
sudo zypper in -y fetchmsttfonts

# _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

# ZSH
## powerlevel10k
mkdir ~/.zsh-plugs
cd ~/.zsh-plugs
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
#echo "source ~/.zsh-plugs/powerlevel10k/powerlevel10k.zsh-theme" >> ${ZDOTDIR:-$HOME}/.zshrc

## autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions
#echo "source ~/.zsh-plugs/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

## zsh-vi-mode (fix syntax highlighting fork by fbearoff)
git clone https://github.com/fbearoff/zsh-vi-mode.git
#echo "source ~/.zsh-plugs/zsh-vi-mode/zsh-vi-mode.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

## syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
#echo "source ~/.zsh-plugs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

# STUFF BUILT FROM SOURCE
# dragon
zypper in -y gkt3-devel
git clone https://github.com/mwh/dragon.git ~/.rdmclones/dragon
cd ~/.rdmclones/dragon
make
make install

# bspswallow
git clone https://github.com/JopStro/bspswallow.git ~/.rdmclones/bspswallow
cd ~/.rdmclones/bspswallow
cp bspswallow ~/.local/bin

# gtk theme
# Colloid-Dark
sudo zypper in -y gtk2-engine-murrine sassc
git clone https://github.com/vinceliuice/Colloid-gtk-theme.git ~/.rdmclones/Colloid-gtk
cd ~/.rdmclones/Colloid-gtk
./install.sh --tweaks black

# icons
# Colloid Icon Theme Dark
git clone https://github.com/vinceliuice/Colloid-icon-theme.git ~/.rdmclones/Colloid-icon
cd ~/.rdmclones/Colloid-icon
./install.sh

# For picom dccsillag
sudo zypper in -y meson xcb-util-image-devel xcb-util-renderutil-devel libev-devel xcb-util-devel xcb-util-keysyms-devel xcb-util-wm-devel alsa-lib-devel libpixman-1-0-devel uthash-devel libconfig++-devel pcre-devel dbus-1-devel gcc cmake xorg-x11-devel
git clone https://github.com/dccsillag/picom ~/.rdmclones/picom
cd ~/.rdmclones/picom
git checkout implement-window-animations
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
# TO UNINSTALL:
# meson setup --wipe . build
# ninja -C build install

# MPC (because mpc doesn't work for some reason when mpd is install with just zypper)
git clone https://github.com/MusicPlayerDaemon/mpc.git ~/.rdmclones/mpc
cd ~/.rdmclones/mpc
meson . output
ninja -C output
sudo ninja -C output install

# _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

# FLATPAK STUFF (might take a while to install everything, grab a coffee while this is going)
# Comment or delete apps you don't like
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Essential Stuff (I think)
# onlyoffice vscodium flatseal obs textpieces
flatpak install --assumeyes flathub org.onlyoffice.desktopeditors com.vscodium.codium flatseal com.obsproject.Studio com.github.liferooter.textpieces

# Browser (Brave, Firefox)
flatpak install --assumeyes flathub com.brave.Browser org.mozilla.firefox

# Social (Messenger client)
flatpak install --assumeyes flathub com.sindresorhus.Caprine

# Password Manager (Bitwarden)
flatpak install --assumeyes flathub com.bitwarden.desktop

# Just specific stuff I need (Bottles, joplin, freetube, dbeaver)
flatpak install --assumeyes flathub com.usebottles.bottles net.cozic.joplin_desktop io.freetubeapp.FreeTube io.dbeaver.DBeaverCommunity

sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --env=GTK_THEME=Colloid-Dark

# change shell to zsh
chsh -s $(which zsh)

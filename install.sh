#!/usr/bin/env bash

# NOT YET THOROUGHLY TESTED, USE AT YOUR OWN RISK
# TESTED ON GECKOLINUX BAREBONES ON BARE METAL

# Repository
sudo zypper rr Google-chrome
sudo zypper rr Google-talkplugin
sudo zypper rr skype-stable

# enable theme for LUKS
sudo plymouth-set-default-theme -R bgrt

# add upstream to rofi-network-manager fork
cd .config/polybar/scripts/rofi-network-manager || { echo "Error: Directory not found!"; exit 1; }
git remote add upstream https://github.com/P3rf/rofi-network-manager.git

# Install Apps
# removed -y flag because it doesn't work on this command for some reason
sudo zypper in ark gwenview gimp thunderbird clamtk bleachbit flameshot virt-manager musescore qbittorrent steam tor syncthing flatpak neofetch VirtualGL git pavucontrol skanlite kitty vifm cbonsai imagewriter zsh vim vim-data ImageMagick opi firewalld gpick darktable font-manager rofi thunar polybar brightnessctl dunst i3lock canberra-gtk-play redshift lxappearance qrencode man sxhkd feh kitty xclip lsd udiskie udisks2 usbutils inkscape nmcli-dmenu neovim btop macchanger bspwm sound-theme-freedesktop ncmpcpp mpd calcurse fzf npm vlc libreoffice libreoffice-draw libreoffice-gtk3 tumbler cava xdg-desktop-portal-gtk xautolock gcc-c++ cargo qt5ct

# OBS apps
opi cmatrix
opi fceux

# fix for Davinci Resolve audio
sudo zypper in -y alsa-plugins-pulse

# make .config & .rdmclones directory
cd $HOME
mkdir .config
mkdir .rdmclones

# bspwm, cava, dunst, kitty, neofetch, nvim, polybar, rofi, sxhkd, vifm, picom configs
cd -
# cp -a -v .config/. $HOME/.config/
rm -r ~/.config/kitty
ln -s -r -f .config/* $HOME/.config/

# ncmpcpp, zshrc, p10k, .scripts, .xinitrc, .Xresources, Pictures
# cp -a -v \~/. $HOME
rm -r $HOME/Pictures
ln -s -r -f \~/.* $HOME
ln -s -r -f \~/* $HOME

# cursors
sudo mkdir /usr/share/icons/Skyrim-cursors
cd usr_share_icons/
7za x Skyrim-by-ru5tyshark-cursors.7z
sudo cp cursor.theme /usr/share/icons/Skyrim-cursors/
sudo cp -r cursors /usr/share/icons/Skyrim-cursors/
sudo cp index.theme /usr/share/icons/Skyrim-cursors/
cd -

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

# FONTS
# DeJavu Wifi Ramp
git clone https://github.com/isaif/polybar-wifi-ramp-icons.git ~/.rdmclones/Dejavu
mkdir ~/.fonts
cp ~/.rdmclones/Dejavu/DejaVuSansMono-wifi-ramp.ttf ~/.fonts

# JetBrainsMono Nerd Font Mono
cp fonts/JetBrains\ Mono\ Regular\ Nerd\ Font\ Complete\ Mono.ttf $HOME/.fonts

# Jetbrains Mono, Poppins
# INSTALL JETBRAINS MONO NF FROM FONTS FOLDER
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
sudo zypper in -y google-poppins-fonts

# Microsoft fonts (OPTIONAL)
sudo zypper in -y fetchmsttfonts

# ZSH
## powerlevel10k
cd $HOME
mkdir .zsh-plugs
cd .zsh-plugs
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

# For BSPWM:
# For picom jonaburg
sudo zypper in meson xcb-util-image-devel xcb-util-renderutil-devel libev-devel xcb-util-devel xcb-util-keysyms-devel xcb-util-wm-devel alsa-lib-devel libpixman-1-0-devel uthash-devel libconfig++-devel pcre-devel dbus-1-devel gcc cmake xorg-x11-devel
git clone https://github.com/dccsillag/picom ~/.rdmclones/picom
cd ~/.rdmclones/picom
git checkout implement-window-animations
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
# TO UNINSTALL:
# meson setup --wipe . build
# ninja -C build install

# flatpak (might take a while to install everything, grab a coffee while this is going)
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.sindresorhus.Caprine org.onlyoffice.desktopeditors org.signal.Signal com.brave.Browser com.bitwarden.desktop com.usebottles.bottles com.vscodium.codium net.cozic.joplin_desktop io.freetubeapp.FreeTube org.mozilla.firefox flatseal flatpak install flathub com.obsproject.Studio io.dbeaver.DBeaverCommunity

sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --env=GTK_THEME=Colloid-Dark

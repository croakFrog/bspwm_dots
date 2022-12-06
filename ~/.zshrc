# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export PATH=~/.scripts:~/.local/bin:$PATH

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-vi-mode)

export LANG=es_ES.UTF-8

# COSMETIC ALIASES
alias fetch="clear;neofetch --backend kitty --source ~/.config/neofetch/kirbysleep.png --size 250"
alias cmatrix="cmatrix -C blue"
alias screenkey="screenkey --show-settings"

# ZYPPER ALIASES
alias cleanup="sudo journalctl --vacuum-time=ld; sudo zypper clean; sudo zypper purge-kernels; sudo rm /tmp/* -rf"
alias zdup="sudo zypper dup"
alias zin="sudo zypper install"
alias zinr="sudo zypper install --recommends"
alias zrm="sudo zypper remove"
alias zse="zypper search"
# CHANGE DIR OF FIREFOX PROFILE ACCORDINGLY!
alias rupd="sudo zypper ref;echo starting update...;sudo zypper dup; echo updating flatpak...; flatpak update;python3 -m pip install --upgrade pip;updateUserJs;echo actualizando zsh-vi-mode...;cd ~/.zsh-plugs/zsh-vi-mode;git fetch;git pull;echo actualizando zsh-autosuggestions...;cd ~/.zsh-plugs/zsh-autosuggestions;git fetch;git pull;echo actualizando zsh-syntax-highlighting...;cd ~/.zsh-plugs/zsh-syntax-highlighting;git fetch;git pull;echo actualizando powerlevel10k...;cd ~/.zsh-plugs/powerlevel10k;git fetch;git pull;"
alias z="sudo zypper"
alias zref="sudo zypper ref"

# QOL ALIASES
alias sd="sudo shutdown -h now"
alias rb="sudo reboot"
alias logoff="pkill -KILL -u $USER"
alias getclass="xprop | grep WM_CLASS"
alias fehrdm="feh --randomize --bg-scale --no-fehbg ~/Pictures/Anime_Dark"
alias nvz="cd;nvim .zshrc"
alias repoly="killall -q polybar; polybar"
alias ncp="ncmpcpp"
alias lampstart="systemctl start apache2;systemctl start mysql;systemctl start postgresql"
alias lampstop="systemctl stop apache2;systemctl stop mysql;systemctl stop postgresql"
alias lampstatus="systemctl status apache2;systemctl status mysql;systemctl status postgresql"
alias nv="nvim"
alias ls="lsd"
alias udmount="udisksctl mount -b" # + block device (e.g sdb1)
alias udunmount="udisksctl unmount -b"
alias glxs="glxspheres"
alias showqr="nmcli dev wifi show-password"

# SYSTEMCTL ALIASES
alias sctlstat="systemctl status"
alias sctlstart="systemctl start"
alias sctlstop="systemctl stop"

# GIT ALIASES
alias gac="git add -A;git commit -m"
alias gdif="git diff"
alias gpush="git push"
alias gpull="git pull"
alias gfe="git fetch"
alias gstat="git status"
alias gcl="git clone"
alias rgcl="cd ~/.rdmclones;git clone"

# BOOKMARKS
alias cdbpgit="cd ~/botpress-folder/data/assets/modules/channel-web/examples"
alias cdbp="cd ~/botpress-folder;./bp" #pg_ctl -D data stop; pg_ctl -D mydbuddydump -l logfile start
alias cdconf="cd; cd ~/.config"
alias synchtd="sudo rm -rf /srv/www/htdocs/examples;sudo cp -r ~/botpress-folder/data/assets/modules/channel-web/examples /srv/www/htdocs"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.zsh-plugs/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh-plugs/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh-plugs/zsh-vi-mode/zsh-vi-mode.zsh
source ~/.zsh-plugs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue,underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue

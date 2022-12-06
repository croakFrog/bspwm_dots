#!/usr/bin/env bash
flatpak run org.mozilla.firefox -CreateProfile main
# set main as default profile
flatpak run org.mozilla.firefox -P
PROFILE=$(ls ~/.var/app/org.mozilla.firefox/.mozilla/firefox/ | grep main)
cp -rf firefoxcss/* ~/.var/app/org.mozilla.firefox/.mozilla/firefox/$PROFILE

#!/bin/bash

cat << "EOF"

#|---/ /+--------------------------+---/ /|#
#|--/ /-| Main installation script |--/ /-|#
#|-/ /-|            FRVR-BXRLIN         |-/ /--|#
#|/ /---+--------------------------+/ /---|#

-----------------------------------------------------------------
        .                                                     
       / \         _       _  _                  _     _      
      /^  \      _| |_    | || |_  _ _ __ _ _ __| |___| |_ ___
     /  _  \    |_   _|   | __ | || | '_ \ '_/ _` / _ \  _(_-<
    /  | | ~\     |_|     |_||_|\_, | .__/_| \__,_\___/\__/__/
   /.-'   '-.\                  |__/|_|                       

-----------------------------------------------------------------

EOF

# Install yay package manager if not installed
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# Install packages
yay -S --noconfirm wayland libdrm pixman libxkbcommon python libxml2 llvm libpng gegl mtdev xorg-xwayland qt5-wayland qt6-wayland hyprland swww waybar xdg-desktop-portal-wlr wlroots xdg-desktop-portal polkit-kde-agent kitty pcmanfm-qt neovim gedit swaylock-effects brightnessctl pavucontrol alsa-utils grim slurp wl-clipboard mpv nm-applet python-pip rofi blueberry bluez bluez-utils ranger ts-node zsh ttf-jetbrains-mono ttf-jetbrains-mono-nerd inotify-tools sddm-sugar-candy-git thunar ark playerctl pamixer whitesur-icon-theme-git whitesur-cursor-theme-git whitesur-gtk-theme-git xdg-user-dirs nwg-look-bin python-pillow python-pywalfox pywal-discord-git mako-git viewnior gnome-keyring neofetch imagemagick wtype inter-font-beta rofi-emoji noto-fonts-emoji ttf-droid alsa-firmware tumbler wal-telegram-git firefox-developer-edition discord betterdiscordctl betterdiscord-git telegram-desktop spotify spicetify-cli visual-studio-code-bin cava cmatrix tty-clock pipes.sh pywal-16-colors

# Oh My Zsh installation
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k theme installation
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Zsh syntax highlighting installation
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh autosuggestions installation
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Copy .zshrc and .p10k.zsh files to home directory
echo "Copying .zshrc and .p10k.zsh files to home directory..."

cp .zshrc $HOME
cp .p10k.zsh $HOME

echo "Successfully copied .zshrc and .p10k.zsh files!"

# Copy config files and wallpapers
echo "Installing rchrdwllm's dotfiles..."
echo "Copying .config and Wallpapers to /home directory..."

cp -r .config $HOME
cp -r Wallpapers $HOME

echo "Successfully copied files!"

# Copy SDDM theme
echo "Copying SDDM theme to /usr/share/sddm/themes..."
echo "Your password is needed for this one"

sudo cp -r usr/share/sddm/themes/sugar-candy/* /usr/share/sddm/themes/sugar-candy/
sudo cp -r lib/sddm/sddm.conf.d/default.conf /lib/sddm/sddm.conf.d/

echo "Successfully copied SDDM theme!"

# Enable services
echo "Enabling services SDDM and bluetooth services..."

sudo systemctl enable sddm.service
sudo systemctl enable bluetooth.service

echo "Successfully enabled services!"

# Reboot prompt
echo "You can now reboot your system to see changes"
echo "Would you like to reboot now? (y/n)"

read reboot

if [ "$reboot" = "y" ]; then
    sudo reboot
else
    echo "Alright, you can reboot later by typing 'sudo reboot'"
fi

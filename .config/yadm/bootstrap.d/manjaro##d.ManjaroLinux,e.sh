#! /bin/sh

PACKAGES=(
    "python-tensorflow-cuda"
    "brave-browser"
    "ipython"
    "bat"
    "ventoy"
    "deja-dup"
    "npm"
    "neovim"
    "tlp"
    "unzip"
    "bash-completion"
    "yay"
    "tk"
    # AUR packages
    "nerd-fonts-fira-code"
)

sync_and_install_yay() {
    # sudo pacman-mirrors --fasttrack --api --protocol https &&
    sudo pacman -Syyu --needed --noconfirm yay
}

# Installs both the core and AUR packages.
install_packages() {
    yay -Syyu --noconfirm --needed "${PACKAGES[@]}"
}

sync_and_install_yay && install_packages

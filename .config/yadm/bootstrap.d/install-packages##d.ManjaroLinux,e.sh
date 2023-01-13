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
    "lsd"
    "ripgrep"
    "keybase-gui"
    "iwd"
    "meson"
    "tree"
    "duf"
    "go"
    "ctags"
    "make"
    "ttf-fira-code"
    "qbittorrent"
)

sync_packages() {
    echo "Set SYNC_PACKAGES to sync packages"
    if [[ -n $SYNC_PACKAGES ]]; then
        sudo pacman-mirrors --api --protocol https
    fi
}

sync_and_install_yay() {
    sudo pacman -Syyu --needed --noconfirm yay
}

# Installs both the core and AUR packages.
install_packages() {
    yay -Syyu --noconfirm --needed "${PACKAGES[@]}"
}

sync_packages && sync_and_install_yay && install_packages

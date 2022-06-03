#! /bin/sh

REQUIRED=(
    "python-tensorflow"
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
)

update_mirrorlist_and_packages() {
    sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
}

install_required() {
    sudo pacman -Sy --noconfirm --needed "${REQUIRED[@]}"
}

main() {
    update_mirrorlist_and_packages && install_required
}

main

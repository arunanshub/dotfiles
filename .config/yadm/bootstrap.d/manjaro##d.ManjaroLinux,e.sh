#! /bin/sh

REQUIRED=(
    "python-tensorflow"
    "brave-browser"
    "ipython"
)

update_mirrorlist_and_packages() {
    sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
}

install_required() {
    sudo pacman -S "${REQUIRED[@]}"
}

main() {
    update_mirrorlist_and_packages && install_required
}

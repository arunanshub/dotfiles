# manual installation of ohmybash
OMB_PATH="$HOME/.oh-my-bash"
BASHRC_PATH="$HOME/.bashrc"
if [[ ! -e $OMB_PATH ]]; then
    echo "Cloning into $OMB_PATH"
    git clone https://github.com/ohmybash/oh-my-bash.git $OMB_PATH
fi
if [[ ! -e $BASHRC_PATH ]]; then
    echo "Copying template bashrc into '$OMB_PATH'"
    cp $OMB_PATH/templates/bashrc.osh-template $BASHRC_PATH
fi
source $BASHRC_PATH

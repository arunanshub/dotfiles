# manual installation of ohmybash
OMB_PATH="$HOME/.oh-my-bash"
BASHRC_PATH="$HOME/.bashrc"
[[ ! -e $OMB_PATH ]] git clone git://github.com/ohmybash/oh-my-bash.git $OMB_PATH
[[ ! -e $BASHRC_PATH ]] && cp $OMB_PATH/templates/bashrc.osh-template $BASHRC_PATH
source $BASHRC_PATH

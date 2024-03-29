#
# ~/.bash_profile
#

# PATH
export PATH=$PATH:$HOME/.local/bin:$HOME/.local/bin/binary:$HOME/.config/emacs/bin

export EDITOR=vim
export QT_QPA_PLATFORMTHEME=qt5ct

# X Cursor PATH
export XCURSOR_PATH=${XCURSOR_PATH}:$HOME/.local/share/icons

[[ -f ~/.bashrc ]] && . ~/.bashrc

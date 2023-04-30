#
# ~/.zprofile
#

# PATH
export PATH=$PATH:$HOME/.local/bin:$HOME/.local/bin/binary:$HOME/.config/emacs/bin

export EDITOR=vim
#export QT_QPA_PLATFORMTHEME=qt5ct

# for nixos
# export GTK2_RC_FILES=$HOME/.local/share/themes/dracula/gtk-2.0/gtkrc

# X Cursor PATH
export XCURSOR_PATH=${XCURSOR_PATH}:$HOME/.local/share/icons

# Start X-Server
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

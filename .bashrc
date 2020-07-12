#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PATH=$PATH:$HOME/.local/bin:$HOME/.emacs.d/bin
EDITOR=vim

# Useful Aliases (Colorization and shortcuts)
alias ls='exa --color=auto --group-directories-first'
alias ll='ls --group --all --all --classify --long --header'
alias la='ls --all'
alias l='ls --group --classify --long --header'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ip colorization
alias ip='ip -color=auto'

# Remove orphans
alias orphan='sudo pacman -Rns $(pacman -Qtdq)'

# Pacman cache clear
alias cache='sudo paccache --remove --keep 1'

# Pacman cache clear all uninstalled
alias cache-uninstalled='sudo paccache --remove --uninstalled --keep 0'

# Service list enabled
alias service='systemctl list-unit-files --state=enabled'

# pywal alias to prevent it from setting a wallpaper
alias wal='wal -n'

PS1='[\[\033[1;36m\]\u\[\033[1;33m\]@\h\[\033[1;34m\] \w\[\033[0m\]]\$ '

# Powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
# cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
# source ~/.cache/wal/colors-tty.sh

# running pfetch
# pfetch

# start fish but keep main shell as BASH
exec fish

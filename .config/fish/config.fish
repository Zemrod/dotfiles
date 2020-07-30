#set fish_function_path $fish_function_path "/usr/lib/python3.8/site-packages/powerline/bindings/fish"
#powerline-setup

# EDITOR variable
set EDITOR "emacs"

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
alias orphan='sudo pacman -Rns (pacman -Qtdq)'

# Pacman cache clear
alias cache='sudo paccache --remove --keep 1'

# Pacman cache clear all uninstalled
alias cache-uninstalled='sudo paccache --remove --uninstalled --keep 0'

# Service list enabled
alias service='systemctl list-unit-files --state=enabled'

# pywal alias to prevent it from setting a wallpaper
alias wal='wal -n'

# prevent the fish greeting
set fish_greeting

# pywal colors for fish
source ~/.cache/wal/colors.fish

# Starship
starship init fish | source

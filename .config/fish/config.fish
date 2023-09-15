#set fish_function_path $fish_function_path "/usr/lib/python3.8/site-packages/powerline/bindings/fish"
#powerline-setup

# EDITOR variable
set EDITOR "vim"

# Useful Aliases (Colorization and shortcuts)
alias ls='eza --color=auto --group-directories-first --git'
alias ll='ls --group --all --all --classify --long --header'
alias la='ls --all'
alias l='ls --group --classify --long --header'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rsync='rsync -v --progress'

# zstd compression alias
alias tarzstd='tar --zstd -cf'

# ip colorization
alias ip='ip -color=auto'

# Service list enabled
alias service='systemctl list-unit-files --state=enabled'

# pywal alias to prevent it from setting a wallpaper
alias wal='wal -n'

# alias for youtube-dl
alias yt-mp3='youtube-dl -x --audio-format mp3 -o "%(title)s.%(ext)s"'
alias yt-vid='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" -o "%(title)s.%(ext)s"'

# cargo colorization
alias cargo='cargo --color always'

# alias for ripgrep
alias grep='rg'

# Alias for dust (du + rust) human-readable by default
alias du='dust'

# a cat(1) clone with wings
alias cat='bat'

# rustic ps replacement
alias ps='procs'

# backup into tarball
alias backup='tar -czvf backup-$(date +%F).tar.gz'

### lolcate related aliases
# query the music database
set MUSIC_DB Music
alias music='lolcate --db $MUSIC_DB --type audio'

function play
	mpv --playlist=(music $1 | psub)
end

function play_shuf
	mpv --playlist=(music $1 | shuf | psub)
end
###

# prevent the fish greeting
set fish_greeting

# pywal colors for fish
source ~/.cache/wal/colors.fish

# Starship
starship init fish | source

# Start X at login
if status is-interactive
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

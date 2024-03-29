# Useful Aliases (Colorization and shortcuts)
alias ls='eza --color=auto --group-directories-first --git'
alias ll='ls --group --all --all --classify --long --header'
alias la='ls --all'
alias l='ls --group --classify --long --header'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rsync='rsync -v --progress'
alias virsh='virsh -c qemu:///system'

# ip colorization
alias ip='ip -color=auto'

# Service list enabled
alias service='systemctl list-unit-files --state=enabled'

# pywal alias to prevent it from setting a wallpaper
alias wal='wal -n'

# alias for youtube-dl
alias yt-mp3='yt-dlp -x --audio-format mp3 -o "%(title)s.%(ext)s"'
alias yt-vid='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" -o "%(title)s.%(ext)s"'

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

# backup into a tarball
alias backup='tar -czvf backup-$(date +%F).tar.gz'

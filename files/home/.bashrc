# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



###########
# jvalcher
###########

# Start tmux if not running
#if [ -z $TMUX ]; then
#    tmux
#fi

# Prompt
BLUE='\[\033[1;94m\]'
YELLOW='\[\033[1;93m\]'
DEFAULT='\[\033[0m\]'
export PS1="${BLUE}\w ${YELLOW}\$${DEFAULT} "

# Time zone
export TZ=":America/Chicago"

# Terminal colors
ls_color_defs=(
    'no=00;37'      
    'so=00;35'      
    'di=00;33'      
    'do=00;35'      
    'bd=40;33;01'   
    'cd=40;33;01'   
    'or=40;31;01'   
    'mi=37;41'         
    'su=37;41'      
    'sg=30;43'      
    'ca=30;41'      
    'tw=30;42'      
    'ow=34;42'      
    'st=37;44'      
    'ex=00;92'      
    'ln=00;93'      
    'pi=00;45'      
    '*.7z=00;31'    
    '*.aac=00;36'
    '*.ace=00;31'
    '*.alz=00;31'
    '*.arc=00;31'
    '*.arj=00;31'
    '*.asf=00;35'
    '*.au=00;36'
    '*.avi=00;35'
    '*.bmp=00;35'
    '*.bz2=00;31'
    '*.bz=00;31'
    '*.c=00;36'
    '*.py=00;36'
    '*.cab=00;31'
    '*.cgm=00;35'
    '*.cpio=00;31'
    '*.deb=00;31'
    '*.dl=00;35'
    '*.dwm=00;31'
    '*.dz=00;31'
    '*.ear=00;31'
    '*.emf=00;35'
    '*.esd=00;31'
    '*.flac=00;36'
    '*.flc=00;35'
    '*.fli=00;35'
    '*.flv=00;35'
    '*.gif=00;35'
    '*.gl=00;35'
    '*.gz=00;31'
    '*.h=00;90'
    '*.jar=00;31'
    '*.jpeg=00;35'
    '*.jpg=00;35'
    '*.lha=00;31'
    '*.lrz=00;31'
    '*.lz4=00;31'
    '*.lz=00;31'
    '*.lzh=00;31'
    '*.lzma=00;31'
    '*.lzo=00;31'
    '*.m2v=00;35'
    '*.m4a=00;36'
    '*.m4v=00;35'
    '*.md=00;90'
    '*.mid=00;36'
    '*.midi=00;36'
    '*.mjpeg=00;35'
    '*.mjpg=00;35'
    '*.mka=00;36'
    '*.mkv=00;35'
    '*.mng=00;35'
    '*.mov=00;35'
    '*.mp3=00;36'
    '*.mp4=00;35'
    '*.mp4v=00;35'
    '*.mpc=00;36'
    '*.mpeg=00;35'
    '*.mpg=00;35'
    '*.nuv=00;35'
    '*.oga=00;36'
    '*.ogg=00;36'
    '*.ogm=00;35'
    '*.ogv=00;35'
    '*.ogx=00;35'
    '*.opus=00;36'
    '*.pbm=00;35'
    '*.pcx=00;35'
    '*.pgm=00;35'
    '*.png=00;35'
    '*.ppm=00;35'
    '*.qt=00;35'
    '*.ra=00;36'
    '*.rar=00;31'
    '*.rm=00;35'
    '*.rmvb=00;35'
    '*.rpm=00;31'
    '*.rz=00;31'
    '*.sar=00;31'
    '*.spx=00;36'
    '*.svg=00;35'
    '*.svgz=00;35'
    '*.swm=00;31'
    '*.t7z=00;31'
    '*.tar=00;31'
    '*.taz=00;31'
    '*.tbz2=00;31'
    '*.tbz=00;31'
    '*.tga=00;35'
    '*.tgz=00;31'
    '*.tif=00;35'
    '*.tiff=00;35'
    '*.tlz=00;31'
    '*.txz=00;31'
    '*.tz=00;31'
    '*.tzo=00;31'
    '*.tzst=00;31'
    '*.vob=00;35'
    '*.war=00;31'
    '*.wav=00;36'
    '*.webm=00;35'
    '*.webp=00;35'
    '*.wim=00;31'
    '*.wmv=00;35'
    '*.xbm=00;35'
    '*.xcf=00;35'
    '*.xpm=00;35'
    '*.xspf=00;36'
    '*.xwd=00;35'
    '*.xz=00;31'
    '*.yuv=00;35'
    '*.z=00;31'
    '*.zip=00;31'
    '*.zoo=00;31'
    '*.zst=00;31'
)
LS_COLORS=''
for def in "${ls_color_defs[@]}"; do
    LS_COLORS="$LS_COLORS:$def"
done
export LS_COLORS

# lf
export LF_COLORS="\
.git/=01;32:\
.git*=32:\
*.gitignore=32:\
*Makefile=32:\
README.*=33:\
*.txt=34:\
*.md=34:\
ln=01;36:\
di=01;34:\
ex=01;32:\
"

# Enable extended pattern matching
shopt -s extglob

# Disable terminal freeze with Ctrl+s
stty -ixon

# Add autocomplete for markdown files when using google-chrome
complete -f -X '!*.md' google-chrome

# Turn highlight pasted text off
bind 'set enable-bracketed-paste off'

# Enable bash-autompletion
source $HOME/.bash_completion

# History
export HISTFILE=~/.bash_history
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
shopt -s histappend

# core dump file size
ulimit -c unlimited

# Config
export XDG_CONFIG_HOME=$HOME/.config

# Set default editor to vim
export EDITOR="$HOME/.local/bin/nvim"

# Set man pager to vim
export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
export MANROFFOPT="-c"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# $HOME bin
export PATH="$PATH:$HOME/.bin:$HOME/.local/bin"

# less
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS='-R'

# Proxy (PDANet)
#pdanet_proxy="http://192.168.49.1:8000"
#export ALL_PROXY=$pdanet_proxy
#export HTTP_PROXY=$pdanet_proxy
#export HTTPS_PROXY=$pdanet_proxy
#export all_proxy=$pdanet_proxy
#export http_proxy=$pdanet_proxy
#export https_proxy=$pdanet_proxy
#export ftp_proxy=$pdanet_proxy
#export dns_proxy=$pdanet_proxy
#export rsync_proxy=$pdanet_proxy

# lf
#source $HOME/.config/lf/lf.sh

# scrcpy
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig

# VLC plugin
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/include/vlc/plugins

# Java
#export C_INCLUDE_PATH=\
#$C_INCLUDE_PATH:\
#/usr/lib/jvm/java-18-openjdk-amd64/include:\
#/usr/lib/jvm/java-18-openjdk-amd64/include/linux

# Python
export PIP_CONFIG_FILE="~/.config/pip/pip.conf"

# Rust
source $HOME/.cargo/env

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:$HOME/.golang/bin"

# This loads nvm bash_completion
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$PATH:$BUN_INSTALL/bin"

# GNU Arm embedded toolchain
export PATH="$PATH:$HOME/Repos/gcc-arm-none-eabi-10.3-2021.10/bin"

# Main PATHs
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Prune duplicate paths
PATHS=(
    "PATH"
    "LD_LIBRARY_PATH"
    "C_INCLUDE_PATH"
    "PKG_CONFIG_PATH"
)
for P in "${PATHS[@]}"; do
    source $HOME/.bin/prune_paths $P
done

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/jvalcher/.anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/jvalcher/.anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/jvalcher/.anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/jvalcher/.anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

# Source aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Color mode (see .tmux.conf setting)
export TERM="xterm-256color"


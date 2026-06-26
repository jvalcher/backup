
# exit
alias e='exit'

# shutdown
alias Shutdown='pkill chrome && sudo poweroff'

# ls
alias ll="LC_COLLATE=C ls -1p"

lla () {
    STATE=$(ls -1d .!(|.) |& grep -q "No such file"; echo $?)
    STATE_ARGS=$(cd $1; ls -1d .!(|.) |& grep -q "No such file"; echo $?)
    if [ $# -eq 0 ]; then
        if [ $STATE -eq 0 ]; then
            printf ""
        else
            printf "$(ls --color=always -1dp .!(|.))\n"
        fi
    else
        if [ $STATE_ARGS -eq 0 ]; then
            printf ""
        else
            printf "$(cd $1; ls --color=always -1dp .!(|.))\n"
        fi
    fi
}
alias la="lla"

# unattended-upgrades
alias uu="tail -f /var/log/unattended-upgrades/unattended-upgrades.log"

# search
alias gr="grep -inrI"
alias ffi="find . -iname"

# misc
alias watch_dir="inotifywait -m -e create --format '%f' ."
alias feh="feh -x"
alias transfer_file="rsync -avz --progress"
alias dir_size="du -a -h --max-depth=1 | sort -hr"
cd() {
    builtin cd "$@" && ll
}

# Make directory $2 an exact mirror of directory $1
sync_dirs() {
    rsync -avu --delete ${1}/ ${2}
}

# vim
alias vimc="vim ~/.vimrc"

# Neovim (see .bashrc for installing)
alias nv="nvim"

function nvc() {
    local orig_dir="$(pwd)"
    cd $HOME/.config/nvim
    nv lua/keymap.lua
    cd "$orig_dir"
    clear
    ll
}

# yt-dlp
alias ytu="yt-dlp -U"
alias ytv="yt-dlp --js-runtimes bun -f 'bestvideo[height<=720]+bestaudio'"
alias yta="yt-dlp --js-runtimes bun -x --audio-format mp3"

# restart pulseaudio, bluetooth.service to connect bluetooth headphones
alias btr="sudo systemctl restart bluetooth.service"
alias pk="pulseaudio -k"

# Open directory in file explorer, current directory if no argument supplied
alias fe="nohup nautilus -w $1 > /dev/null 2>&1 &"

# Print, copy path
alias pwdc="pwd -P | tee >(tr -d '\n' | xclip -selection clipboard)"
alias pwf="readlink -f | tee >(xclip -selection clipboard)"

# trash-cli
alias rm="trash-put"
alias trash-list="trash-list | sort -k1,2"
alias trash-size="du -hs ~/.local/share/Trash/"

# python
alias py="python3 "
alias python="python3"
alias pip="pip3"

# binary search paths
paths() {
    IFS=':' read -ra dirs <<< "$PATH"
    for dir in "${dirs[@]}"; do
        echo "$dir"
    done
}

# ESP-IDF
alias src_esp="ESP_PROJECT=1; source $IDF_PATH/export.sh"

# misc dev
alias vg="valgrind --leak-check=full --track-origins=yes --show-reachable=yes"

libs() {
    IFS=':' read -ra dirs <<< "$LD_LIBRARY_PATH"
    for dir in "${dirs[@]}"; do
        echo "$dir"
    done
}

incs() {
    IFS=':' read -ra dirs <<< "$C_INCLUDE_PATH"
    for dir in "${dirs[@]}"; do
        echo "$dir"
    done
}

# git
alias gitd="git diff"
alias gits="git status -u"
alias gitg="printf '\n'; git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all; printf '\n'"
alias gitba="git branch | xargs -n 1 echo"
alias gitb="git branch --show-current"
alias gitp="git fetch && git log --name-status origin/main.."
alias gitc="git cherry -v main"
gitl() {
    git rev-list --objects --all \
    | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
    | sed -n 's/^blob //p' \
    | sort --numeric-sort --key=2 \
    | tail -n 10 \
    | cut -c 1-12,41- \
    | $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

# gdb
alias gdb="gdb -q"
alias gdt="gdb -tui"
alias gdbmi="gdb --interpreter=mi"
alias ttg="echo 'tty $(tty)' | tee >(xclip -selection clipboard)"
alias gdn="nv ~/Code/library/misc_notes/gdb.md"
alias tcs="ttg && clear && sleep 99999"

# tmux
alias txp="tmux new-session \; run-shell \"$HOME/.bin/startup\""
alias txl="tmux list-sessions"
alias txr="tmux rename-window"
alias txk="tmux kill-session -t " 
alias txkc="tmux kill-session"
alias txid="tmux display-message -p -F '#{window_index}'"
alias txa="tmux attach-session -t "
alias txks="tmux kill-server"

# ffmpeg
mkv_to_mp4() {
    pv $1 | ffmpeg -i pipe:0 -hide_banner -loglevel error -c:v libx264 $2
}
rm_vid_audio() {
    pv $1 | ffmpeg -i pipe:0 -hide_banner -loglevel error -c copy -an $2
}

alias vid_frames="ffprobe -v error -select_streams v:0 -count_frames -show_entries stream=nb_read_frames -of csv=p=0"
    
# proxy
pdanet() {
    echo "Configuring proxy..."
    source $HOME/.bash_proxy &> /dev/null
    echo -ne "\033[1A\033[2K"
}

# WSL
if grep -qi microsoft /proc/version; then

    # curl
    alias curl="cmd.exe /C curl"

    # Chrome 
    alias chrome="/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe"
fi

# opencd
alias openocd="/home/jvalcher/Repos/xpack-openocd-0.12.0-7/bin/openocd"

# Workflowy To Do (installed in Chrome)
alias wf_todo='/opt/google/chrome/google-chrome --profile-directory=Default --app-id=ifpboanaelncmlfhjbnnloipmogocahb'


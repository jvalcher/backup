#!/bin/bash

#################################
# Provision Ubuntu installation #
#################################

source ./_utils.sh
set -euo pipefail

echo
printf "Start ${MAGENTA}PROVISIONING${RESET} your system? (y/n) "
read -r answer
case "$answer" in
    [Yy]) ;;
    *) exit 0 ;;
esac
echo

start_time=$(date +%s)

#
# Misc
#
print_title "Create directories"

mkdir -vp "$HOME_DOWNLOADS_DIR"
mkdir -vp "$HOME_BIN_DIR"
mkdir -vp "$HOME_LOCAL_BIN_DIR"
mkdir -vp "$HOME_CONFIG_DIR"
mkdir -vp "$HOME_DOCS_DEV_DIR"
mkdir -vp "$HOME_PICS_WALLPAPERS_DIR"

#
# sudo
#
print_title "Configure \"$USER\" sudo"

echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER
sudo chmod -v 0440 "/etc/sudoers.d/$USER"
sudo visudo -cf "/etc/sudoers.d/$USER"

#
# Apt
#
print_title "Apt"

apt_packages=(

    # System utilities
    coreutils
    htop
    adb
    tree
    ripgrep
    rsync
    blueman
    bluez
    dbus
    dconf-cli
    deja-dup
    dkms
    dpkg
    fdisk
    feh
    ffmpeg
    fuse3
    gnome-system-monitor
    gnome-tweaks
    gparted
    rlwrap
    trash-cli
    unattended-upgrades
    wmctrl
    xdotool
    gnome-shell-extension-manager
    xclip

    # Packaging
    snapd
    flatpak

    # Net
    curl
    wget
    ftp
    network-manager
    openssl
    filezilla

    # Terminal, editor
    tmux
    vim-gtk3

    # Compress
    zip
    unzip
    tar
    7zip
    gzip
    bzip2
    xz-utils

    # Misc apps
    gimp
    mupen64plus-ui-console
    mupen64plus-video-all
    mupen64plus-rsp-all
    mupen64plus-audio-all
    mupen64plus-input-all
    mupen64plus-data
    obs-studio
    okular

    # Libs
    libssl-dev
    libreadline-dev
    libncurses-dev
    libglib${GLIB_VER}-dev

    # Dev compilers, interpreters
    build-essential
    gcc
    cpp
    g++
    clang
    clang-format
    llvm
    meson
    python${PYTHON_VER}
    python${PYTHON_VER}-pip
    python${PYTHON_VER}-venv
    golang-go
    java-common
    javascript-common
    lua${LUA_VER}
    liblua${LUA_VER}-dev
    luajit
    luarocks
    perl
    pipx
    ruby

    # Dev misc
    git
    git-man
    make
    autoconf
    automake
    autotools-dev
    gdb
    strace
    ltrace
    valgrind
    cmake
    pkg-config
    universal-ctags
    bpftrace
    cloc
    gperf
    jq
    flex
    bison
    mysql-common
    ninja-build
    npm
)
sudo apt update
sudo apt upgrade -y
sudo apt install -y "${apt_packages[@]}"

#
# Snap
#
print_title "Snap"

snap_packages=(
    spotify
    steam
    vlc
    transmission
    arduino-cli
)
for snap_pkg in "${snap_packages[@]}"; do
    snap list "$snap_pkg" >/dev/null 2>&1 || sudo snap install "$snap_pkg"
done

snap_classic_packages=(
    shotcut
)
for snap_pkg in "${snap_classic_packages[@]}"; do
    snap list "$snap_pkg" >/dev/null 2>&1 || sudo snap install "$snap_pkg" --classic
done

#
# pip3
#
print_title "pipx"

pipx_packages=(
    gnome-extensions-cli
)
for pipx_pkg in "${pipx_packages[@]}"; do
    pipx install "$pipx_pkg" --system-site-packages
done

#
# Brew
#
print_title "Brew"

if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [[ -d "$HOME/.linuxbrew" ]]; then
    eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
line='eval "$($(brew --prefix)/bin/brew shellenv)"'
grep -qxF "$line" ~/.bashrc || echo "$line" >> ~/.bashrc

brew_packages=(
    tree-sitter-cli
    neovim
)
brew install "${brew_packages[@]}" -y

#
# Rust
#
print_title "Rust"

if ! command -v rustup >/dev/null 2>&1; then
    cd "$HOME_DOWNLOADS_DIR"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    . "$HOME/.cargo/env"
fi
cargo_packages=(
    caligula
)
cargo install "${cargo_packages[@]}"

#
# Lua extras
#
print_title "Lua extras"

sudo luarocks show luasec >/dev/null 2>&1 || \
    sudo luarocks --lua-version="$LUA_VER" install luasec
sudo luarocks show luasocket >/dev/null 2>&1 || \
    sudo luarocks --lua-version="$LUA_VER" install luasocket
#luarocks --lua-version=$LUA_VER list

#
# Kitty terminal
#
print_title "Kitty terminal"

if ! command -v kitty >/dev/null 2>&1; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty
    ln -sf ~/.local/kitty.app/bin/kitten ~/.local/bin/kitten

    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/

    sed -i "s|Icon=kitty|Icon=$HOME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=$HOME/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

    echo 'kitty.desktop' > ~/.config/xdg-terminals.list
fi

#
# NordVPN
#
print_title "NordVPN"

if ! command -v nordvpn >/dev/null 2>&1; then
    cd "$HOME_DOWNLOADS_DIR"
    sh <(wget -qO - https://downloads.nordcdn.com/apps/linux/install.sh) -p nordvpn-gui
fi

#
# Chrome
#
print_title "Chrome"

if ! command -v google-chrome >/dev/null 2>&1; then
    cd "$HOME_DOWNLOADS_DIR"
    wget -O google-chrome-stable_current_amd64.deb \
        https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt install -f -y
fi

#
# GNOME settings, extensions
#
print_title "GNOME settings, extensions"

dconf load / < "$BACKUP_GNOME_DIR/gnome-settings.dconf"
gnome_extensions=(
    window-state-manager@kishorv06.github.io
    simple-timer@majortomvr.github.com
    dash-to-panel@jderose9.github.com
    bluetooth-quick-connect@bjarosze.gmail.com
    notification-position@drugo.dev
)
for ext in "${gnome_extensions[@]}"; do
    gext install "$ext"
    gext enable "$ext"
done
dconf load /org/gnome/shell/extensions/ < "$BACKUP_GNOME_DIR/extensions.dconf"

#
# Global C/C++ library ctags
#
print_title "Global ctags"

if [[ ! -f "$HOME_TAGS_FILE" ]]; then
    "$HOME_BIN_DIR/gen_ctags_linux"
fi

#
# GNOME taskbar favorites
#
print_title "GNOME taskbar favorites"

# Remove
taskbar_fav_removes=(
     "org.gnome.Terminal.desktop"
     "yelp.desktop"
     "firefox_firefox.desktop"
     "thunderbird_thunderbird.desktop"
)
for fav in "${taskbar_fav_removes[@]}"; do
    favorites=$(gsettings get org.gnome.shell favorite-apps)
    new_favorites=$(echo "$favorites" | sed "s/'${fav}', //g; s/, '${fav}'//g; s/'${fav}'//g")
    gsettings set org.gnome.shell favorite-apps "$new_favorites"
done

# Add
taskbar_favs=(
    "org.gnome.Nautilus.desktop"
    "kitty.desktop"
    "org.gnome.Settings.desktop"
    "gnome-system-monitor_gnome-system-monitor.desktop"
    "blueman-manager.desktop"
    "nordvpn-gui.desktop"
    "google-chrome.desktop"
)
favorites="["
for app in "${taskbar_favs[@]}"; do
    favorites+="'$app', "
done
favorites="${favorites%, }]"
gsettings set org.gnome.shell favorite-apps "$favorites"
#gsettings get org.gnome.shell favorite-apps

#
# Set core dump location to pwd
#
print_title "Set core dump location to pwd"

sudo systemctl stop apport.service
sudo systemctl disable apport.service
sudo tee /etc/sysctl.d/60-core-pattern.conf >/dev/null <<EOF
kernel.core_pattern = core
EOF
sudo sysctl --system

#
# Files
#
print_title "Update files"

rsync -av "$BACKUP_HOME_DIR"/ $HOME
sync_dirs "$BACKUP_BIN_DIR" "$HOME_BIN_DIR"
sync_dirs "$BACKUP_DOCS_DEV_DIR" "$HOME_DOCS_DEV_DIR"
sync_dirs "$BACKUP_PICS_WALLPAPERS_DIR" "$HOME_PICS_WALLPAPERS_DIR"

for dir in "${config_dirs[@]}"; do
    sync_dirs "$BACKUP_CONFIG_DIR/$dir" "$HOME_CONFIG_DIR/$dir"
done

#
# Apt cleanup
#
print_title "Apt cleanup"

sudo apt autoremove -y

#
###
#
end_time=$(date +%s)
elapsed=$((end_time - start_time))

printf "\n\n"
printf "Completed in %02d:%02d:%02d\n" \
    $((elapsed / 3600)) \
    $(((elapsed % 3600) / 60)) \
    $((elapsed % 60))
printf "\n"


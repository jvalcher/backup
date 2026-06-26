
#
# Variables
#

HOME_BIN_DIR="$HOME/.bin"
HOME_LOCAL_BIN_DIR="$HOME/.local/bin"
HOME_CONFIG_DIR="$HOME/.config"
config_dirs=(
    kitty
    mupen64plus
    nvim
)
HOME_DOCS_DEV_DIR="$HOME/Documents/dev"
HOME_PICS_WALLPAPERS_DIR="$HOME/Pictures/wallpapers"
HOME_DOWNLOADS_DIR="$HOME/Downloads"
HOME_TAGS_FILE="$HOME/.tags_linux"

BACKUP_DIR="files"
BACKUP_HOME_DIR="$BACKUP_DIR/home"
BACKUP_BIN_DIR="$BACKUP_DIR/bin"
BACKUP_CONFIG_DIR="$BACKUP_DIR/config"
BACKUP_GNOME_DIR="$BACKUP_DIR/gnome"
BACKUP_DOCS_DEV_DIR="$BACKUP_DIR/Documents/dev"
BACKUP_PICS_WALLPAPERS_DIR="$BACKUP_DIR/Pictures/wallpapers"

PYTHON_VER="3"
LUA_VER="5.3"
GLIB_VER="2.0"

GREEN="\033[1;32m"
MAGENTA="\033[35m"
RED="\033[1;31m"
CYAN="\033[1;36m"
RESET="\033[0m"

#
# Functions
#

print_title() {
    echo
    printf '%b\n' "-------"
    printf " ${GREEN}${1}${RESET}\n"
    printf '%b\n\n' "-------"
}

# Make directory $2 contents the same as directory $1
sync_dirs() {
    echo ""
    printf "${MAGENTA}${1}/\* ${RESET}==>${CYAN} ${2}/\*\n${RESET}"
    rsync -avu --delete ${1}/ ${2}
}


#!/bin/bash

##############################
# Backup Ubuntu system files #
##############################

source ./_utils.sh
set -euo pipefail



#
# Backup files
#

echo
printf "Start ${GREEN}BACKING UP${RESET} your system? (y/n) "
read -r answer
case "$answer" in
    [Yy]) ;;
    *) exit 0 ;;
esac
echo "Backing up files ... "

#
# ~
#
print_title "$HOME"

mkdir -pv "$BACKUP_HOME_DIR"
rm -rfv "$BACKUP_HOME_DIR/*"
cp  -v "$HOME/.bashrc"          $BACKUP_HOME_DIR
cp  -v "$HOME/.bash_aliases"    $BACKUP_HOME_DIR
cp  -v "$HOME/.bash_completion" $BACKUP_HOME_DIR
cp  -v "$HOME/.gdbinit"         $BACKUP_HOME_DIR
cp  -v "$HOME/.gitconfig"       $BACKUP_HOME_DIR
cp  -v "$HOME/.inputrc"         $BACKUP_HOME_DIR
cp  -v "$HOME/.profile"         $BACKUP_HOME_DIR
cp  -v "$HOME/.selected_editor" $BACKUP_HOME_DIR
cp  -v "$HOME/.tmux.conf"       $BACKUP_HOME_DIR
cp  -v "$HOME/.vimrc"           $BACKUP_HOME_DIR

#
# ~/.bin
#
print_title "$HOME_BIN_DIR"

mkdir -pv "$BACKUP_BIN_DIR"
sync_dirs "$HOME_BIN_DIR" "$BACKUP_BIN_DIR"
rm -rfv $BACKUP_BIN_DIR/__pycache__

#
# ~/.config
#
print_title "$HOME_CONFIG_DIR"

mkdir -pv "$BACKUP_CONFIG_DIR"
for dir in "${config_dirs[@]}"; do
    mkdir -pv "$BACKUP_CONFIG_DIR/$dir"
    sync_dirs "$HOME_CONFIG_DIR/$dir" "$BACKUP_CONFIG_DIR/$dir"
done

#
# GNOME
#
print_title "GNOME"

mkdir -pv "$BACKUP_GNOME_DIR"
dconf dump / > $BACKUP_GNOME_DIR/gnome-settings.dconf
dconf dump /org/gnome/shell/extensions/ > $BACKUP_GNOME_DIR/extensions.dconf

#
# ~/Documents/dev
#
print_title "$HOME_DOCS_DEV_DIR"
mkdir -pv "$BACKUP_DOCS_DEV_DIR"
sync_dirs "$HOME_DOCS_DEV_DIR" "$BACKUP_DOCS_DEV_DIR"

#
# ~/Pictures/wallpapers
#
print_title "$HOME_PICS_WALLPAPERS_DIR"
mkdir -pv "$BACKUP_PICS_WALLPAPERS_DIR"
sync_dirs "$HOME_PICS_WALLPAPERS_DIR" "$BACKUP_PICS_WALLPAPERS_DIR"


echo ""
echo "Backup complete"
echo ""


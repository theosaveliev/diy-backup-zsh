#!/bin/zsh

# dirs
HOME="/Users/username"
DOCUMENTS="$HOME/Documents"
VAULT=sandisk-0-vault

# common
source "$HOME/PycharmProjects/diy-backup-zsh/common.sh"

#########
# vault #
#########

# legal-archive
check_git_status "$DOCUMENTS/legal-archive"
sync_crypt "$DOCUMENTS/legal-archive/.git" "$VAULT"':legal-archive.git'
print_file_count "$DOCUMENTS/legal-archive/.git"
echo ""

echo "Done"

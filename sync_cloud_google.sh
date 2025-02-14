#!/bin/zsh

# dirs
HOME="/Users/username"
DOCUMENTS="$HOME/Documents"

# common
source "$HOME/PycharmProjects/diy-backup-zsh/common.sh"

#########
# plain #
#########

# legal-archive
check_git_status "$DOCUMENTS/legal-archive"
sync_plain "$DOCUMENTS/legal-archive/.git" 'google:legal-archive.git'
print_file_count "$DOCUMENTS/legal-archive/.git"
echo ""

echo "Done"

#!/bin/zsh
set -e
TIMEFMT='Elapsed time: %*E seconds'

FIND='/usr/bin/find'
WC='/usr/bin/wc'
RCLONE='/opt/homebrew/bin/rclone'
GIT='/opt/homebrew/bin/git'

function print_file_count {
	path="$1"

	count=$($FIND "$path" -type f | $WC -l)
	echo "Total number of files: $count"
}

function check_git_status {
	repo="$1"

	echo "Checking Git status at: $repo"
	if [ -n "$(time $GIT -C "$repo" status --porcelain)" ]
	then
		echo "Error: uncommitted changes"
		exit 1
	fi
}

function sync_plain {
	src="$1"
	dest="$2"

	echo "Checking plaintext at: $dest"
	if (time $RCLONE check --fast-list --quiet "$src" "$dest")
	then
		echo "Destination is up to date: $dest"
	else
		if (time $RCLONE sync --track-renames --fast-list --quiet "$src" "$dest")
		then
			echo "Synced: $dest"
		else
			echo "Error $? at: $dest"
			exit 1
		fi
	fi
}

function sync_crypt {
	src="$1"
	dest="$2"

	echo "Checking crypt at: $dest"
	if (time $RCLONE cryptcheck --fast-list --quiet "$src" "$dest")
	then
		echo "Destination is up to date: $dest"
	else
		if (time $RCLONE sync --fast-list --quiet "$src" "$dest")
		then
			echo "Synced: $dest"
		else
			echo "Error $? at: $dest"
			exit 1
		fi
	fi
}

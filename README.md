diy-backup-zsh
==============

Usage
-----

Create Git post-commit hooks as follows:

```
% cat legal-archive/.git/hooks/post-commit 
#!/bin/zsh

# dirs
HOME="/Users/username"
DOCUMENTS="$HOME/Documents"
ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

# common
source "$HOME/PycharmProjects/diy-backup-zsh/common.sh"

#########
# plain #
#########

# legal-archive
sync_plain "$DOCUMENTS/legal-archive/.git" "$ICLOUD/legal-archive.git"
sync_plain "$DOCUMENTS/legal-archive/.git" 'google:legal-archive.git'

echo "Done"
```

Rationale
---------

Git:

- Git guarantees data integrity since it uses SHA-256 hashes for addressing.
- Its object store has consistent file naming. That prevents issues with 
  special characters or long file names.
- Git object pack reduces the number of files and provides delta compression.
- Cross-platform, no vendor lock.
- Git is a mature product with production-grade reliability.

Rclone:

- Rclone offers a rich set of integrations with S3 and others: 
  [Overview of cloud storage systems](https://rclone.org/overview/).
- It uses hashes when comparing the files.
- It provides an encfs-like overlay.
- Cross-platform, no vendor lock.
- It is a mature product.

ZSH/BASH:

- This is the right tool to define environment variables, run another program 
  and check the exit code.
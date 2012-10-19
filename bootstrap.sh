#!/usr/bin/env sh
#
# Run this script at first install.
#

# Enable error checking on script
set -e

# Set some variables
WORKINGDIR=$(pwd)
DOTFILEDIR=$(dirname $(readlink -f $0))
BACKUPDIR=~/.dotfiles.bak
DOTFILES=$(ls -a $DOTFILEDIR | grep "^\." | grep -v -e "^..\?$" -e ".git")


# Clone down any git submodules
git submodule update --init

# Back up existing dotfiles
for file in $DOTFILES; do
    if [ -e ~/$file ]; then
        echo "Backing up $file..."
        mkdir -p $BACKUPDIR
        mv ~/$file $BACKUPDIR/
    fi
done

# Link the dotfiles into place
for file in $DOTFILES; do
    ln -s ${DOTFILEDIR}/${file} ~/${file}
done

# Create a local bin folder
mkdir -p ~/bin

# Update Vim's bundles.
# Couldn't get the pure CLI method to work. Replace this when I figure it out.
vim +BundleInstall! +BundleClean +qall

# Change shell to zsh
chsh -s /bin/zsh $(whoami)

# Prompt user to reload shell
echo "Reload your shell for changes to take effect."

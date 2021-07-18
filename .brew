#!/usr/bin/env bash

# Install Homebrew or make sure it's up to date
which -s brew
if [[ $? != 0 ]] ; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed. Updating..."
    brew update
    brew upgrade
fi

# Installs taps (repositories), brew (packages) and casks (applications)
brew bundle --no-lock --quiet

# Post-install tasks for packages
if [ ! -n "`$SHELL -c 'echo $FISH_VERSION'`" ] ; then
    echo "Setting default shell to fish..."
    sudo bash -c 'echo /usr/local/bin/fish >> /etc/shells'
    chsh -s /usr/local/bin/fish
else
    echo "Default shell is already fish."
fi


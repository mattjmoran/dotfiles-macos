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
brew bundle --no-lock --quiet --file=~/Brewfile

# Check default shell, set it to Fish
if [ ! -n "`$SHELL -c 'echo $FISH_VERSION'`" ] ; then
    echo "Setting default shell to fish..."
    FISH=$(which fish)
    echo "$FISH" | sudo tee -a /etc/shells
    chsh -s $FISH
else
    echo "Default shell is already fish."
fi

# Check default browser, set it to Firefox
defaultbrowser | grep firefox
if [ $? == 0 ] ; then
    defaultbrowser firefox
fi

# Set the system wallpaper to "DefaultDesktop.jpg"
wallpaper set ../DefaultDesktop.jpg

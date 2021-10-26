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
    sudo bash -c 'echo /usr/local/bin/fish >> /etc/shells'
    chsh -s /usr/local/bin/fish
else
    echo "Default shell is already fish."
fi

# Check default browser, set it to Firefox
defaultbrowser | grep firefox
if [ $? == 0 ] ; then
    defaultbrowser firefox
fi

# Check to see if skhd is running, restart or start service based on result
brew services list | grep skhd
if [ $? != 0 ] ; then
    brew services start skhd
else
    brew services restart skhd
fi

# Check to see if yabai is running, restart or start & install SA based on resut
brew services list | grep yabai
if [ $? != 0 ] ; then
    brew services start yabai
    sudo yabai --install-sa
else
    brew services restart yabai
fi

# Check to see if spacebar is running, restart or start service based on result
brew services list | grep spacebar
if [ $? != 0 ] ; then
    brew services start spacebar
else
    brew services restart spacebar
fi

# Set the system wallpaper to "DefaultDesktop.jpg"
wallpaper set DefaultDesktop.jpg

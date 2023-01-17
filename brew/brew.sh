#!/usr/bin/env bash

#################################################################################
#
# 1. Install Homebrew or make sure it's up to date
#
#################################################################################

which -s brew
if [[ $? != 0 ]] ; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed. Updating and upgrading..."
    brew update
    brew upgrade
fi

#################################################################################
# 
# 2. Installs taps (repositories), brew (packages) and casks (applications)
#
#################################################################################

brew bundle --no-lock --quiet --file=~/Brewfile

#################################################################################
#
# 3. Set the default shell to fish if it's not already
#
#################################################################################

# Apple Silicon
if [ "$(uname -m)" == "arm64" ] ; then
    if [ "$SHELL" != "/opt/homebrew/bin/fish" ] ; then
        echo "Setting default shell to fish (apple silicon)..."
        sudo sh -c "echo /opt/homebrew/bin/fish >> /etc/shells"
        chsh -s /opt/homebrew/bin/fish
    fi
fi

# Intel
if [ "$(uname -m)" == "x86_64" ] ; then
    if [ "$SHELL" != "/usr/local/bin/fish" ] ; then
        echo "Setting default shell to fish (intel)..."
        sudo sh -c "echo /usr/local/bin/fish >> /etc/shells"
        chsh -s /usr/local/bin/fish
    fi
fi

#################################################################################
#
# 4. Check default browser, set it to Firefox if it's not already
#
#################################################################################

defaultbrowser | grep "* firefox"
if [ $? == 1 ] ; then
    defaultbrowser firefox
fi

#################################################################################
#
# 5. Set the system wallpaper to "macos/wallpaper.png"
#
#################################################################################

# Source: https://www.reddit.com/r/wallpaper/comments/10d97hz/gruvbox_abstract_shapes_7680x4320/
# Image modified by me to match the snazzy theme
wallpaper set ~/dotfiles/macos/wallpaper.jpg

#################################################################################
#
# 6. Setup Brew autoupdate on a daily interval
#
#################################################################################

# SUDO_ASKPASS is required for brew autoupdate to work
export SUDO_ASKPASS=/usr/local/bin/brew

# Need LaunchAgents directory for brew autoupdate
mkdir -p /Users/$(whoami)/Library/LaunchAgents

# Set the autoupdate interval to 1 day and enable notifications
launchctl list | grep brew.autoupdate
if [ $? == 1 ] ; then
    brew autoupdate start 1 --upgrade --cleanup
fi

#################################################################################
#
# 7. Start spacebar or restart it if it's already running (brew service)
#
#################################################################################

brew services list | grep spacebar
if [ $? == 1 ] ; then
    brew services start spacebar
else
    brew services restart spacebar
fi

#################################################################################
#
# 8. Start yabai or restart it if it's already running (brew service)
#
#################################################################################

brew services list | grep yabai
if [ $? == 1 ] ; then
    brew services start yabai
else
    brew services restart yabai
fi

#################################################################################
#
# 9. Add a Firefox CSS theme to the user's profile (SimpleFox theme)
#
#################################################################################

# Kill Firefox if it's running
killall firefox
# Don’t pollute your current directory
mkdir ffcss; cd ffcss
# Install the latest release by downloading the binary on Github
git clone "https://github.com/migueravila/SimpleFox.git"
# Adjust the theme to match the snazzy theme
# Replace this line   --sfwindow: #19171a;
# With this line      --sfwindow: #282a36;
sed -i '' 's/--sfwindow: #19171a;/--sfwindow: #282a36;/g' SimpleFox/chrome/userChrome.css
# Replace this line   --sfsecondary: #201e21;
# With this line      --sfsecondary: #2E313D;
sed -i '' 's/--sfsecondary: #201e21;/--sfsecondary: #2E313D;/g' SimpleFox/chrome/userChrome.css
# Copy the theme to the Firefox profile
cp -r SimpleFox ~/.mozilla/firefox/*.default-release/chrome
for dir in /Users/$(whoami)/Library/Application\ Support/Firefox/Profiles/*; do
    if [ -d "$dir" ]; then
        cp -r SimpleFox/chrome "$dir"
    fi
done
# Edit the firefox.cfg file to enable the theme
echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> ~/.mozilla/firefox/*.default-release/prefs.js
echo 'user_pref("layers.acceleration.force-enabled", true);' >> ~/.mozilla/firefox/*.default-release/prefs.js
echo 'user_pref("gfx.webrender.all", true);' >> ~/.mozilla/firefox/*.default-release/prefs.js
echo 'user_pref("svg.context-properties.content.enabled", true);' >> ~/.mozilla/firefox/*.default-release/prefs.js
for dir in /Users/$(whoami)/Library/Application\ Support/Firefox/Profiles/*; do
    if [ -d "$dir" ]; then
        echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> "$dir/prefs.js"
        echo 'user_pref("layers.acceleration.force-enabled", true);' >> "$dir/prefs.js"
        echo 'user_pref("gfx.webrender.all", true);' >> "$dir/prefs.js"
        echo 'user_pref("svg.context-properties.content.enabled", true);' >> "$dir/prefs.js"
    fi
done
# Remove the themes contents
cd ..; rm -rf ffcss

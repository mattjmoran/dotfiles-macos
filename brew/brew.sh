#!/usr/bin/env bash

#################################################################################
#
# 1. Install Homebrew or make sure it's up to date
#
#################################################################################

echo -e "\033[0;33m1. Install Homebrew or make sure it's up to date...\033[0m"

which -s brew
if [[ $? != 0 ]] ; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    # Stop brew services before updating
    brew services stop --all > /dev/null
    # Stop brew autoupdate (if it's running)
    launchctl list | grep brew.autoupdate > /dev/null
    if [ $? == 0 ] ; then
        brew autoupdate stop > /dev/null
    fi
    # Update and upgrade Homebrew
    echo "Homebrew already installed. Updating and upgrading..."
    brew update
    brew upgrade
fi

#################################################################################
# 
# 2. Install taps (repositories), brew (packages) and casks (applications)
#
#################################################################################

echo -e "\033[0;33m2. Installs taps (repositories), brew (packages) and casks (applications)...\033[0m"


brew bundle --no-lock --quiet --file=~/Brewfile

#################################################################################
#
# 3. Set the default shell to fish if it's not already
#
#################################################################################

echo -e "\033[0;33m3. Set the default shell to fish if it's not already...\033[0m"


# Check if the default shell is already fish
if [ "$SHELL" == "/opt/homebrew/bin/fish" ] || [ "$SHELL" == "/usr/local/bin/fish" ] ; then
    echo "Default shell is already fish. Skipping..."
else 
    # Set the default shell to fish
    case "$(uname -m)" in
        "arm64") # Apple Silicon
            echo "Setting default shell to fish (apple silicon)...";
            sudo sh -c "echo /opt/homebrew/bin/fish >> /etc/shells";
            chsh -s /opt/homebrew/bin/fish
        ;;
        "x86_64") # Intel
            echo "Setting default shell to fish (intel)...";
            sudo sh -c "echo /usr/local/bin/fish >> /etc/shells";
            chsh -s /usr/local/bin/fish
        ;;
    esac
fi

#################################################################################
#
# 4. Check default browser, set it to Firefox if it's not already
#
#################################################################################

echo -e "\033[0;33m4. Check default browser, set it to Firefox if it's not already...\033[0m"

defaultbrowser | grep "* firefox" > /dev/null
if [ $? == 1 ] ; then
    echo "Default browser is not Firefox. Setting default browser to Firefox..."
    defaultbrowser firefox
else
    echo "Default browser is already Firefox. Skipping..."
fi

#################################################################################
#
# 5. Set the system wallpaper to "macos/wallpaper.jpg"
#
#################################################################################

echo -e "\033[0;33m5. Set the system wallpaper to \"macos/wallpaper.png\"...\033[0m"

# Original wallpaper, PSD file and JPG file are in the "macos" folder
wallpaper set ~/dotfiles/macos/wallpaper.jpg
echo "Wallpaper set to ~/dotfiles/macos/wallpaper.jpg"

#################################################################################
#
# 6. Setup Brew autoupdate on a daily interval
#
#################################################################################

echo -e "\033[0;33m6. Setup Brew autoupdate on a daily interval...\033[0m"

# SUDO_ASKPASS is required for brew autoupdate to work
export SUDO_ASKPASS=/usr/local/bin/brew

# Need LaunchAgents directory for brew autoupdate
mkdir -p /Users/$(whoami)/Library/LaunchAgents

# Set the autoupdate interval to 12 hours
launchctl list | grep brew.autoupdate > /dev/null
if [ $? == 1 ] ; then
    brew autoupdate start 43200 --upgrade --cleanup
fi

#################################################################################
#
# 7. Start spacebar or restart it if it's already running (brew service)
#
#################################################################################

echo -e "\033[0;33m7. Start spacebar or restart it if it's already running (brew service)...\033[0m"

brew services list | grep spacebar > /dev/null
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

echo -e "\033[0;33m8. Start yabai or restart it if it's already running (brew service)...\033[0m"

brew services list | grep yabai > /dev/null
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

echo -e "\033[0;33m9. Add a Firefox CSS theme to the user's profile (SimpleFox theme)...\033[0m"

# Kill Firefox if it's running
if pgrep -x "firefox" > /dev/null; then
    echo "Firefox is running. Killing it..."
    killall firefox > /dev/null
fi
# Don’t pollute your current directory
mkdir ffcss > /dev/null; cd ffcss
# Install the latest release by downloading the binary on Github
git clone "https://github.com/migueravila/SimpleFox.git"
# Adjust the theme to match the snazzy theme
# Replace this line   --sfwindow: #19171a;
# With this line      --sfwindow: #282a36;
sed -i '' 's/--sfwindow: #19171a;/--sfwindow: #282a36;/g' SimpleFox/chrome/userChrome.css
# Replace this line   --sfsecondary: #201e21;
# With this line      --sfsecondary: #2E313D;
sed -i '' 's/--sfsecondary: #201e21;/--sfsecondary: #2E313D;/g' SimpleFox/chrome/userChrome.css
# Open Firefoxe and wait for it to create the profile
echo "Opening Firefox to create the profile..."
open -a Firefox
sleep 5
killall firefox > /dev/null
# Copy the theme to the profile
for dir in /Users/$(whoami)/Library/Application\ Support/Firefox/Profiles/*; do
    if [ -d "$dir" ]; then
        echo "Copying the theme to $dir"
        # Delete the old theme
        rm -rf "$dir/chrome"
        # Copy the new theme
        cp -r SimpleFox/chrome "$dir"
    fi
done
# Edit the firefox.cfg file to enable the theme
for dir in /Users/$(whoami)/Library/Application\ Support/Firefox/Profiles/*; do
    if [ -d "$dir" ]; then
        echo "Appending the following lines to $dir/firefox.cfg:"
        echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> "$dir/prefs.js"
        echo 'user_pref("layers.acceleration.force-enabled", true);' >> "$dir/prefs.js"
        echo 'user_pref("gfx.webrender.all", true);' >> "$dir/prefs.js"
        echo 'user_pref("svg.context-properties.content.enabled", true);' >> "$dir/prefs.js"
    fi
done
# Remove the themes contents
cd ..; rm -rf ffcss

#################################################################################
#
# 10. Install Fluent Spotify theme
#
#################################################################################

echo -e "\033[0;33m10. Install the Snazzy Dribbblish Spotify theme...\033[0m"

# Kill Spotify if it's running
if pgrep -x "Spotify" > /dev/null; then
    echo "Spotify is running. Killing it..."
    killall Spotify > /dev/null
fi
# Move to the Spicetify folder
cd "$(dirname "$(spicetify -c)")/Themes/"
# Clone the theme repo, Dribbblish https://github.com/spicetify/spicetify-themes/tree/master/Dribbblish
git clone https://github.com/spicetify/spicetify-themes.git
# See if a Dribbblish folder already exists and delete it
if [ -d "Dribbblish" ]; then
    rm -rf Dribbblish
fi
# See if a color.ini file exists outside the theme (happens when an error occurs), delete it
if [ -f "color.ini" ]; then
    rm color.ini
fi
# Move the Dribbblish theme to the Themes folder
mv spicetify-themes/Dribbblish .
# Delete the spicetify-themes folder
rm -rf spicetify-themes
# Move to the Dribbblish directory
cd Dribbblish
# Remove unused files: all .png, .ps1 and .md files
find . -type f -name "*.png" -delete
find . -type f -name "*.ps1" -delete
find . -type f -name "*.md" -delete
# Append the custom Snazzy color theme to the color.ini file
echo "

[snazzy]
text               = F1F1F0
subtext            = EFF0EB
sidebar-text       = F1F1F0
main               = 282a36
sidebar            = 2E313D
player             = 282a36
card               = 282a36
shadow             = 000000
selected-row       = 686868
button             = 5AF78E
button-active      = 5AF78E
button-disabled    = 686868
tab-active         = 57C7FF
notification       = F3F99D
notification-error = FF5C57
misc               = 686868" >> color.ini
# Run a backup of the current theme (in case you want to revert)
spicetify backup apply > /dev/null
# Apply the Snazzy Dribbblish theme
mkdir -p ../../Extensions
cp dribbblish.js ../../Extensions/.
spicetify config extensions dribbblish.js > /dev/null
spicetify config current_theme Dribbblish color_scheme snazzy > /dev/null
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1 > /dev/null
spicetify apply

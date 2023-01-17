#!/usr/bin/env bash

###############################################################################
# Snippets From .macos file by Mathias Byens            https://mths.be/macos #
###############################################################################

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set computer name (as done via System Preferences → Sharing)
NAME="MJM-MBP"
sudo scutil --set ComputerName "$NAME"
sudo scutil --set HostName "$NAME"
sudo scutil --set LocalHostName "$NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$NAME"

###############################################################################
# Dock                        https://macos-defaults.com/#💻-list-of-commands #
###############################################################################

# Set the Dock position (default value is "bottom")
defaults write com.apple.dock "orientation" -string "bottom"

# Set the icon size of Dock items in pixels (default value is 48)
defaults write com.apple.dock "tilesize" -int "36"

# Autohides the Dock (default value is "false")
defaults write com.apple.dock "autohide" -bool "true"

# Change the Dock opening and closing animation times (default value is 0.5)
defaults write com.apple.dock "autohide-time-modifier" -float "0"

# Change the Dock opening delay (default value is 0.5)
defaults write com.apple.dock "autohide-delay" -float "0"

# Show recently used apps in a seperate section of the Dock (default value is "true")
defaults write com.apple.dock "show-recents" -bool "false"

# Change the Dock minimize animation (default value is "genie")
defaults write com.apple.dock "mineffect" -string "scale" && killall Dock

# Only show opened apps in Dock (default value is "false")
defaults write com.apple.dock "static-only" -bool "true"

###############################################################################
# Screenshots                 https://macos-defaults.com/#💻-list-of-commands #
###############################################################################

# Disable screenshot shadow when capturing an app (default value is "false")
defaults write com.apple.screencapture "disable-shadow" -bool "false" 

# Include date and time in screenshot filenames (default value is "true")
defaults write com.apple.screencapture "include-date" -bool "false" 

# Set default screenshot location (default value is "~/Desktop")
defaults write com.apple.screencapture "location" -string "~/Desktop"

# Choose whether to display a thumbnail after taking a screenshot (default value is "true")
defaults write com.apple.screencapture "show-thumbnail" -bool "false" 

# Choose the screenshots image format (default value is "png")
defaults write com.apple.screencapture "type" -string "png" 

###############################################################################
# Finder                      https://macos-defaults.com/#💻-list-of-commands #
###############################################################################

# Add a quit option to the Finder (default value is "false")
defaults write com.apple.finder "QuitMenuItem" -bool "false"

# Show all filename extensions in the Finder (default value is "false")
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Show hidden files in the Finder (default value is "false")
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"

# Show path bar in the bottom of the Finder windows (default value is "false")
defaults write com.apple.finder "ShowPathbar" -bool "true"

# Set the default view style for folders without custom setting (default value is "icnv")
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# Keep folders on top when sorting by name (default value is "false")
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Keep folders on top when sorting by name (default value is "false")
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Set the default search scope when performing a search (default value is "SCev")
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

# Remove items in the bin after 30 days (default value is "false")
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"

# Choose whether to display a warning when changing a file extension (default value is "true")
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

# Choose whether the default file save location is on disk or iCloud (default value is "true")
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool "true"

# Choose the delay of the auto-hidden document-proxy icon (default value is "0.5")
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"

# Choose the size of Finder sidebar icons (default value is "2")
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "1"

###############################################################################
# Desktop                     https://macos-defaults.com/#💻-list-of-commands #
###############################################################################

# Keep folders on top when sorting (default value is "false")
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"

# Hide all icons on desktop (default value is "true")
defaults write com.apple.finder "CreateDesktop" -bool "true"

# Show hard disks on desktop (default value is "false")
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool "false" 

# Hide external disks on desktop (default value is "true")
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "true"

# Hide removable media on desktop (default value is "true")
defaults write com.apple.finder "ShowRemovableMediaOnDesktop" -bool "true"

# Show connected servers on desktop (default value is "false")
defaults write com.apple.finder "ShowMountedServersOnDesktop" -bool "false"

###############################################################################
# Menu Bar                    https://macos-defaults.com/#💻-list-of-commands #
###############################################################################

# When enabled, the clock indicator will flash on and off each second. (default value is "false")
defaults write com.apple.menuextra.clock "FlashDateSeparators" -bool "true"

###############################################################################
# Mission Control             https://macos-defaults.com/#💻-list-of-commands #
###############################################################################

# Choose whether to rearrange Spaces automatically (default value is "true")
defaults write com.apple.dock "mru-spaces" -bool "false"

###############################################################################
# Feedback Assistant          https://macos-defaults.com/#💻-list-of-commands #
###############################################################################

# Choose whether to autogather large files when submitting a feedback report (default value is "true")
defaults write com.apple.appleseed.FeedbackAssistant "Autogather" -bool "false" 

###############################################################################
# TextEdit                    https://macos-defaults.com/#💻-list-of-commands #
###############################################################################

# Set default document format as rich text (.rtf) or plain text (.txt) (default value is "true")
defaults write com.apple.TextEdit "RichText" -bool "false"

###############################################################################
# Time Machine                https://macos-defaults.com/#💻-list-of-commands #
###############################################################################

# Prevent Time Machine from prompting to use newly connected storage as backup volumes (default value is "false")
defaults write com.apple.TimeMachine "DoNotOfferNewDisksForBackup" -bool "true" 

###############################################################################
# Activity Monitor            https://macos-defaults.com/#💻-list-of-commands #
###############################################################################

# How frequently Activity Monitor should update its data, in seconds (default value is "5")
defaults write com.apple.ActivityMonitor "UpdatePeriod" -int "1"

# Choose what information should be shown in the app's Dock icon, if any (default value is "0")
defaults write com.apple.ActivityMonitor "IconType" -int "6"

###############################################################################
# Miscellaneous                                                               #
###############################################################################

# Set the appearance to dark
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to 1'

# Set a blazingly fast keyboard repeat rate
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# Disable press-and-hold for keys in favor of key repeat (default value is "true")
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool "false"

# Hide spotlight tray-icon (default value is 0)
defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1

# Hide the menu bar (default value is "false")
defaults write NSGlobalDomain "_HIHideMenuBar" -bool "true"

# Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons (default value is "false")
defaults write com.apple.finder QuitMenuItem -bool "true"

# Disable the sound effects on boot (default value is "false")
# Don't believe this works anymore... 
sudo nvram SystemAudioVolume=" "

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
	"Dock" \
	"SystemUIServer" \
	"Finder" \
	"TextEdit"; do
	killall "${app}" &> /dev/null
done

echo "macOS Configuration Applied. Note that some of these changes require a logout/restart to take effect."

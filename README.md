# My macOS Dotfiles

@mattjmoran's 2021 MacBook Pro 14" | Apple M1 Pro | macOS Ventura 13.1  

## A "Snazzy" macOS Theme

Terminal color scheme: [Snazzy](https://github.com/sindresorhus/hyper-snazzy)

Desktop wallpaper: created by me using [Adobe Photoshop](macos/wallpaper.psd)

![Screenshot Desktop](https://i.imgur.com/tdkpOMz.png)  

![Screenshot Clean](https://imgur.com/R1AVGv5.png)

![Screenshot Tiled](https://imgur.com/R9OqkkC.png)  

![Screenshot Fullscreen](https://imgur.com/b349VU2.png)

## Details

- Window Manager: [Raycast](https://raycast.com/) w/ [Rectangle](https://rectangleapp.com/) Keyboard Shortcuts
- OS: macOS Ventura 13.1
- Terminal: [Fish](https://fishshell.com/) w/ [Starship](https://starship.rs/)
- Terminal Emulator: [Kitty](https://sw.kovidgoyal.net/kitty/)
- Fetch: [Neofetch](https://github.com/dylanaraps/neofetch)
- Bar: [Spacebar](https://github.com/cmacrae/spacebar)
- Editor: [Vim](https://www.vim.org/) / [VSCode](https://code.visualstudio.com/)
- App Launcher: [Raycast](https://raycast.com/)
- Font: [Meslo LG Nerd Font](https://www.nerdfonts.com/)
- Spotify: [Spicetify](https://spicetify.app/)

## Installation

### Homebrew

Homebrew being installed prior to the installation is **recommended**.

The installation scripts should install Homebrew if it isn't found. Due to it being a critical part of the installation, I recommend both installing and testing it to be safe.

If you do not have Homebrew installed, follow the instructions here:
[Homebrew Installation Documentation](https://docs.brew.sh/Installation)

### Apple Silicon

If you are using a system with an Apple Silicon CPU, run the following command prior to further setup:

```bash
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
```

### Installation Script

Install the latest version by using:

```bash
git clone https://github.com/mattjmoran/dotfiles.git --recursive && cd dotfiles && ./install.sh
```

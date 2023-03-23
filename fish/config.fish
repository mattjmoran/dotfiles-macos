if status is-interactive
    # Commands to run in interactive sessions can go here
    alias ls='exa -laFh --git'
    alias cat='bat'
    alias g++='g++-11'
    alias gcc='gcc-11'
    alias brewup='sh ~/brewup.sh'
end
fish_add_path /opt/homebrew/opt/cython/bin
fish_add_path ~/.ghcup/bin

# Starship prompt
starship init fish | source

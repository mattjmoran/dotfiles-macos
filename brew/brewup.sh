#!/usr/bin/env bash

# Errors
let "errors = 0"

# Brew Update
printf "\033[0;35m→ Updating Brew Packages...\033[0;0m\n\n"
if brew update ; then
    printf "\n\033[1;35mDone.\n"
else
    let "errors += 1"
    printf "\n\033[1;31mAn Error Occured with 'brew update'!\n"
fi

# Brew Upgrade
printf "\033[0;35m→ Upgrading Brew...\033[0;0m\n\n"
if brew upgrade ; then
    printf "\n\033[1;35mDone.\n"
else
    let "errors += 1"
    printf "\n\033[1;31mAn Error Occured with 'brew upgrade'!\n"
fi

# Brew Bundle
printf "\033[0;35m→ Installing Brew Bundle...\033[0;0m\n\n"
if brew bundle ; then
    printf "\n\033[1;35mDone.\n"
else
    let "errors += 1"
    printf "\n\033[1;31mAn Error Occured with 'brew bundle'!\n"
fi

# Results
if (( errors > 0 )) ; then
    printf "\033[0;31m(✖) "
else
    printf "\033[0;32m(✓) "
fi
printf "'brewup.sh' Done with $errors Errors.\033[0m\n"

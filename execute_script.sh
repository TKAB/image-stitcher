#!/usr/bin/env bash

# Created: 2016-10-22, Thomas Billicsich - pixlig
# Description: Takes two images, scans for an overlap and
#               merges them above each other


# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  # First try to load from a user install
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  # Then try to load from a root install
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

# Configure ruby and gemset
#rvm ruby-2.2.3

printf "ARG 1: $1\n"
printf "ARG 2: $2\n"


ruby ./image_stitcher.rb "$1" "$2"

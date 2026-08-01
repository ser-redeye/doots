#!/usr/bin/env zsh

################################
## EXPORT ENVIRONMENT VARIABLE #
################################

## DEBUG
# echo ">>> zshenv"

# path
typeset -U path
path=($HOME/neovim/bin ~/.local/bin /usr/bin $path)

# editor
export VISUAL="nvim"
export EDITOR="nvim"

# XDG Directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

# zsh
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export HISTFILE="$ZDOTDIR/.history"     # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

# bat
export BAT_CONFIG_DIR="$XDG_CONFIG_HOME/.bat" # Bat Config Directory
export BAT_CONFIG_PATH=$XDG_CONFIG_HOME/.bat/bat.conf # Bat Config Path location
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'" # Colors Manpages

# less
export LESSHISTFILE="$HOME"/.cache/less/history

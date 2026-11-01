# +-------+
# | DEBUG |
# +-------+
# echo ">>> zshrc"

# +---------+
# | HISTORY |
# +---------+

# Append to histfile instead of replacing when using multiple sessions
setopt APPEND_HISTORY
# Save each command with timestamp and duration.
setopt EXTENDED_HISTORY
# Don't display a previously found command.
setopt HIST_FIND_NO_DUPS
# Delete an old recorded command if same as the new command.
setopt HIST_IGNORE_ALL_DUPS
# Don't record a command that was just recorded.
setopt HIST_IGNORE_DUPS
# Don't record a command starting with a space.
setopt HIST_IGNORE_SPACE
# Write the command to histfile after it's finishes execution so that
# time taken is recorded correctly, if paired with `EXTENDED_HISTORY`.
#
# NOTE: I prefer this over SHARE_HISTORY as I want my sessiosn to be
# independent, there is always `fc -RI` when I do need history from an
# alt session.
setopt INC_APPEND_HISTORY_TIME
# Use system’s fcntl call for file locking operation.
setopt HIST_FCNTL_LOCK

# +---------------+
# | EXTRA OPTIONS |
# +---------------+

setopt nomatch # prints an error, when no matches found for a pattern 
setopt notify # Reports the status of background jobs immediately
unsetopt beep # Removes the annoying sound 

# +---------+
# | ALIASES |
# +---------+

source $ZDOTDIR/zsh-aliases

# +-----------+
# | FUNCTIONS |
# +-----------+

source $ZDOTDIR/zsh-functions

# +-----------+
# | VI KEYMAP |
# +-----------+

# Vi mode
bindkey -v
# Max wait time (in hundredths of a second) for a subsequent keypress
# when reading bound multi-character sequences.
#
# TODO: DO i need this? I copied from a blog I read which said
# "makes the switch between modes quicker."
# Experimenting for a while without this.
# export KEYTIMEOUT=1; # 10 ms

# In NORMAL mode, `v` edits the command in the default editor.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# In Ghostty, Ctrl+[ sends CSI `^[[91;5u` instead of `^[`.
# See ghostty-org/ghostty#5071.
bindkey -M viins '^[[91;5u' vi-cmd-mode
bindkey -M vicmd '^[[91;5u' vi-cmd-mode

# +-------------+
# | COMPLETIONS |
# +-------------+

source $ZDOTDIR/completion.zsh

# +----------+
# | BINDINGS |
# +----------+

# Move to the previous event in the history list
bindkey '^P' up-history
# Move to the new event in the history list
bindkey '^N' down-history
# Delete clear-screen on `ctrl+l`, since it's used by tmux (switch pane)
bindkey -r '^l'

# +-------------------+
# | Tool Integrations |
# +-------------------+

# Starship prompt
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"

# Zoxide
export _ZO_ECHO='1' # Zodixe will print the matched directory before navigating to it
eval "$(zoxide init --cmd cd zsh)"

# fzf key bindings and fuzzy completion
source <(fzf --zsh)

# +---------+
# | Plugins |
# +---------+

## Auto suggestions - unobtrusive and ghosttly
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

## Sudo Plugin - Esc+Esc to trigger
source $ZDOTDIR/plugins/sudo/sudo-plugin.zsh

## Syntax highlighting
## WARNING: Catppuccin theme must be loaded before zsh-syntax-highlighting.
source $ZDOTDIR/plugins/catppuccin-zsh-syntax-highlighting/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

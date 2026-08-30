# +-------+
# | DEBUG |
# +-------+
# echo ">>> zshrc"

# +---------+
# | HISTORY |
# +---------+

setopt APPEND_HISTORY # Append to history file instead of replacing when using multiple zsh sessions
setopt INC_APPEND_HISTORY # Append the command without waiting for shell exit
setopt HIST_FIND_NO_DUPS # Do not display a previously found event
setopt HIST_IGNORE_DUPS # Do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_SPACE # Do not record an event starting with a space 
setopt HIST_SAVE_NO_DUPS # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY # See previous commands that has been entered using different terminals

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
export KEYTIMEOUT=1

# Restore default behaviour overwritten due to vi mode
bindkey ^R history-incremental-search-backward 
bindkey ^S history-incremental-search-forward

# when in NORMAL mode, hit v to directly edit the command in the default editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
# In Ghostty, ctrl+[ sends CSI sequence `^[[91;5u` isof `^[`
# Refer to ghostty-org/ghostty#5071 for more info.
bindkey -M viins '^[[91;5u' vi-cmd-mode
bindkey -M vicmd '^[[91;5u' vi-cmd-mode

# +-------------+
# | COMPLETIONS |
# +-------------+

typeset -U fpath
fpath=($ZDOTDIR/zsh-custom-completions/ $fpath)
source $ZDOTDIR/completion.zsh

# +----------+
# | BINDINGS |
# +----------+

bindkey '^P' up-history # Move to the previous event in the history list
bindkey '^N' down-history # Move to the new event in the history list
bindkey -r '^l' # Remove clear-screen binding (ctrl+l) cuz used by tmux (switch pane)

# +-----+
# | OSC |
# +-----+

# OSC 1337
precmd () { echo -n "\x1b]1337;CurrentDir=$(pwd)\x07" }

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

# Change Cursor Plugin in vim
source $ZDOTDIR/plugins/vim-cursor-mode/vim-cursor-mode.zsh

## Auto suggestions - unobtrusive and ghosttly
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

## Sudo Plugin - Esc+Esc to trigger
source $ZDOTDIR/plugins/sudo/sudo-plugin.zsh

## Syntax highlighting
source $ZDOTDIR/plugins/catppuccin-zsh-syntax-highlighting/themes/catppuccin_macchiato-zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

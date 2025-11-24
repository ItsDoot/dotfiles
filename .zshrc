# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# PROMPT CONFIGURATION
PS1="%F{#E07515}%B%n@%m%b %1~:%f"

eval "$(starship init zsh)"

# ALIASES
alias vim="nvim"
alias vi="nvim"
alias hx="helix"

# CUSTOM COMMANDS

# Creates and enters the given directory
mkcdir() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

export FILE_MANAGER=nautilus

# Function to set terminal title
set_title() {
    echo -ne "\033]0;$1\007"
}

# Update title before command execution
preexec() {
    set_title "$1"
}

# Update title after command execution
precmd() {
    set_title "$(basename "$PWD") - $(whoami)@$(hostname)"
}

# For Flatpak applications
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"

# For my personal scripts
export PATH="$HOME/.local/bin:$PATH"
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# cargo
export PATH="$HOME/.cargo/bin:$PATH"

# nimble
export PATH="$HOME/.nimble/bin:$PATH"

# Bitwarden SSH Agent
export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"

. "$HOME/.local/share/../bin/env"

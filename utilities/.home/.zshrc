# Theme and OMZ config
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Zinit
#source ~/.zinit/bin/zinit.zsh
#zinit light Aloxaf/fzf-tab
#zinit light zsh-users/zsh-syntax-highlighting

# Completion styling
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
#zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init --cmd cd zsh)"
eval "$(zoxide init zsh)"
# Bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Source profile (put this near the end if you need it)
[ -f ~/.zsh_profile ] && source ~/.zsh_profile

# Finally: source Oh My Zsh AFTER all config
source $ZSH/oh-my-zsh.sh


# ----------------------------------- ENV -----------------------------------


# Path to your oh-my-zsh installation.
export ZSH="/Users/aadeshchandra/.oh-my-zsh"

# default to dev aws profile 
export AWS_PROFILE=dev-sso-profile
export SSH_KEY_PATH="~/.ssh"


# sublime as default editor
export EDITOR='subl -w'


# ----------------------------------- ZSH -----------------------------------
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# ZSH_THEME="spaceship"


# ----------------------------------- SOURCE -----------------------------------

source $HOME/.cargo/env

source $ZSH/oh-my-zsh.sh


# ----------------------------------- PATH -----------------------------------

# go binary
export PATH=/usr/local/go/bin:$PATH

# deno binary
export PATH=$HOME/.deno/bin:$PATH

# mysql binary
export PATH=/usr/local/mysql/bin:$PATH

# Volta binary
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# sublime
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

# brew
export PATH=/opt/homebrew/bin:$PATH

#postgres
export PATH=/Library/PostgreSQL/15/bin:$PATH
export PGCONFIG=/Library/PostgreSQL/15/bin/pg_config
export PGUSER=postgres
export PGDATA=/Library/PostgreSQL/15/data

export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/aadeshchandra/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Bun
export BUN_INSTALL="/Users/aadeshchandra/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# export PATH=/Users/aadeshchandra/.local/bin:$PATH



# ----------------------------------- ALIAS -----------------------------------


alias git-graph="git log --all --decorate --oneline --graph"
alias git-yeet="git reset --hard HEAD && git clean -fd"
alias ls="lsd"
alias cat="bat"
alias help='tldr'
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias speed-test="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias yn="yarn"
alias pn="pnpm"
alias dc="docker"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias zed="/Applications/Zed.app"

# ----------------------------------- fzf -----------------------------------

# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
export FZF_DEFAULT_COMMAND="rg --files"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh



# ----------------------------------- SSH -----------------------------------

# start up ssh-agent on login
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add


# ----------------------------------- pyenv -----------------------------------
# if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
# fi



# ----------------------------------- utility functions -----------------------------------
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}



# ----------------------------------- EXTRA -----------------------------------

# disable homebrew from updating on every run
export HOMEBREW_NO_AUTO_UPDATE=1


autoload -U bashcompinit
bashcompinit

# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
#   eval "$(pyenv virtualenv-init -)"
# fi


. $HOME/z/z.sh

eval "$(starship init zsh)"


# bun completions
[ -s "/Users/aadeshchandra/.bun/_bun" ] && source "/Users/aadeshchandra/.bun/_bun"




eval "$(atuin init zsh)"

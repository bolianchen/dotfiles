
# Aliases Definition
if [ -f ~/.dotfiles/sh_aliases ]; then
    . ~/.dotfiles/sh_aliases
fi

if [ "$(uname)" = "Darwin" ]; then
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# setup fzf for fuzzy search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"
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

# zsh tab completion on a empty line
# expand-or-complete-or-list-files
function expand-or-complete-or-list-files() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="ls "
        CURSOR=3
        zle list-choices
        zle backward-kill-word
    else
        zle expand-or-complete
    fi
}
zle -N expand-or-complete-or-list-files
# bind to tab
bindkey '^I' expand-or-complete-or-list-files

# unset less to disable oh-my-zsh executing less with -R flag
unset LESS;

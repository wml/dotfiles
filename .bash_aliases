alias ls='ls -lA --color=never'
alias lash='ls -lAsh '
alias e='emacs -nw'
alias cdd='cd ~/dotfiles'
alias tf='tail -f'

alias xfup='startxfce4'
alias xfdown='xfce4-session-logout --logout'

alias pygrep="find . -name '*.py' -type f -print0 | xargs -0 grep "
alias shgrep="find . -name '*.sh' -type f -print0 | xargs -0 grep "

alias gs='git status '
alias gd='git diff | less'
alias gdc='git diff --cached | less'
alias gc='git commit -m '
alias gp='git pull '
alias gh='git push '
alias gk='git checkout '
alias ga='git add '
alias gaa='git add -A '
alias gm='git merge '
alias gmm='git merge master'
alias gb='git blame '

alias git_clean='git reset --hard HEAD && git clean -d -f'

function gbf() {
    find . -name $1 | head -n 1 | xargs git blame
}

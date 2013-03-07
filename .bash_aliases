alias ls='ls -lA --color=never'
alias lash='ls -lAsh '
alias e='emacs -nw'
alias cdd='cd ~/dotfiles'
alias tf='tail -f'

alias xfup='startxfce4'
alias xfdown='xfce4-session-logout --logout'

alias pygrep="find . -name '*.py' -type f -print0 | xargs -0 grep "
alias pygrepi="find . -name '*.py' -type f -print0 | xargs -0 grep -i "
alias shgrep="find . -name '*.sh' -type f -print0 | xargs -0 grep "
alias shgrepi="find . -name '*.sh' -type f -print0 | xargs -0 grep -i "
alias fgrep="find . -type f | grep -v '\.git' | grep -v '\.tmbundle' | xargs file | grep ASCII | cut -d: -f1 | xargs grep "
alias fgrepi="find . -type f | grep -v '\.git' | grep -v '\.tmbundle' | xargs file | grep ASCII | cut -d: -f1 | xargs grep -i "

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
alias gr='git checkout -b '

alias git_clean='git reset --hard HEAD && git clean -d -f'

function gbf() {
    find . -name $1 | head -n 1 | xargs git blame
}

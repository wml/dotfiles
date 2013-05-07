# https://raw.github.com/git/git/master/contrib/completion/
. ~/git-prompt.sh
. ~/git-completion.bash 

PS1='\[\033[32m\][\h]\[\033[0m\] \u@\W\[\033[31m\]$(__git_ps1) \[\033[0m\]$ '

setterm -blength 0 2>&1 > /dev/null

export EDITOR='emacs -nw '

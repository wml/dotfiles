# https://raw.github.com/git/git/master/contrib/completion/
. ~/git-prompt.sh
. ~/git-completion.bash 

PS1='\[\033[32m\][\h]\[\033[0m\] \u@\W\[\033[31m\]$(__git_ps1) \[\033[0m\]$ '

which setterm >/dev/null 2>&1
if [ 0 -eq $? ]; then
    setterm -blength 0
fi

export EDITOR='emacs -nw '

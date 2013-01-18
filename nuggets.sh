# https://raw.github.com/git/git/master/contrib/completion/
. ~/git-prompt.sh
. ~/git-completion.bash 

PS1='\u@\W\[\033[31m\]$(__git_ps1) \[\033[0m\]$ '
setterm -blength 0

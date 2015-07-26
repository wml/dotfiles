. ~/.dot_arch

# https://raw.github.com/git/git/master/contrib/completion/
. ~/git-prompt.sh
. ~/git-completion.bash 

export PS1='\[\033[32m\][\h]\[\033[0m\] \u@\W\[\033[31m\]$(__git_ps1) \[\033[0m\]$ '
export EDITOR='emacs -nw '
export PATH="$HOME/scripts:$PATH"
export PAGER='less'

if [ -n "$ARCH" ]; then
    setterm -blength 0
    caps >/dev/null 2>&1
    enter >/dev/null 2>&1
fi

[ -f $HOME/.bash_aliases ] && . $HOME/.bash_aliases
[ -f $HOME/.archrc ] && . $HOME/.archrc
[ -f $HOME/.localrc ] && . $HOME/.localrc

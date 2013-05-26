# TODO: ability to turn groups on or off with env variable in bashrc

function utils_aliases() {
    alias ls='ls -lA --color=never'
    alias lash='ls -lAsh '
    alias e='emacs -nw'
    alias cdd='cd ~/dotfiles'
    alias tf='tail -f'
    alias ldate="date '+%Y%m%d'"
    alias df='df -h'
    alias du='du -sh'

    function cdl() {
        cd $* && /bin/ls -lA
    }
}

function arch_aliases() {
    alias xfup='startxfce4'
    alias xfdown='xfce4-session-logout --logout'
    alias up='sudo pacman -Syu'
}

function dev_aliases() {
    alias pygrep="find . -name '*.py' -type f -print0 | xargs -0 grep "
    alias pygrepi="find . -name '*.py' -type f -print0 | xargs -0 grep -i "
    alias shgrep="find . -name '*.sh' -type f -print0 | xargs -0 grep "
    alias shgrepi="find . -name '*.sh' -type f -print0 | xargs -0 grep -i "
    alias fgrep="find . -type f | grep -v '\.git' | grep -v '\.tmbundle' \
        | xargs file | grep -v ELF | cut -d: -f1 | xargs grep "
    alias fgrepi="find . -type f | grep -v '\.git' | grep -v '\.tmbundle' \
        | xargs file | grep -v ELF | cut -d: -f1 | xargs grep -i "
    alias cgrep='find . -name '\''*.cs'\'' -type f -print0 | xargs -0 grep '
    alias cgrepi='find . -name '\''*.cs'\'' -type f -print0 | xargs -0 grep -i '    
}

function git_aliases() {
    alias gs='git status '
    alias gd='git diff | less'
    alias gdc='git diff --cached | less'
    alias gdm='git diff master..`git branch | grep "*" | awk "{print \\$2}"` | less'
    alias gc='git commit -m '
    alias gp='git pull '
    alias gh='git push '
    alias gk='git checkout '
    alias gkm='git checkout master'
    alias ga='git add '
    alias gaa='git add -A '
    alias gm='git merge --no-commit --no-ff '
    alias gmm='gm master'
    alias gb='git blame '
    alias gr='git checkout -b '
    alias gw='git show '
    alias gl='git log '
    alias glb='git branch --list --remote'

    alias git-clean='git reset --hard HEAD && git clean -d -f'

    function gbf() {
        if [[ "" != $(echo "$1" | grep '\\') ]]; then
            # TODO: WML: use cygpath here instead?
            BASE=`pwd -P`/
            FILEPATH=`echo "$1" | sed -e 's%\\\\%/%g' -e 's%C:%/cygdrive/c%' `
            FILE=`echo $FILEPATH | sed "s%$BASE%%"`
            cd `dirname $FILE`
            gb `basename $FILE`
            cd -
        elif [ $# -eq 2 ]; then
            find . -name $1 | head -n $2 | tail -n 1 | xargs git blame
        else
            find . -name $1 | head -n 1 | xargs git blame
        fi
    }
}

function sec_aliases() {
    function gpg-read() {
        if [ $# -ne 1 ]; then
            echo 'ERROR: filename required. aborting...' >&2
            exit 187
        fi

        SUFFIX=$(echo $1 | grep -e '\.gpg$')
        if [[ "$SUFFIX" == "" ]]; then
            echo 'ERROR: file is not .gpg encrypted (bad suffix). aborting...' >&2
            exit 187
        fi
        
        EMAIL=$(cat ~/.gitconfig  | grep email | cut -d '=' -f 2 | xargs)
        if [[ "$EMAIL" == "" ]]; then
            echo 'ERROR: unable to get email address from ~/.gitconfig. aborting...' >&2
            exit 187
        fi

        FILE=$(basename $1)
        OUTPUT=/tmp/$(echo $FILE | sed 's/\.gpg$//')
        echo $OUTPUT
        
        WINPATH=$(cygpath.exe -ad $OUTPUT)

        gpg --decrypt --recipient "$EMAIL" "$1" > $OUTPUT
        chmod +x $OUTPUT # derp windows derp

        if [ $? -eq 0 ]; then
            cmd.exe /C start "$WINPATH"
        fi
    }
}

function cygwin_aliases() {
    alias explore='explorer.exe $(cygpath -ad `pwd`)'
}

utils_aliases
arch_aliases
dev_aliases
git_aliases
sec_aliases
cygwin_aliases

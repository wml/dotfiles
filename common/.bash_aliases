function utils_aliases() {
    LSOPTS="-lA"
    if [ -n "$ARCH" ]; then
        LSOPTS="$LSOPTS --color"
    elif [ -n "$MAC" ]; then
        LSOPTS="$LSOPTS -G"
    fi
    alias ls="ls $LSOPTS"
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

function dev_aliases() {
    alias pygrep="find . -name '*.py' -type f -print0 | xargs -0 grep "
    alias pygrepi="find . -name '*.py' -type f -print0 | xargs -0 grep -i "
    alias shgrep="find . -name '*.sh' -type f -print0 | xargs -0 grep "
    alias shgrepi="find . -name '*.sh' -type f -print0 | xargs -0 grep -i "
    alias fgrep="find . -type f | grep -v '\.git' | grep -v '\.tmbundle' \
        | xargs file | grep -v ELF | cut -d: -f1 | xargs grep "
    alias fgrepi="find . -type f | grep -v '\.git' | grep -v '\.tmbundle' \
        | xargs file | grep -v ELF | cut -d: -f1 | xargs grep -i "
    alias cgrep="find . -name '*.cs' -type f -print0 | xargs -0 grep "
    alias cgrepi="find . -name '*.cs' -type f -print0 | xargs -0 grep -i "
    alias mgrep="find . -name '*.[mh]' -type f -print0 | xargs -0 grep "
    alias mgrepi="find . -name '*.[mh]' -type f -print0 | xargs -0 grep -i "
}

function git_aliases_autocomplete() {
    __git_complete gd _git_diff
    __git_complete gdc _git_diff     
    __git_complete gc _git_commit
    __git_complete gp _git_pull
    __git_complete gh _git_push     
    __git_complete gk _git_checkout
    __git_complete ga _git_add
    __git_complete gm _git_merge
    __git_complete gw _git_show
    __git_complete gl _git_log
}
        
function git_aliases() {
    alias gs='git status '
    alias gdm='git diff master..`git branch | grep "*" | awk "{print \\$2}"` | less'
    alias gdmf='git diff master..`git branch | grep "*" | awk "{print \\$2}"` --name-status | less'    
    alias gc='git commit -m '
    alias gp='git pull --no-commit '
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
    alias gl='git log --name-status '
    alias glb='git branch --list --remote'

    alias git-clean='git reset --hard HEAD && git clean -d -f'

    function gd() {
        git diff $* | less
    }
    function gdc() {
        gd --cached $*
    }
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

    if [ "" != "`declare -F | grep __git_complete`" ]; then
        git_aliases_autocomplete
    fi
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
        
        gpg --decrypt --recipient "$EMAIL" "$1" > $OUTPUT
        GPG_RESULT=$?

        if [ $GPG_RESULT -eq 0 ]; then
            if [ -n "$WIN" ]; then
                WINPATH=$(cygpath.exe -ad $OUTPUT)
                chmod +x $OUTPUT # derp windows derp
                cmd.exe /C start "$WINPATH"
            elif [ -n "$MAC" ]; then
                open "$OUTPUT"
            else
                echo "successfully decrypted file as [$OUTPUT]"
            fi
        else
            echo "ERROR: gpg --decrypt exited with status [$GPG_RESULT]. check stderr..." >&2
        fi
    }
}

function arch_aliases() {
    alias xfup='startxfce4'
    alias xfdown='xfce4-session-logout --logout'
    alias up='sudo pacman -Syu'
}

function cygwin_aliases() {
    alias explore='explorer.exe $(cygpath -ad `pwd`)'
}

alias re.='. ~/.bashrc'
utils_aliases
dev_aliases
git_aliases
sec_aliases

[ -n "$ARCH" ] && arch_aliases
[ -n "$WIN"  ] && cygwin_aliases

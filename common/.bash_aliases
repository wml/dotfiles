function utils_aliases() {
    LSOPTS="-lA"
    if [ -n "$ARCH" ]; then
        LSOPTS="$LSOPTS --color"
    elif [ -n "$MAC" ]; then
        LSOPTS="$LSOPTS -G"
    fi
    alias ls="ls $LSOPTS"
    alias lash='ls -lAsh '
    alias e='$EDITOR'
    alias cdd='cd ~/dotfiles'
    alias tf='tail -f'
    alias ldate="date '+%Y%m%d'"
    alias df='df -h'
    alias du='du -sh'

    function cdl {
        cd $* && ls
    }

    function ef {
        $EDITOR $(find . -name "$@" | head -n1)
    }
}

function dev_aliases() {
    alias pygrep="find . -name '*.py' -type f -print0 | xargs -0 grep "
    alias pygrepi="find . -name '*.py' -type f -print0 | xargs -0 grep -i "
    alias shgrep="find . -name '*.sh' -type f -print0 | xargs -0 grep "
    alias shgrepi="find . -name '*.sh' -type f -print0 | xargs -0 grep -i "
    alias cgrep="find . -name '*.cs' -type f -print0 | xargs -0 grep "
    alias cgrepi="find . -name '*.cs' -type f -print0 | xargs -0 grep -i "
    alias mgrep="find . -name '*.[mh]' -type f -print0 | xargs -0 grep "
    alias mgrepi="find . -name '*.[mh]' -type f -print0 | xargs -0 grep -i "

    function fgrep {
      find . -type f | sed 's/ /\\\\ /' \
        | grep -v '\.git' | grep -v '\.tmbundle' | grep -v 'target/' | grep -v bower_components | grep -v node_modules | grep -v 'build/' \
        | xargs file | grep -v ' architecture' | grep -v ELF | grep -v 'compiled' \
        | cut -d: -f1 | sed 's/ /\\\\ /' | xargs grep "$@"
    }
    
    alias fegrep="find . -type f | sed 's/ /\\\\ /' \
        | grep -v '\.git' | grep -v '\.tmbundle' | grep -v 'target/' | grep -v bower_components | grep -v node_modules | grep -v 'build/' \
        | xargs file | grep -v ' architecture' | grep -v ELF | grep -v 'compiled' \
        | cut -d: -f1 | sed 's/ /\\\\ /' | xargs egrep "

    alias fgrepi="find . -type f | sed 's/ /\\\\ /' \
        | grep -v '\.git' | grep -v '\.tmbundle' | grep -v 'target/' | grep -v bower_components | grep -v node_modules | grep -v 'build/' \
        | xargs file | grep -v ' architecture' | grep -v ELF | grep -v 'compiled' \
        | cut -d: -f1 | sed 's/ /\\\\ /' | xargs grep -i "

    function fen {
      $EDITOR $(fgrep "$@" | head -n 1 | cut -f1 -d':')      
    }
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
    alias gt='git stash'
    alias gtp='git stash pop'

    alias git-conflicts="gs | grep 'both modified'"
    alias git-has-conflicts='git-conflicts &>/dev/null'
    alias git-first-conflict='git-conflicts | head -n1 | cut -d: -f2'
    alias gen='git-has-conflicts && $EDITOR $(git-first-conflict)'
    alias grn='git-has-conflicts && ga $(git-first-conflict)'

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

    function git-block {
      gs | sed -n "/$1/,\$p" | grep -v "$1" | sed "/^[[:alnum:]]/q" | grep -ve "^[a-zA-Z0-9]"
    }
    
    alias git-staged-files='git-block "Changes to be committed"'
    alias git-unstaged-files='git-block "to discard changes"'
    alias git-unmerged-files='git-block "to mark resolution"'

    alias _git-changed-files='(git-staged-files ; git-unstaged-files ; git-unmerged-files) | grep -v "^$" | cut -d: -f2 | sed "s/^[[:space:]]*//g" | sort | uniq'
    alias gls='echo; _git-changed-files | awk "{printf \"  %d) %s\n\", NR, \$0}"; echo'

    function ge {
      if [[ "all" == "$1" ]]; then
        $EDITOR $(_git-changed-files)
      elif [ $# -eq 0 ] || ! [[ $1 =~ ^[1-9][0-9]*$ ]]; then
        echo; echo "  usage: ge <file-number> -or- \`all'"
        echo -e "$(gls)"
        echo
      else
        local FILE=1
        [ $1 -ge 1 ] && FILE=$1
        local TOEDIT=$(_git-changed-files | head -n $FILE | tail -n1)
        [[ "" != "$TOEDIT" ]] && $EDITOR $TOEDIT
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

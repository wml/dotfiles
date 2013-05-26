#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. $HOME/.bash_aliases
. $HOME/nuggets.sh
. $HOME/.localrc

$HOME/scripts/caps >/dev/null 2>&1
$HOME/scripts/enter >/dev/null 2>&1

export PATH="$HOME/scripts:$PATH"

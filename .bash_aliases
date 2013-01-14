alias ls='ls -lA --color=never'
alias e='emacs -nw'

alias xfup='startxfce4'
alias xfdown='xfce4-session-logout --logout'

xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keysym Caps_Lock = Control_L'
xmodmap -e 'add Control = Control_L'

#
# zshenv
#

#################################
# sudo
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/local,/usr}/sbin(N-/))

#################################
# pager
if type lv > /dev/null 2>&1; then
    export PAGER="lv"
    export LV="-c -l"
else
    export PAGER="less"
    alias lv="$PAGER"
fi

#################################
# grep

export GREPCMD

if type ag > /dev/null 2>&1; then
    GREPCMD='ag'
else
    GREPCMD='grep'
fi

#################################
# vim for editor
export EDITOR=vim
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
else
    alias vi=vim
fi

#################################
# peco
export PECOCMD
if type peco > /dev/null 2>&1; then
    PECOCMD='peco'
    alias -g P=" | $PECOCMD"
else
    PECOCMD=''
    alias -g P=" | $PAGER"
fi

#################################
# Locale
export LANG=ja_JP.UTF-8

#################################
# Path settings

# java
typeset -xT JAVA_HOME java_home
java_home=(
    /usr/java/default(N-/)
)

# golang
typeset -xT GO_ROOT go_root
go_root=(
    /usr/local/go(N-/)
    $HOME/local/go(N-/)
)

# path
typeset -U path
path=(
    /bin(N-/)
    $HOME/bin(N-/)
    $HOME/.rbenv/bin(N-/)
    $GO_ROOT/bin(N-/)
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    $path(N-/^W)
)

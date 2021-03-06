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
unset PAGER
export PAGER

if type -p lv > /dev/null 2>&1; then
    PAGER="lv"
    export LV="-c -l"
else
    PAGER="less"
fi

#################################
# grep
unset GREPCMD
export GREPCMD

if type -p ag > /dev/null 2>&1; then
    GREPCMD='ag'
else
    GREPCMD='grep'
fi

#################################
# vim for editor
if type -p nvim > /dev/null 2>&1; then
    EDITOR='nvim'
else
    EDITOR=vim
fi
export EDITOR

#################################
# Browser
unset BROWSER
if type vivaldi > /dev/null 2>&1; then
  export BROWSER=vivaldi
elif type google-chrome > /dev/null 2>&1; then
  export BROWSER=google-chrome
elif type firefox > /dev/null 2>&1; then
  export BROWSER=firefox
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

# path
typeset -U path
path=(
    /bin(N-/)
    $HOME/bin(N-/)
    $HOME/.rbenv/bin(N-/)
    $HOME/.yarn/bin(N-/)
    $HOME/projects/others/ghq/bin(N-/)
    /usr/local/go/bin(N-/)
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    $path(N-/^W)
)

ENHANCD_COMMAND=ecd; export ENHANCD_COMMAND


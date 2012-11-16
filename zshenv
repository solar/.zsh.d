#
# zshenv
#

#################################
# path
typeset -U path
path=(
    /bin(N-/)
    $HOME/bin(N-/)
    $HOME/.rbenv/bin(N-/)
    /usr/local/bin(N-/)
    /usr/bin(N-/)
)

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
# grep version
grep_version="$(grep --version | head -n 1 | sed -e 's/^[^0-9.]*\([0-9.]*\)$/\1/')"

# default option
export GREP_OPTIONS

# don't match binary
GREP_OPTIONS="--binary-files=without-match"
case "$grep_version" in
    1.*|2.[0-4].*|2.5.[0-3])
        ;;
    *)
        # grep 2.5.4~
        # recursive in directory
        GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
        ;;
esac

# ignore .tmp
GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"

# ignore scm dir
if grep --help | grep -q -- --exclude-dir; then
    GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.deps $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.libs $GREP_OPTIONS"
fi

# colored grep
if grep --help | grep -q -- --color; then
    GREP_OPTIONS="--color=auto $GREP_OPTIONS"
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
# Locale
export LANG=ja_JP.UTF-8

typeset -xT JAVA_HOME java_home
java_home=(/usr/java/default(N-/))

typeset -xT ANT_HOME ant_home
ant_home=(/usr/local/apache-ant/default(N-/))

typeset -xT BOOST_ROOT boost_root
boost_root=(/usr/local/boost/default(N-/))

#rbenv
if type rbenv > /dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

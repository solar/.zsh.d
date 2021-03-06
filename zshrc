#
# zshrc
#

# zplug
source ~/.zsh.d/rc/zplug.zsh

#################################
# Aliases

# Aliase file
alias_files=(
    $HOME/.zsh.d/zshalias(N-.)
    $HOME/.zshalias(N-.)
)
for alias_file in ${alias_files}; do
    source "${alias_file}"
    break
done

#################################
# Moving dirs
setopt auto_cd auto_pushd
cdpath=(~)
chpwd_functions=($chpwd_functions dirs)

#################################
# History
setopt inc_append_history share_history extended_history hist_ignore_dups
setopt hist_find_no_dups hist_ignore_space no_hist_beep
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

#################################
# Input
setopt correct list_packed noautoremoveslash nolistbeep
setopt magic_equal_subst extended_glob mark_dirs

#################################
# Historical forward/backward search.
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

#################################
# Other options
setopt no_flow_control no_beep long_list_jobs
setopt complete_aliases

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

umask 002

REPORTTIME=3

#################################
# Window title for screen/tmux
if [ "$TERM" = "screen" ]; then
    chpwd () { echo -n "_`dirs`\\" }
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
                if (( $#cmd == 1 )); then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*)
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;;
            *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
            cmd=(${(z)${(e):-\$jt$num}})
            echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    chpwd
fi

source ~/.zsh.d/zshrc_keybind

source ~/.zsh.d/rc/anyframe.zsh
source ~/.zsh.d/rc/enhancd.zsh

# direnv
if type direnv > /dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

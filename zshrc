#
# zshrc
#

#################################
# Aliases

# Aliase file
alais_files=(
    ~/.zsh.d/zshalias(N-.)
    ~/.zshalias(N-.)
)
for alias_file in ${alias_files}; do
    source "${alias_file}"
    break
done

#################################
# vim key bind
bindkey -v

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
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

#################################
# Other options
setopt no_flow_control no_beep long_list_jobs
setopt complete_aliases

umask 002

REPORTTIME=3

bindkey -a 'q' push-line

#################################
# Terminal
set terminal title including current directory

case "${TERM}" in
kterm*|xterm*|screen)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

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

source ~/.zsh.d/zshrc_prompt
source ~/.zsh.d/zshrc_completion

# direnv
if type direnv > /dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

. $HOME/.zsh.d/z.sh

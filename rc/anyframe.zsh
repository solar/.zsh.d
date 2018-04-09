zstyle ":anyframe:selector:" use fzf
zstyle ":anyframe:selector:fzf:" command 'fzf --extended'

bindkey '^kc' anyframe-widget-cdr
bindkey '^kh' anyframe-widget-put-history
bindkey '^kK' anyframe-widget-kill
bindkey '^kg' anyframe-widget-cd-ghq-repository

bindkey -M vicmd 'kc' anyframe-widget-cdr
bindkey -M vicmd 'kh' anyframe-widget-put-history
bindkey -M vicmd 'kK' anyframe-widget-kill
bindkey -M vicmd 'kg' anyframe-widget-cd-ghq-repository

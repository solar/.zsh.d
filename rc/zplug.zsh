source ~/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"

zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf

zplug "plugins/prompt", from:prezto
zplug "plugins/git", from:oh-my-zsh

zplug "b4b4r07/enhancd", use:init.sh
zplug "mollifier/anyframe"

# Can manage local plugins
zplug "~/.zsh", from:local

# # Load theme file
zplug 'dracula/zsh', as:theme

# # Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load --verbose

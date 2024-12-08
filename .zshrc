eval $(thefuck --alias)
. "/Users/eanyu/.deno/env"
if [ -f '/Users/eanyu/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/eanyu/google-cloud-sdk/path.zsh.inc'; fi

if [ -f '/Users/eanyu/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/eanyu/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(fzf --zsh)"

eval "$(oh-my-posh init zsh --config ~/marcduiker.omp.json)"

source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

ZSH_HIGHLIGHT_STYLES[command]='fg=#d7a201'
ZSH_HIGHLIGHT_STYLES[string]='fg=#2aa098'
ZSH_HIGHLIGHT_STYLES[error]='fg=#f8520e'
ZSH_HIGHLIGHT_STYLES[parameter]='fg=#c1c1c1'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#268ad1'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#859901'
ZSH_HIGHLIGHT_STYLES[keyword]='fg=#859901'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#f8520e'
ZSH_HIGHLIGHT_STYLES[path]='fg=#268ad1'
ZSH_HIGHLIGHT_STYLES[glob]='fg=#c1c1c1'

ZSH_HIGHLIGHT_STYLES[path]='fg=#c1c1c1,none'

PROMPT="${PROMPT}"$'\n'

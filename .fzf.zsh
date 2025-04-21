# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/andy/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/andy/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/andy/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/andy/.fzf/shell/key-bindings.zsh"

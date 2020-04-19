# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/rchampourlier/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/rchampourlier/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/rchampourlier/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/rchampourlier/.fzf/shell/key-bindings.zsh"

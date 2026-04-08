# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep
zstyle :compinstall filename '/home/neeoko/.zshrc'
autoload -Uz compinit
compinit
bindkey -e .


if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# Hyper-V GPU-PV Config
export LD_LIBRARY_PATH=/usr/lib/wsl/lib:$LD_LIBRARY_PATH
export PATH=$PATH:/usr/lib/wsl/lib
# export GALLIUM_DRIVER=d3d12
# export MESA_D3D12_DEFAULT_ADAPTER_NAME=NVIDIA
export LIBGL_ALWAYS_SOFTWARE=0

setopt autocd extendedglob

# These escape codes are standard for xterm/modern terminals
bindkey '^[[1;5D' backward-word       # Ctrl+Left
bindkey '^[[1;5C' forward-word        # Ctrl+Right
bindkey '^H'      backward-kill-word  # Ctrl+Backspace
bindkey '^[[3;5~' kill-word           # Ctrl+Delete

# 3. Fallbacks (for MacOS/iTerm2 or different term types)
# If the above don't work, these are common alternatives
bindkey '^[[5D' backward-word
bindkey '^[[5C' forward-word
bindkey '^W'    backward-kill-word    # Often standard Ctrl+W

# 4. Bonus: Shift+Tab to reverse cycle through autocomplete
bindkey '^[[Z' reverse-menu-complete

# 5. Bonus: Home/End keys
bindkey '^[[H' beginning-of-line      # Home
bindkey '^[[F' end-of-line            # End

export TERM="xterm-256color"

source ~/.zsh/fsh/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-z/zsh-z.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

eval "$(starship init zsh)"

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    # Attempt to attach to an existing session, or create a new one
    tmux attach || tmux new
fi

if [ -z "$SSH_AUTH_SOCK" ]; then
   export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock

   if [ ! -S "$SSH_AUTH_SOCK" ]; then
       eval $(ssh-agent -a $SSH_AUTH_SOCK) > /dev/null
   fi
fi

cd /home/neeoko/Work


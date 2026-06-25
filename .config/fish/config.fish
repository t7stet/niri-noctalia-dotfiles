# ============================================
# Fish Shell Configuration
# Clean, informative, no bloat
# ============================================

# ============================================
# PROMPT
# ============================================
# Simple but informative prompt with git status
function fish_prompt
    # Exit code
    set -l last_status $status
    set -l color_normal (set_color normal)
    
    # User and host (only if SSH or root)
    if test "$USER" = "root" -o -n "$SSH_CONNECTION"
        set -l user_host (set_color magenta)"$USER"@(set_color blue)(prompt_hostname)
    end
    
    # Current directory (shortened)
    set -l pwd (set_color cyan)(prompt_pwd)
    
    # Git status
    set -l git_info (fish_git_prompt 2>/dev/null)
    if test -n "$git_info"
        set git_info (set_color yellow)"$git_info"(set_color normal)
    end
    
    # Prompt symbol
    if test $last_status -eq 0
        set symbol (set_color green)"❯"
    else
        set symbol (set_color red)"✗"
    end
    
    # Build prompt
    echo -n -s "$user_host" "$pwd" "$git_info" " " "$symbol" " "
end

# ============================================
# GREETING
# ============================================
# Disable default greeting
set -g fish_greeting ""

# ============================================
# ALIASES
# ============================================
# Navigation
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'

# List files
alias ll 'ls -lah'
alias la 'ls -A'
alias l 'ls -CF'

# Package management
alias update 'sudo pacman -Syu'
alias install 'sudo pacman -S'
alias remove 'sudo pacman -Rns'
alias search 'pacman -Ss'
alias orphans 'pacman -Qtdq | sudo pacman -Rns -'
alias yayup 'yay -Syu'

# Git
alias gs 'git status'
alias ga 'git add'
alias gc 'git commit -m'
alias gp 'git push'
alias gl 'git pull'
alias gd 'git diff'
alias gco 'git checkout'
alias gb 'git branch'

# System
alias nv 'nvim'
alias cl 'clear'
alias h 'history'
alias e 'exit'
alias ports 'sudo netstat -tulpn | grep LISTEN'
alias disks 'df -h'
alias mem 'free -h'

# Kitty
alias kk 'kitty'

# ============================================
# ENV VARIABLES
# ============================================
set -gx EDITOR nano
set -gx VISUAL nvim
set -gx BROWSER firefox
set -gx PAGER less

# Add ~/.local/bin to PATH
fish_add_path ~/.local/bin

# ============================================
# KEY BINDINGS
# ============================================
# Ctrl+Backspace to delete word
bind \cH backward-kill-word

# Ctrl+Delete to delete forward word (might not work in all terminals)
bind \e\[3\;5~ kill-word

# ============================================
# MISC
# ============================================
# Don't auto-suggest from history (personal preference)
set -g fish_autosuggestion_enabled 1

# Enable vi mode (optional, uncomment if you want)
# fish_vi_key_bindings

# Load local config if exists
if test -f ~/.config/fish/config.local.fish
    source ~/.config/fish/config.local.fish
end

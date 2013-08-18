#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Zprezto
#

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#
# Completion libraries
#

if [[ -e $(which teamocil) ]]; then
  compctl -g '${HOME}/.teamocil/*(:t:r)' teamocil
fi

#
# Shell configuration
#

# Don't log commands beginning with a space
export HISTCONTROL=ignorespace
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTIGNORE="&:ls:l:ll:lll:pwd:exit:clear"

# Prevent Ctrl-D from exiting shell
set -o ignoreeof

# Notify when background jobs terminate
set -o notify

#
# Helper Functions
#

# Launch a static server in the current directory, passing an optional port
# number
server() {
  open "http://localhost:${1:-8000}" && $(which python) -m SimpleHTTPServer ${1:-8000}
}

# Keep a process running, restarting it if it crashes
always() {
  until $1; do
    echo "$1 died with exit code $?. Respawning..." >&2
    sleep 1
  done
}

#
# Aliases
#

alias l='ls -al'
alias ll='ls -l'
alias lll='ls -a'

# I always say more when I mean less
alias more='less'

# Make sure stuff piped through less retains color
alias less='less -R'

# If installed, prefer vim over vi
if [[ -x $(which vim) ]]; then
  alias vi='vim'
fi

# Easy vim mode
alias egvim='gvim -y'

# Shortcuts for fixing dumb repls that don't know about arrow keys
if [[ -x $(rlwrap) ]]; then
  alias clj='rlwrap clj'
  alias clojure='rlwrap clj'
  alias racket='rlwrap racket'
fi

# Always use 256-color tmux
alias tmux='tmux -2'

alias ga='git add'
alias gst='git status'
alias gc='git commit'
alias gco='git checkout'
alias gl='git pull'
alias glom='git pull origin master'
alias gp='git push'
alias gpom="git push origin master"
alias gd='git diff'
alias gb='git branch'
alias gba='git branch -a'
alias del='git branch -d'

#
# Key remaps
#
bindkey '\ew' kill-region                           # [Esc-w] - Kill from the cursor to the mark
bindkey '^k' kill-line                              # [Ctrl-k] - Kill from cursor to end of line
bindkey -s '\el' 'ls\n'                             # [Esc-l] - run command: ls
bindkey -s '\e.' '..\n'                             # [Esc-.] - run command: .. (up directory)
bindkey '^r' history-incremental-search-backward    # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey '^[[5~' up-line-or-history                  # [PageUp] - Up a line of history
bindkey '^[[6~' down-line-or-history                # [PageDown] - Down a line of history

bindkey '^[[A' up-line-or-search                    # start typing + [Up-Arrow] - fuzzy find history forward
bindkey '^[[B' down-line-or-search                  # start typing + [Down-Arrow] - fuzzy find history backward

bindkey '^[[H' beginning-of-line                    # [Home] - Go to beginning of line
bindkey '^[[1~' beginning-of-line                   # [Home] - Go to beginning of line
bindkey '^[OH' beginning-of-line                    # [Home] - Go to beginning of line
bindkey '^[[F'  end-of-line                         # [End] - Go to end of line
bindkey '^[[4~' end-of-line                         # [End] - Go to end of line
bindkey '^[OF' end-of-line                          # [End] - Go to end of line

bindkey ' ' magic-space                             # [Space] - do history expansion

bindkey '^f' forward-word                           # [Ctrl-F] - move forward one word
bindkey '^b' backward-word                          # [Ctrl-B] - move backward one word

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char                   # [Delete] - delete backward
bindkey '^[[3~' delete-char                         # [fn-Delete] - delete forward
bindkey '^[3;5~' delete-char
bindkey '\e[3~' delete-char

# Emacs-style bindings
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Set function path
fpath=(~/.zsh.d/functions $fpath)

autoload -Uz promptinit
promptinit
prompt teon

unsetopt beep
setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

#----------------------------------------------------------------------------
# Special key bindings
#----------------------------------------------------------------------------

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}" ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n "${key[End]}" ]] && bindkey "${key[End]}" end-of-line
[[ -n "${key[Insert]}" ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" up-line-or-history
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-history
[[ -n "${key[Left]}" ]] && bindkey "${key[Left]}" backward-char
[[ -n "${key[Right]}" ]] && bindkey "${key[Right]}" forward-char
[[ -n "${key[PageUp]}" ]] && \
  bindkey "${key[PageUp]}" beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]] && \
  bindkey "${key[PageDown]}" end-of-buffer-or-history
# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init () {
    echoti smkx
  }
  function zle-line-finish () {
      echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi
#----------------------------------------------------------------------------

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Colors for ls output
eval $(dircolors ~/.dircolors)

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lal='ls -al'
alias lla='ls -al'
alias grep='grep --color=auto'
alias g='gvim --remote-silent'
alias -s c=g
alias -s cpp=g
alias -s txt=g
alias -s py=g

# Fortune
if [[ -x /usr/bin/fortune ]] then
  if [[ -x /usr/bin/cowthink ]] then
    /usr/bin/cowthink $(/usr/bin/fortune)
  else
    /usr/bin/fortune
  fi
fi

# pkgfile hook for searching packages when command not found
if [[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# Term color
if [[ "$TERM" == "xterm" ]] then
  export TERM=xterm-256color
fi

# Arch specific, path form .zshenv gets overriden by /etc/profile
# so path needs to be set here
typeset -U path
path=(~/bin ~/.cabal/bin $path)

# Load site local settings
if [[ -f ~/.zsh_local ]] then
  source ~/.zsh_local
fi

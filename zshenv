# path gets overriden on Arch by /etc/profile
typeset -U path
path=(~/bin ~/.cabal/bin $path)

export EDITOR=vim

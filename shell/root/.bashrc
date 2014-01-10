#
# ~/.bashrc
#

# ls with colors
alias ls='ls --color=auto'

# Colors
DarkGrey="$(tput bold ; tput setaf 0)"
White="$(tput bold ; tput setaf 7)"
Red="$(tput bold; tput setaf 1)"
NC="$(tput sgr0)" # No Color

PS1="\[$DarkGrey\][ \[$Red\]blackarch \[$White\]\W\[$Red\] \[$DarkGrey\]]\\[$Red\]# \[$NC\]"

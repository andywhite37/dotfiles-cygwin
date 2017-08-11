#!/bin/tcsh -f

# Font Decorations
# 0 - normal
# 1 - bold
# 2 - normal again
# 3 - background color
# 4 - underline the text
# 5 - blinking

# Foreground/Background colors
# 30/40 - black
# 31/41 - brick red
# 32/42 - green
# 33/43 - yellow ochre
# 34/44 - dark blue
# 35/45 - magenta
# 36/46 - cyan
# 37/47 - white/gray

# Doesn't work in cygwin
set black =    '%{\033[30;1m%}'
set red =      '%{\033[31;1m%}'
set green =    '%{\033[32;1m%}'
set yellow =   '%{\033[33;1m%}'
set blue =     '%{\033[34;1m%}'
set magenta =  '%{\033[35;1m%}'
set cyan =     '%{\033[36;1m%}'
set white =    '%{\033[37;1m%}'
set nocolor =  '%{\033[0m%}'

#echo "gitlog"
#set gitlog = `sh -c '/usr/bin/git log -n 1 --decorate=short --format=%H%d |& grep -v "Not a git repo" | grep -v "Stopping at filesystem"'`
#echo "gitbranch"
#set gitbranch = `sh -c '/usr/bin/git branch --no-color' |& grep '^\*' | sed 's/^\* //' | sed 's/[\(\)]//g'`
set gitbranch = `git rev-parse --abbrev-ref HEAD |& grep -v "Not a git repo"`
#echo "gitdirty"
set gitdirty = `sh -c '/usr/bin/git status --short --porcelain |& grep -v "Not a git repo" | grep -v "Stopping at filesystem" | wc -l'`
#echo "git done"

#if ( "${gitlog}" == "" ) then
  #set gitlog = "not git"
  #endif

if ( "${gitbranch}" == "" ) then
    set gitbranch = "no branch"
endif

if ( $?gitdirty && "${gitdirty}" > 0) then
    set gitdirty = " (dirty)"
else
    set gitdirty = ""
endif

#echo "set prompt"
if ($?tcsh) then
    #set prompt="%B[${blue}%n@%M${nocolor}][${green}${gitlog}${nocolor}${red}${gitdirty}${nocolor}][${cyan}%~${nocolor}][${red}${gitbranch}${nocolor}][${yellow}%h${nocolor}][${blue}%?${nocolor}]>%b "
    set prompt="%B[${blue}%n@%M${nocolor}][${cyan}%~${nocolor}][${red}${gitbranch}${gitdirty}${nocolor}][${yellow}%h${nocolor}][${blue}%?${nocolor}]>%b "
else
    set prompt=\[`id -un`@`hostname`\]\$\ 
endif


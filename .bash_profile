#————————————————————————————————————————
# Summary
#————————————————————————————————————————
#{{{
# Hierarchy -
# Why - Expectation
# How - Effective
# What - Necessity to recored
#}}}
#-----------------------------------------
# Basic settings
#-----------------------------------------
#{{{
ulimit -S -c 0      # Don't want coredumps.
set -o ignoreeof
set prefer-visible-bell off
set autolist
set autocorrect = ambiguos
set complete = enhance
set correct = cmd
set autoexpand
set autorehash

export CLICOLOR=0
export LSCOLORS=GxFxCxDxBxegedabagaced

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.

# Disable options:
shopt -u mailwarn
unset MAILCHECK        # Don't want my shell to warn me of incoming mail.

#}}}
#--------------------------------------
#  Automatic setting of $DISPLAY
#--------------------------------------
#{{{
function get_xserver ()
{
   case $TERM in
       xterm )
           XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
           # Ane-Pieter Wieringa suggests the following alternative:
             I_AM=$(who am i)
             SERVER=${I_AM#*(}
             SERVER=${SERVER%*)}
           XSERVER=${XSERVER%%:*}
           ;;
           aterm | rxvt)
           # Find some code that works here. ...
           ;;
   esac
}

if [ -z ${DISPLAY:=""} ]; then
   get_xserver
   if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) ||
      ${XSERVER} == "unix" ]]; then
         DISPLAY=":0.0"          # Display on local host.
   else
      DISPLAY=${XSERVER}:0.0     # Display on remote host.
   fi
fi

export DISPLAY=:0.0


#}}}
#---------------------------------------
#  Change Prompt
#---------------------------------------
#{{{
PS1='$PWD> '    # set the prompt to display the current directory
echo "Loading ${HOME}/.bash_profile"
#}}}
#----------------------------------------
# Set Paths
#----------------------------------------
#{{{
export PATH="  ./\
	           :/sw/bin\
              :~/bin\
			   :/usr/local/bin\
              :/usr/local/\
			   :/usr/local/sbin\
			   :/usr/local/mysql/bin\
              :/usr/local/bin/\
			   :/usr/X11R6/bin\
              :/opt/local/bin\
			   :/opt/local/sbin\
			   :$PATH"
if [ -d ~/bin ]; then
 export PATH=:~/bin:$PATH
fi
source ~/.git-completion.bash
source ~/.git-prompt.sh
test -r /sw/bin/init.sh && . /sw/bin/init.sh

#}}}
#-----------------------------------------
# Aliases And Function
#----------------------------------------
#-------------------
# Personnal Aliases
#-------------------
#-{{{
 alias ccd="pwd | pbcopy"
 alias pcd="paste_cd"
function paste_cd() {
        cd "`pbpaste`"
}
	alias txt='ls -1 *.txt'
	alias md='ls -1 *.md'
	alias tex='ls -1 *.tex'
	alias pdf='ls -1 *.pdf'
	alias png='ls -1 *.png'
	alias p='cd /Users/hdshin/Dropbox/Hyundeok/2015'
	alias bs='vi ~/.bash_profile'
	alias vimrc='vi ~/.vim_runtime/vimrcs/basic.vim'
	alias vimrc1='vi ~/.vim_runtime/vimrcs/plugins_config.vim'
	alias 2015='vi /Users/hdshin/Dropbox/Hyundeok/2015/2015.md'
	alias 2014='vi /Users/hdshin/Dropbox/Hyundeok/2014/2014.md'
	alias 2013='vi /Users/hdshin/Dropbox/Hyundeok/2013/2013.md'
	alias so='source ~/.bash_profile'
	alias vi='mvim -v'
    alias ll='ls -al'
	alias l='ls -1 -a'
	alias la='ls -a | du -sh *'
	alias cp='cp -iv'                           # Preferred 'cp' implementation
	alias mv='mv -iv'                           # Preferred 'mv' implementation
	alias rm='rm -rfiv'                           # Preferred 'mv' implementation
    alias du='du -kh'                            # Makes a more readable output.
    alias df='df -kTh'
	alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
	alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
	alias less='less -FSRXc'                    # Preferred 'less' implementation
	cd() { builtin cd "$@"; ls; }               # Always list directory contents upon 'cd'
	alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
	alias ..='cd ../'                           # Go back 1 directory level
	alias ...='cd ../../'                       # Go back 2 directory levels
	alias .3='cd ../../../'                     # Go back 3 directory levels
	alias .4='cd ../../../../'                  # Go back 4 directory levels
	alias edit='subl'                           # edit:         Opens any file in sublime editor
	alias f='open -a Finder ./'                 # f:            Opens current directory in MacOSFinder
	alias ~="cd ~"                              # ~:            Go Home
	alias c='clear'                             # c:            Clear terminal display
	alias which='type -all'                     # which:        Find executables
	alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
    alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
	alias show_options='shopt'                  # Show_options: display bash options settings
	alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
	alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
	mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
	trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
	ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
	alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
#}}}
#-------------------
# git Aliases
#-------------------
#{{{
# Aliases
alias g='git'
alias gst='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdt='git diff -tree --no-commit-id --name-only -r'
alias gl='git pull'
alias gup='git pull --rebase'
alias gp='git push'
alias gd='git diff'
#gdv() { git diff -w "$@" | view - }
alias gdtl='git difftool'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcm='git checkout master'
alias gr='git remote'
alias grv='git remote -v'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias gb='git branch'
alias gba='git branch -a'
alias gbr='git branch --remote'
alias gcount='git shortlog -sn'
alias gcl='git config --list'
alias gcp='git cherry-pick'
alias glg='git log --stat --max-count=10'
alias glgg='git log --graph --max-count=10'
alias glgga='git log --graph --decorate --all'
alias glog='git log --oneline --decorate --color --graph'
alias gss='git status -s'
alias ga='git add'
alias gap='git add --patch'
alias gaa='git add --all'
alias gm='git merge'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gclean='git reset --hard && git clean -dfx'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

# Sign and verify commits with GPG
alias gcs='git commit -S'
alias gsps='git show --pretty=short --show-signature'

# Sign and verify tags with GPG
alias gts='git tag -s'
alias gvt='git verify-tag'

#remove the gf alias
#alias gf='git ls-files | grep'

alias gpoat='git push origin --all && git push origin --tags'
alias gmt='git mergetool --no-prompt'

alias gg='git gui citool'
alias gga='git gui citool --amend'
alias gk='gitk --all --branches'

alias gsts='git stash show --text'
alias gsta='git stash'
alias gstp='git stash pop'
alias gstd='git stash drop'

# Will cd into the top of the current repository
# or submodule.
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'

# Git and svn mix
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'

alias gsr='git svn rebase'
alias gsd='git svn dcommit'
#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
alias ggpur='git pull --rebase origin $(current_branch)'
alias ggpush='git push origin $(current_branch)'
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
alias glp="_git_log_prettily"

# Work In Progress (wip)
# These features allow to pause a branch development and switch to another one (wip)
# When you want to go back to work, just unwip it
#
# This function return a warning if the current branch is a wip
function work_in_progress() {
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    echo "WIP!!"
  fi
}
# these alias commit and uncomit wip branches
alias gwip='git add -A; git ls-files --deleted -z | xargs -r0 git rm; git commit -m "--wip--"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'

# these alias ignore changes to file
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
# list temporarily ignored files
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
#}}}
#-------------------------------------------------------------
# File & strings related functions:
#-----------------------------------------------------------
#{{{
# Find a file with a pattern in name:
function ff() { find . -path ./Library -prune -o -type f -iname '*'"$*"'*' ; }
function fd() { find . -path ./Library -prune -o -type d -iname '*'"$*"'*' ; }
#
# Find a file with pattern $* in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' \
                -exec ${2:-file} {} \;  ; }

#  Find a pattern in a set of files and highlight them:
#+ (needs a recent version of egrep).
function fstr()
{
   OPTIND=1
   local mycase=""
   local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
   while getopts :it opt
   do
       case "$opt" in
          i) mycase="-i " ;;
          *) echo "$usage"; return ;;
       esac
   done
   shift $(( $OPTIND - 1 ))
   if [ "$#" -lt 1 ]; then
       echo "$usage"
       return;
   fi
   find . -type f -name "${2:-*}" -print0 | \
xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more

}


function swap()
{ # Swap 2 filenames around, if they exist (from Uzi's bashrc).
   local TMPFILE=tmp.$$

   [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
   [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
   [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

   mv "$1" $TMPFILE
   mv "$2" "$1"
   mv $TMPFILE "$2"
}

function extract()      # Handy Extract Program
{
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1     ;;
           *.tar.gz)    tar xvzf $1     ;;
           *.bz2)       bunzip2 $1      ;;
           *.rar)       unrar x $1      ;;
           *.gz)        gunzip $1       ;;
           *.tar)       tar xvf $1      ;;
           *.tbz2)      tar xvjf $1     ;;
           *.tgz)       tar xvzf $1     ;;
           *.zip)       unzip $1        ;;
           *.Z)         uncompress $1   ;;
           *.7z)        7z x $1         ;;
           *)           echo "'$1' cannot be extracted via >extract<" ;;
       esac
#!/bin/bash   else
       echo "'$1' is not a valid file!"
   fi
}


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}
#}}}
#tets-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------
#{{{
function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }


function killps()   # kill by process name
{
   local pid pname sig="-TERM"   # default signal
   if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
       echo "Usage: killps [-SIGNAL] pattern"
       return;
   fi
   if [ $# = 2 ]; then sig=$1 ; fi
   for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} )
   do
       pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
       if ask "Kill process $pid <$pname> with signal $sig?"
           then kill $sig $pid
       fi
   done
}

function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
   for fs ; do

       if [ ! -d $fs ]
       then
         echo -e $fs" :No such file or directory" ; continue
       fi

       local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
       local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
       local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
       local out="["
       for ((j=0;j<20;j++)); do
           if [ ${j} -lt ${nbstars} ]; then
              out=$out"*"
           else
              out=$out"-"
           fi
       done
       out=${info[2]}" "$out"] ("$free" free on "$fs")"
       echo -e $out
   done
}


function my_ip() # Get IP adress on ethernet.
{
   MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
     sed -e s/addr://)
   echo ${MY_IP:-"Not connected"}
}

function ii()   # Get current host related info.
{
   echo -e "\nYou are logged on ${BRed}$HOST"
   echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
   echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
            cut -d " " -f1 | sort | uniq
   echo -e "\n${BRed}Current date :$NC " ; date
   echo -e "\n${BRed}Machine stats :$NC " ; uptime
   echo -e "\n${BRed}Memory stats :$NC " ; free
   echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
   echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
   echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
   echo
}
#}}}
# MacPorts Installer addition on 2015-03-16_at_02:57:17: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


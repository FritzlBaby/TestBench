#############################################################
#                                                           #
#  dot files: bash                                          # 
#                                                           # 
#  -FrB                                                     # 
#                                                           #
#                                                           #
#                                                           #
############################################################# 

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#### history opts
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=100000
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'
shopt -s histappend # append session history

#### aliases - tools
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

#### aliases - files
alias ls='ls --color=tty'                 
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              
alias la='ls -A'                              
alias l='ls -CF'                              
alias cd..="cd .."

#### aliases - git
alias gs='git status'
alias ga='git add'
alias gc='git commit'

#### git auto completes and bash prompts - Thomas Wheeler

#get branch name
function git_branch {
    export gitbranch=[$(git rev-parse --abbrev-ref HEAD 2>/dev/null)]
    if [ "$?" -ne 0 ]
      then gitbranch=
    fi
    if [[ "${gitbranch}" == "[]" ]]
      then gitbranch=
    fi
}
 
# set usercolor based on whether we are running with Admin privs
function user_color {
    id | grep "Admin" > /dev/null
    RETVAL=$?
    if [[ $RETVAL == 0 ]]; then
        usercolor="[0;35m";
    else
        usercolor="[0;32m";
    fi
}
 
# set TTYNAME
function ttyname() { export TTYNAME=$@; }
 
# Set prompt and window title
inputcolor='[0;37m'
cwdcolor='[0;34m'
gitcolor='[1;31m'
user_color
 
# Setup for window title
export TTYNAME=$$
function settitle() {
  p=$(pwd);
  let l=${#p}-25
  if [ "$l" -gt "0" ]; then
    p=..${p:${l}}
  fi
  t="$TTYNAME $p"
  echo -ne "\e]2;$t\a\e]1;$t\a";
}
 
PROMPT_COMMAND='settitle; git_branch; history -a;'
export PS1='\[\e${usercolor}\][\u]\[\e${gitcolor}\]${gitbranch}\[\e${cwdcolor}\][$PWD]\[\e${inputcolor}\] $ '


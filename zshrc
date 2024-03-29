export PATH="$PATH:/snap/bin"
export PATH="$PATH:$HOME/git/scripts"
export PATH="$PATH:$HOME/bin"

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ "SESSION_TYPE" = "remote/ssh" ]
then
	SESSION_TYPE=remote/ssh
	export SESSION_TYPE
fi

# Keep 1,000,000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

# colours in terminal programs 
if ls --color=auto > /dev/null 2>&1
then
  alias ls='ls --color=auto'
fi
alias grep='grep --color=auto --exclude=.git'
alias fgrep='fgrep --color=auto --exclude=.git'
alias egrep='egrep --color=auto --exclude=.git'
alias cp='cp -r'
# alias for grepping through command history
alias gh='cat ~/.zsh_history | grep'
#for getting out of deep directories quickly
alias l="ls -alhtr"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."
alias ..........="cd ../../../../../../../../.."
alias ...........="cd ../../../../../../../../../.."
alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias diskspace='setopt dotglob; du -shc ./* | sort -hr;unsetopt dotglob'

setopt histignorealldups

# Use vim keybings
bindkey -e
# partial command search with up arrow
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
# Emacs style binding Ctrl-X Ctrl-E for edit command in editor
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# tab the other way with shift-tab
bindkey '^[[Z' reverse-menu-complete

# Set up the prompt
NEWLINE=$'\n'
#white timestamp, set bold, blue background
PROMPT="%{%K{blue}%F{white}%B%}[%D{%f-%mT%H:%M:%S}]"
#green user
PROMPT=$PROMPT"%{%F{green}%}%n"
#white separator
PROMPT=$PROMPT"%{%F{white}%}@"
#green host
#PROMPT=$PROMPT"%{%F{green}%}%M"

if which md5sum > /dev/null
then
  #give each host a unique color
  host_fhash=`md5sum /etc/hostname | cut -c1-2`
  HOST_FHASH=`echo $host_fhash | awk '{ print toupper($0) }' `
  HOST_FNUM=`printf "%d" 0x$HOST_FHASH`

  host_bhash=`echo $host_fhash | md5sum | cut -c1-2`
  HOST_BHASH=`echo $host_bhash | awk '{ print toupper($0) }' `
  HOST_BNUM=`printf "%d" 0x$HOST_BHASH`

  HOST_FCOLOR=`expr $HOST_FNUM % 8`
  HOST_BCOLOR=`expr $HOST_BNUM % 8`
else
  HOST_FCOLOR=green
  HOST_BCOLOR=blue
fi

if [ -z "$TMUX_PREFIX" ]
then
  TMUX_PREFIX="C-b"
  if [[ "$HOST" == "blackbeans" || "$HOST" == "R910NSQ2" || "$HOST" == "R90XJLQ3" ]]
  then
    TMUX_PREFIX="C-q"
  elif [[ "$HOST" == "staticbeans" ]]
  then
    TMUX_PREFIX="C-b"
  elif [[ "$SESSION_TYPE" == "remote/ssh" ]]
  then
    TMUX_PREFIX="C-n"
  fi
  export TMUX_PREFIX
else
fi

if [[ "$HOST_FCOLOR" == "$HOST_BCOLOR" ]]
then
  HOST_BCOLOR=`expr $HOST_FCOLOR + 4`
  HOST_BCOLOR=`expr $HOST_BCOLOR % 8`
fi

PROMPT=$PROMPT"%{%F{$HOST_FCOLOR}%K{$HOST_BCOLOR}%}%M"

#white separator
PROMPT=$PROMPT"%{%F{white}%K{blue}%B%}:"
#green directory
PROMPT=$PROMPT"%{%F{green}%}%d"
#newline, remove colors
PROMPT=$PROMPT"%{%K{none}%F{none}%}${NEWLINE}%% "
#unbold
PROMPT=$PROMPT"%{%b%}"


zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
if which dircolors > /dev/null
then
  eval "$(dircolors -b)"
fi
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

# Use modern completion system
autoload -Uz compinit
compinit

if which "nvim" > /dev/null
then
  export EDITOR=`which nvim`
elif which "vim" > /dev/null
then
  export EDITOR=`which vim`
else
  export EDITOR=`which vi`
fi

vim () {
	echo -ne "\033]12;Orange1\007";
	$EDITOR -p "$@";
	echo -ne "\033]12;White\007";
}

bak () {
	bn=`basename $1`
	dn=`dirname $1`
	echo "moving $dn/$bn to $dn/.bak.$bn"
	mv $dn/$bn $dn/.bak.$bn
}

rec () {
	bn=`basename $1`
	dn=`dirname $1`
	echo "moving $dn/.bak.$bn to $dn/$bn"
	mv $dn/.bak.$bn $dn/$bn
}

cpdeep () {
	bn=`basename $1`
	dn=`dirname $1`
	newname=$2
	echo "copying $dn/$bn to $dn/$newname"
	cp $dn/$bn $dn/$newname
}

mvdeep () {
	bn=`basename $1`
	dn=`dirname $1`
	newname=$2
	echo "moving $dn/$bn to $dn/$newname"
	mv $dn/$bn $dn/$newname
}

setopt inc_append_history
export SHELL=/usr/bin/zsh
alias copy='rsync -aPhr --progress'
alias move='rsync -aPhr --remove-source-files'
alias gitresetrealhard='~/git/scripts/gitresetrealhard.sh'
alias dd='dd status=progress'
alias topub="/home/$USER/git/scripts/send_to_pub.sh"
alias svim='sudo -H vim -p'
alias cfind="find . -regex '.*\.c\|.*\.h\|.*\.S\|.*\.s'"
alias cgrep="cfind | xargs grep --color"
alias swpfind="find . -regex '.*\.sw.'"
#TMUX
# Check tmux exists on this machine
if which "tmux" > /dev/null
then
	tmux set status-bg $HOST_BCOLOR
	tmux set status-fg $HOST_FCOLOR
	tmux set prefix $TMUX_PREFIX
	#capture a pane
	alias cap="tmux capture-pane -pS - > $HOME/.tmux.history.\`date '+%Y-%m-%dT%H:%M:%S'\`"
	#edit a captured pane in vim
	alias ecap="HIST=$HOME/.tmux.history.\$DATE\`date '+%Y-%m-%dT%H:%M:%S'\` && tmux capture-pane -pS - > \$HIST && vim \$HIST"
	#save a pane when exiting
	alias capexit="tmux capture-pane -pS - > $HOME/.tmux.history.\`date '+%Y-%m-%dT%H:%M:%S'\`; exit"

	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ "SESSION_TYPE" = "remote/ssh" ]; then
		export SESSION_TYPE=remote/ssh
	fi

	if [ -z "$TMUX" ]
	then
			# If there are existing sessions, connect to the first one
			if tmux ls >/dev/null
			then
				echo "tmux sessions running:"
				tmux ls
			else
				# Otherwise start a new session
				tmux >/dev/null
				if [ "$SESSION_TYPE" = "remote/ssh" ]
				then
				  echo "in ssh session, setting up tmux for ssh"
				  tmux set prefix C-n
				  tmux set -g mouse off
				fi
			fi
	fi
fi

umask 0027
if [ -f $HOME/.messages ]
then
	cat $HOME/.messages
fi

if [ -f ~/.ssh_agent ]
then
	source ~/.ssh_agent >/dev/null
fi

if [ -z "$SSH_AUTH_SOCK" ]
then
  eval `ssh-agent -s` > /dev/null 2>&1
fi
if [ -e "~/.zshrc_local" ]
then
  source ~/.zshrc_local
fi

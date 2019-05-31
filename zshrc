export EDITOR='/usr/bin/vim'
export PATH="$PATH:/snap/bin"
export PATH="$PATH:$HOME/git/scripts"

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
alias ls='ls --color=auto'
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
alias apt="sudo apt"
alias diskspace='setopt dotglob; du -shc ./* | sort -hr;unsetopt dotglob'

setopt histignorealldups

# Use vim keybings
bindkey -e
# partial command search with up arrow
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward
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
PROMPT=$PROMPT"%{%F{green}%}%M"
#white separator
PROMPT=$PROMPT"%{%F{white}%B%}:"
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
eval "$(dircolors -b)"
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

vim () {
	echo -ne "\033]12;Orange1\007";
	/usr/bin/vim "-p" "$@";
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
					tmux set status-bg white
					tmux set status-fg black
					tmux set prefix C-n
				fi
			fi
	else
		if [ "$SESSION_TYPE" = "remote/ssh" ]
		then
			echo "in ssh session, setting up tmux for ssh"
			tmux set status-bg white
			tmux set status-fg black
			tmux set prefix C-n
		fi
	fi
fi

# Global git hooks
# git config --global core.hooksPath $HOME/git/scripts/githooks

# do not store commands that are wrong in history (disabled because it gets annoying)
#zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# ARM part
alias actbusy='while true; do make PLAT=fvp CROSS_COMPILE=$CC64 DEBUG=1 all && make realclean; done'
export ARMLMD_LICENSE_FILE=7010@euhpc-lic03.euhpc.arm.com:7010@euhpc-lic04.euhpc.arm.com:7010@euhpc-lic05.euhpc.arm.com:7010@euhpc-lic07.euhpc.arm.com
export LM_LICENSE_FILE=7010@cam-lic05.cambridge.arm.com:7010@cam-lic07.cambridge.arm.com:7010@cam-lic03.cambridge.arm.com:7010@cam-lic04.cambridge.arm.com
export PATH=$HOME/gnu-work/tools/bin:$PATH
export CC64=aarch64-linux-gnu-
export CC32=arm-linux-gnueabihf-
export CCEABI=arm-eabi-
export CCNONEEABI=arm-none-eabi
export CHECKPATCH=$HOME/bin/checkpatch/checkpatch.pl
umask 0027
alias ds5='/usr/local/DS-5_v5.28.1/bin/eclipse'
if [ -f $HOME/.messages ]
then
	cat $HOME/.messages
fi

export EDITOR='/usr/bin/vim'
export PATH="$PATH:/snap/bin"
export PATH="$PATH:$HOME/git/scripts"

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

setopt inc_append_history
export SHELL=/usr/bin/zsh
alias copy='rsync -aPhr --progress'
alias move='rsync -aPhr --remove-source-files'
alias gitresetrealhard='~/git/scripts/gitresetrealhard.sh'
alias dd='dd status=progress'
alias topub="/home/$USER/git/scripts/send_to_pub.sh"
alias svim='sudo -H vim -p'

#TMUX
# If you are running within a tmux session, do nothing
if [ -z "$TMUX" ]
then
	# Check tmux exists on this machine
	if which "tmux" > /dev/null
	then
		# If there are existing sessions, connect to the first one
		if tmux ls >/dev/null
		then
			tmux attach > /dev/null
		else
			# Otherwise start a new session
			tmux >/dev/null
		fi
	fi
else
	#capture a pane
	alias cap="tmux capture-pane -pS - > .tmux.history.\`date '+%Y-%m-%dT%H:%M:%S'\`"
	#edit a captured pane in vim
	alias ecap="HIST=.tmux.history.\$DATE\`date '+%Y-%m-%dT%H:%M:%S'\` && tmux capture-pane -pS - > \$HIST && vim \$HIST"
	#save a pane when exiting
	alias exit="tmux capture-pane -pS - > .tmux.history.\`date '+%Y-%m-%dT%H:%M:%S'\`; exit"
fi

# Global git hooks
# git config --global core.hooksPath $HOME/git/scripts/githooks

# do not store commands that are wrong in history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# ARM part
export ARMLMD_LICENSE_FILE=7010@euhpc-lic03.euhpc.arm.com:7010@euhpc-lic04.euhpc.arm.com:7010@euhpc-lic05.euhpc.arm.com:7010@euhpc-lic07.euhpc.arm.com
export LM_LICENSE_FILE=7010@cam-lic05.cambridge.arm.com:7010@cam-lic07.cambridge.arm.com:7010@cam-lic03.cambridge.arm.com:7010@cam-lic04.cambridge.arm.com
export PATH=$HOME/gnu-work/tools/bin:$PATH
export CC64=aarch64-linux-gnu-
export CC32=arm-linux-gnueabihf-
export CCEABI=arm-eabi-
export CCNONEEABI=arm-none-eabi
export CHECKPATCH=$HOME/bin/checkpatch/checkpatch.pl
export CROSS_COMPILE=$CROSS_COMPILE_64
umask 0027
alias ds5='/usr/local/DS-5_v5.28.1/bin/eclipse'


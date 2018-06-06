#!/bin/bash
dir="$( cd "$( dirname "$0" )" && pwd )"
for file in .vimrc .zshrc .tmux.conf
do
	if [ -e "$HOME/$file" ] || [ -L "$HOME/$file" ]
	then
		mv $HOME/$file $HOME/$file.bak
		echo "moving $HOME/.vimrc to $HOME/.vimrc.bak"
	fi
done
ln -sf $dir/vimrc $HOME/.vimrc
ln -sf $dir/zshrc $HOME/.zshrc
ln -sf $dir/tmux.conf $HOME/.tmux.conf
ls -al $HOME/.vimrc
ls -al $HOME/.zshrc
ls -al $HOME/.tmux.conf

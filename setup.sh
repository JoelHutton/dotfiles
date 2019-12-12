#!/bin/bash
dir="$( cd "$( dirname "$0" )" && pwd )"
for file in $HOME/.vimrc $HOME/.zshrc $HOME/.tmux.conf $HOME/.xbindkeysrc $HOME/.config/nvim/init.vim
do
	if [ -e "$file" ] || [ -L "$file" ]
	then
		mv $file $file.bak
		echo "moving $HOME/.$file to $HOME/.$file.bak"
	fi
done
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/nvim/bundle/
mkdir -p $HOME/.config/nvim/after

ln -sf $dir/init.vim $HOME/.config/nvim/init.vim
ln -sf $dir/nvim/after/syntax $HOME/.config/nvim/after/syntax/
ln -sf $dir/Vundle.vim $HOME/.config/nvim/bundle/Vundle.vim

sudo apt install -y build-essential cmake python3-dev
ln -sf $dir/YouCompleteMe $HOME/.config/nvim/bundle/YouCompleteMe
ORIG_DIR=$PWD
cd $HOME/.config/nvim/bundle/YouCompleteMe
python3 ./install.py --clang-completer
cd $ORIG_DIR

ln -sf $dir/vimrc $HOME/.vimrc
ln -sf $dir/zshrc $HOME/.zshrc
ln -sf $dir/tmux.conf $HOME/.tmux.conf
ln -sf $dir/xbindkeysrc $HOME/.xbindkeysrc
ls -al $HOME/.config/nvim/init.vim
ls -al $HOME/.vimrc
ls -al $HOME/.zshrc
ls -al $HOME/.tmux.conf

#!/bin/sh
ln -sf ~/dotfiles/.Rprofile ~/.Rprofile
ln -sf ~/dotfiles/.Renviron ~/.Renviron
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.slate ~/.slate
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -sf ~/dotfiles/.latexmkrc ~/.latexmkrc
# vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/dein.toml ~/.vim/dein.toml
ln -sf ~/dotfiles/dein_lazy.toml ~/.vim/dein_lazy.toml
# nvim
ln -snf ~/.vim ~/.config/nvim
ln -sf ~/dotfiles/.vimrc ~/.config/nvim/init.vim

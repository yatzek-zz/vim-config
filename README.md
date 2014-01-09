## About

My vim configuration. Very handy if you work on multiple machines.

## Installation

1. Clone the repo to your home foler:

	cd
	git clone git@github.com:yatzek/vim-config --recursive 


2. Symlink $HOME/vim-config/vimrc to $HOME/.vimrc and $HOME/vim-config/vim to $HOME/.vim

	ln -s $HOME/vim-config/vimrc $HOME/.vimrc
	ln -s $HOME/vim-config/vim $HOME/.vim

## Features

All extensions are included using Pathogen from the vim/bundle directory. 

Some of them are:

* TODO 
* Golang
* Solarized

## Tweaking

To add submodule:
	
	git submodule add <repo_url> vim/bundle/<plugin_folder>

To remove submodule:

	git submodule deinit <submodule>
	git rm <submodule>  

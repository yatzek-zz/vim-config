" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" *** GENERIC STUFF ***
" set tabs to 2 spaces
set ts=2 
" show line numbers
set nu 
" incremental search 
set incsearch
" *** GENERIC STUFF ***

" *** TMP FOLDER - SWAP AND BACKUP *** 
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.
" *** TMP FOLDER - SWAP AND BACKUP *** 

" *** POWERLINE ***
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256  colours)
set t_Co=256
" *** POWERLINE ***

" *** PATHOGEN ***
execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype plugin indent on
" *** PATHOGEN ***

" *** SOLARIZED COLOR SCHEME ***
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
" *** SOLARIZED COLOR SCHEME ***

" *** NERDTREE ***
" https://github.com/scrooloose/nerdtree
autocmd vimenter * NERDTree                                      " Open on startup 
autocmd BufEnter * lcd %:p:h                                     " set working dir to current file directory
" autocmd BufWinEnter * NERDTree
map <F3> :NERDTreeToggle<CR>
" NERDTreeTabs: https://github.com/jistr/vim-nerdtree-tabs
" One tree for all tabs to make it feel like a true panel
" map <F5> :NERDTreeTabsToggle<CR>
" let g:nerdtree_tabs_open_on_console_startup=1
" *** NERDTREE ***

" *** GOLANG ***
" load compiler definition for go
autocmd FileType go compiler go
" gofmt files on save
autocmd FileType go autocmd BufWritePre <buffer> Fmt
" *** GOLANG ***

" *** GOCODE ***
" Golang autocompletion
" Install gocode daemon: go get -u github.com/nsf/gocode 
" Set daemon options with: gocode set
" Install vim-gocode plugin: https://github.com/Blackrush/vim-gocode 
" Use c-x c-o for autocompletion, c-n, c-p for scrolling
" *** GOCODE ***

" *** SUPERTAB ***
" use <TAB> to trigger autocompletion instead of c-x c-o, see gocode plugin above
let g:SuperTabDefaultCompletionType = "context"
" *** SUPERTAB ***

" *** YANKSTACK ***
" \-p       to cycle backwards
" \-P       to cycle forwards
" TODO: not working really well
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
" *** YANKSTACK ***

" *** TAGBAR ***
nmap <F4> :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
" *** TAGBAR ***

" *** GOTAGS ***
" go get -u github.com/jstemmer/gotags
" see TAGBAR configuration above 
" *** GOTAGS ***

" *** GODEF ***
" go get -u code.google.com/p/rog-go/exp/cmd/godef
" Use gd in normal mode to go to definition
" open definition in new tab
let g:godef_split = 2
let g:godef_same_file_in_same_window = 1
" *** GODEF ***

" gocentric vim setup: http://0value.com/my-Go-centric-Vim-setup
" Other plugins: http://www.quora.com/Which-are-the-best-vim-plugins




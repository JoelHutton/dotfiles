" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
	syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" have Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
	filetype plugin indent on
endif


" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif

"DVORAK mappings
"quick escape mappings in insert, normal and visual modes, remap CAPS instead
"imap ht <Esc>
"nmap ht <Esc>
"vmap ht <Esc>
"cmap ht <Esc>

"make g + left|right (h or l) take you left or right a tab
nmap gh :tabp<Cr>
nmap gl :tabn<Cr>
nmap g<Left> :tabp<Cr>
nmap g<Right> :tabn<Cr>

"copy and paste to the system register
vmap sy "+y
vmap sp "+p
vmap sY "+Y
vmap sP "+P
nmap sy "+y
nmap sp "+p
nmap sY "+Y
nmap sP "+P

"turn off mouse and line numbering so it's easy to copy paste
nmap mo :set<Space>mouse=<Cr>:set<Space>nonu<Cr>:set<Space>paste<Cr>
nmap mO :set<Space>mouse=inv<Cr>:set<Space>nu<Cr>:set<Space>nopaste<Cr>

"in normal mode map ; to the command console
nmap ; :
"in command mode double tap ; to submit command
cmap ;; <Cr>
"in command mode double tap directional keys to navigate previous commands
cmap kk <Up>
cmap jj <Down>

nmap S <Nop>
nmap s <Nop>

nmap <C-i> ggVG=<C-o><C-o>

set number
set nowrap

set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " ignore case in regexes
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set mouse=inv       " Enable mouse usage in insert, normal, visual modes

"set tabs as 4 spaces
"filetype plugin indent on
"set tabstop=4
"set shiftwidth=4
"set expandtab
"set pastetoggle=<F3>

"show leading tabs, trailing spaces, eol
set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

"splits open to the right and bottom
set splitbelow
set splitright
"remap move down window
nnoremap  sj <C-W><C-J>
"remap move up window
nnoremap  sk <C-W><C-K>
"remap move right window
nnoremap  sl <C-W><C-L>
"remap move left window
nnoremap  sh <C-W><C-H>
"add this in to preserve buffer on quit, creates a delay on leaving
autocmd VimLeave * call system("echo -n $'" . escape(getreg(), "'") . "' | xsel -ib")

"highlight character 81 on long lines
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%80v.', -1)

"wrap git commit messages
au FileType gitcommit set tw=72
"set 4 spaces for tab in git commits
au FileType gitcommit set tabstop=4
au FileType gitcommit set shiftwidth=4
au FileType gitcommit set expandtab
"highlight character 81 on long lines
au FileType gitcommit au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%72v.', -1)

"for when you open a file without sudo by mistake
command W w !sudo tee % > /dev/null

"filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/plugin
set rtp+=~/.config/nvim/bundle/asm-explorer
set rtp+=~/.config/nvim/bundle/Vundle.vim
set rtp+=~/.config/nvim/bundle/vim-gcc-dev
call vundle#begin('~/.config/nvim/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on  " allows auto-indenting depending on file type

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


" have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
	filetype plugin indent on
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
"in command mode double tap directional keys to navigate previous commands
cmap kk <Up>
cmap jj <Down>

nmap S <Nop>
nmap s <Nop>

set number
set nowrap

set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " ignore case in regexes
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set bs=2            " Enable backspace over anything
set mouse=inv       " Enable mouse usage in insert, normal, visual modes

"set tabs as 4 spaces
"filetype plugin indent on
set tabstop=8
set shiftwidth=2
set noexpandtab
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

"wrap git commit messages
au FileType gitcommit set tw=72
"set 4 spaces for tab in git commits
au FileType gitcommit set tabstop=4
au FileType gitcommit set shiftwidth=4
au FileType gitcommit set expandtab
"highlight character 72 in git commits
au FileType gitcommit au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%72v.', -1)

"for when you open a file without sudo by mistake
"command W w !sudo tee % > /dev/null

"modifiedflag, charcount, filepercent, filepath
set statusline=%=%m\ %c\ %P\ %f

"The Leader
let mapleader="\<Space>"

"save current buffer
nnoremap <leader>w :w<cr>

"replace the word under cursor
nnoremap <leader>* :%s/<c-r><c-w>//g<left><left>

"move lines around
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==
xnoremap <leader>k :m-2<cr>gv=gv
xnoremap <leader>j :m'>+<cr>gv=gv

"quickly save-quit/save/quit
noremap <leader>x :x<Cr>
noremap <leader>w :w<Cr>
noremap <leader>q :q<Cr>
xnoremap <leader>x :x<Cr>
xnoremap <leader>w :w<Cr>
xnoremap <leader>q :q<Cr>
noremap <leader>f :set foldmethod=syntax<Cr>

"set filetype to lisp (useful for many gcc formats)
nnoremap <leader>l :set filetype=lisp<Cr>

"quick cpp style comment out line
au FileType c noremap <leader>c 0I//<Esc>
au FileType c xnoremap <leader>c 0I//<Esc>
au FileType cpp noremap <leader>c 0I//<Esc>
au FileType cpp xnoremap <leader>c 0I//<Esc>
au FileType cc noremap <leader>c 0I//<Esc>
au FileType cc xnoremap <leader>c 0I//<Esc>
au FileType sh noremap <leader>c 0I#<Esc>
au FileType sh xnoremap <leader>c 0I#<Esc>
au FileType gcc-rtl noremap <leader>c 0I;;<Esc>
au FileType gcc-rtl xnoremap <leader>c 0I;;<Esc>

" Create extra whitespace highlight group in red.
highlight ExtraWhitespace ctermbg=red guibg=red
" Match whitespace at end of line.
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" Match 5 spaces anywhere.
"autocmd BufWinEnter * match ExtraWhitespace /\ \{5,}/
"" Match space before tab anywhere.
"autocmd BufWinEnter * match ExtraWhitespace /\ \t/
"
"" Create no space before bracket highlight group in red.
""highlight NoSpace ctermbg=red guibg=red
"autocmd BufWinEnter * match ExtraWhitespace /[a-zA-Z0-9](/
"
"" Create full stop space space before end of comment highlight group in red.
""highlight BadComment ctermbg=red guibg=red
"autocmd BufWinEnter * match ExtraWhiteSpace /\(\.\ \ \)\@<!\(*\/\)/
"
""highlight character 81 onwards long lines
""highlight LongLine ctermbg=red guibg=red
"autocmd BufWinEnter * match ExtraWhiteSpace /\%>80v.\+/

"persistent undo
set undofile
set undodir=~/.config/nvim/undo-dir

"status tabline at top
set showtabline=2
"but no statusline at bottom
set laststatus=0

"quick go to definition
noremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<Cr>
noremap <leader>D :YcmCompleter GoToDefinition<Cr>

"quick quit
noremap <leader>q <Esc>:q<Cr>

"quick return
noremap <leader>o <C-o>

"cscope shortcuts
noremap <leader>] <C-]>

"exit terminal mode
tnoremap <Esc> <C-\><C-n>

"gdb commands
noremap <leader>s :Step<Cr>
noremap <leader>n :Over<Cr>
noremap <leader>c :Continue<Cr>
noremap <leader>b :Break<Cr>
noremap <leader>r :Run<Cr>
noremap <leader>e :Eval<Cr>
noremap <leader>t :vsplit term://zsh<Cr>:set nonu<Cr>i
noremap <leader>T :split term://zsh<Cr>:set nonu<Cr>i

function! SetStyle()
  let l:fname = expand("%:p")
  let l:ext = fnamemodify(l:fname, ":e")
  let l:c_exts = ['c', 'h', 'cpp', 'cc', 'C', 'H', 'def', 'java']
  if stridx(l:fname, 'libsanitizer') != -1
    return
  endif
  if l:ext != "py"
    setlocal tabstop=8
    setlocal softtabstop=2
    setlocal shiftwidth=2
    setlocal noexpandtab
  endif
  if &filetype == "gitcommit"
    setlocal textwidth=72
  else
    setlocal textwidth=80
  endif
  setlocal formatoptions-=ro formatoptions+=cqlt
  if index(l:c_exts, l:ext) != -1 || &filetype == "c" || &filetype == "cpp"
    setlocal cindent
    setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,f0,h2,p4,t0,+2,(0,u0,w1,m0
  endif
endfunction

call SetStyle()

" highlight gcc machine description files
if has("autocmd")
	autocmd BufRead *.md  set syntax=gcc-rtl
	autocmd BufRead *.md  set filetype=gcc-rtl
endif

" This must be first, because it changes other options
if &compatible
  set nocompatible
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'srcery-colors/srcery-vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'ray-x/go.nvim'
Plug 'tpope/vim-fugitive'
Plug 'vim-python/python-syntax', {'for': ['python'] }
Plug 'rosstimson/bats.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()

filetype indent on
syntax on

set spelllang=en_us
set encoding=utf-8
set shell=$SHELL               " Set the default shell
set history=1000               " The number of history items to remember
set ttyfast                    " Set that we have a fast terminal
set t_Co=256                   " Explicitly tell Vim that the terminal supports 256 colors
set lazyredraw                 " Don't redraw vim in all situations
set synmaxcol=500              " The max number of columns to try and highlight
set noerrorbells               " Don't make noise
set hlsearch                   " Highlight search terms
set incsearch                  " Show searches as you type
set autoread                   " Watch for file changes and auto update
set autowrite                  " Write the contents of the file, if it has been modified
set mouse=a                    " Enable using the mouse if terminal emulator
set linebreak                  " Don't wrap in the middle of words
set ignorecase                 " Ignore case when searching
set smartcase                  " Ignore case if search is lowercase, otherwise case-sensitive
set number                     " Shows line numbers
set nojoinspaces               " Don't add 2 spaces when using J
set autoindent                 " Copy indent from current line when starting a new line 
set laststatus=2               " The last window will always have a status line
set softtabstop=2              " Number of spaces that a <Tab> counts for while performing editing operations
set tabstop=2                  " Number of spaces that a <Tab> in the file counts for
set noswapfile                 " Do not use a swapfile for the buffer
set wildmenu                   " command-line completion operates in an enhanced mode
set shiftwidth=2               " Number of spaces to use for each step of (auto)indent
set expandtab                  " Use the appropriate number of spaces to insert a <Tab>
set smartindent                " Do smart autoindenting when starting a new line
set showmode                   " current mode not shown
set formatoptions+=j           " Remove comments when joining lines with J
set smarttab                   " no smart tab size
set showmatch                  " When a bracket is inserted, briefly jump to the matching one
set showcmd                    " Show (partial) command in the last line of the screen.
set cursorline                 " Highlight the screen line of the cursor with CursorLine
set ruler                      " Show the line and column number of the cursor position, separated by a comma
set hidden                     " When off a buffer is unloaded when it is abandoned
set list                       " Show tabs as CTRL-I is displayed
set path+=**                   " Make |:find| discover recursive paths
set backspace=indent,eol,start " Backspace settings
set pastetoggle=<F3>           " Toggle paste mode
set colorcolumn=80             " Show visual indicator for line length
set noshowmode                 " Do not show mode bar

set listchars=eol:¬
set listchars+=tab:->
set listchars+=trail:~
set listchars+=extends:>
set listchars+=precedes:<
set listchars+=space:•

set nobackup
set nowritebackup
set updatetime=500
set signcolumn=number
" Set mapping and key timeouts
set timeout
set timeoutlen=1000 
set ttimeoutlen=0
if !has('nvim')
  set balloondelay=250
  set ttymouse=sgr
endif

if has('clipboard')     " If the feature is available
  set clipboard=unnamed " copy to the system clipboard
  if has('unnamedplus')
    set clipboard+=unnamedplus
  endif
endif

" Create a directory if it doesn't exist yet
function! s:EnsureDirectory(directory)
  if !isdirectory(expand(a:directory))
    call mkdir(expand(a:directory), 'p')
  endif
endfunction

" Write undo tree to a file to resume from next time the file is opened
if has('persistent_undo')
  set undolevels=2000            " The number of undo items to remember
  set undofile                   " Save undo history to files locally
  set undodir=$HOME/.vimundo     " Set the directory of the undofile
  call s:EnsureDirectory(&undodir)
endif

colorscheme srcery
set background=dark

let mapleader = ","
let maplocalleader = "\\"

" Ignore these folders for completions
set wildignore+=.hg,.git,.svn                          " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg         " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc " compiled object files

let g:lightline = {
      \ 'colorscheme': 'srcery',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ }

" Fuck you, help key.
noremap <F1> <Nop>

" Force root permission saves
cnoremap w!! w !sudo tee % >/dev/null

command! -bang -nargs=* Rg call fzf#vim#grep(
      \ "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
      \ 1,
      \ {'options': '--delimiter : --nth 4..'}, <bang>0)

nmap \e :Files<CR>
nmap \g :GFiles<CR>
nmap \r :Rg<CR>

" Easy saving
map <leader>w :w!<cr>

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Resizing windows
nnoremap <silent> <leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <leader>0 :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader>9 :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Split
noremap <leader>h :<C-u>split<CR>
noremap <leader>g :<C-u>vsplit<CR>

noremap <leader>tt :<C-u>term<CR>
noremap <leader>vt :<C-u>vert term<CR>

nnoremap <leader>V :edit $MYVIMRC<CR>

map <leader>ss :setlocal spell!<cr>

au InsertLeave * silent! set nopaste
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile Jenkinsfile setf groovy
au BufNewFile,BufRead *.cue setf cue
autocmd FileType make setlocal noexpandtab
autocmd FileType yaml setlocal ai ts=2 sw=2 et
autocmd FileType groovy setlocal ts=4 sw=4
autocmd FileType cue setlocal sw=4 ts=4 noet si
autocmd FileType cs setlocal sw=4 ts=4 si
autocmd FileType sh setlocal sw=4 ts=4 noet si
autocmd FileType bats setlocal sw=4 ts=4 noet si

let g:dart_format_on_save = 1
let g:terraform_fmt_on_save=1

let g:python_highlight_all=1
let g:python3_host_prog='/usr/bin/python'

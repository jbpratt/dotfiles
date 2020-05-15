if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'cormacrelf/vim-colors-github'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
Plug 'govim/govim', { 'for': 'go' }
Plug 'prabirshrestha/asyncomplete.vim', { 'for': 'go' }
Plug 'yami-beta/asyncomplete-omni.vim', { 'for': 'go' }
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['python', 'bash', 'rust', 'cpp'] }
Plug 'KabbAmine/zeavim.vim'
call plug#end()

filetype indent on
syntax on

set ttymouse=sgr
set laststatus=2
set path+=**
set noswapfile
set wildmenu
set autowrite
set number
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set ignorecase
set smartcase
set smarttab
set mouse=a
set showmode
set showmatch
set showcmd
set cursorline
set ruler
set hlsearch
set hidden
set listchars=eol:¬,tab:->,trail:~,extends:>,precedes:<,space:•
set list
set updatetime=500
set backspace=2
set timeoutlen=1000 ttimeoutlen=0
colorscheme github

let mapleader = ","
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'github',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

nmap \e :Files<CR>
nmap \r :Rg<CR>

map <leader>w :w!<cr>
inoremap jj <esc>

"" Zeal
nmap <leader>z <Plug>Zeavim
vmap <leader>z <Plug>ZVVisSelection
nmap gz <Plug>ZVOperator
nmap <leader><leader>z <Plug>ZVKeyDocset

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Resizing windows
nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>0 :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>9 :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>g :<C-u>vsplit<CR>

noremap <Leader>tt :<C-u>term<CR>
noremap <Leader>vt :<C-u>vert term<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>

nnoremap <Leader>html :-1read $HOME/.vim/.skeleton.html<CR>

nnoremap <Leader>V :edit $MYVIMRC<CR>

" Open files in horizontal split
nnoremap <silent> <Leader>zz :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>

" Open files in vertical horizontal split
nnoremap <silent> <Leader>ZZ :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>

" NERD TREE
let NERDTreeIgnore=['\~$', '.o$', 'bower_components', 'node_modules', '__pycache__']
let NERDTreeWinSize=20
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=0
let NERDTreeKeepTreeInNewTab=1

map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <C-n> :NERDTreeToggle<CR>
map <leader>ss :setlocal spell!<cr>

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" 
" Jump to anywhere
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Rust config
let g:rustfmt_autosave = 1

" sh fmt
let g:shfmt_fmt_on_save = 1

nmap <silent> <leader>u <Plug>(coc-references)
nmap <silent> <leader>p :call CocActionAsync('format')<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

augroup go
  function! Omni()
    call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
                        \ 'name': 'omni',
                        \ 'whitelist': ['go'],
                        \ 'completor': function('asyncomplete#sources#omni#completor')
                        \  }))
  endfunction

  au VimEnter *.go :call Omni()

  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

  command! Cnext try | cbelow | catch | cabove 9999 | catch | endtry
  nnoremap <leader>m :Cnext<CR>
augroup END

set pastetoggle=<F3>
au InsertLeave * silent! set nopaste

command! -bang ProjectFiles call fzf#vim#files('~/projects', <bang>0)
au BufRead,BufNewFile *.md setlocal textwidth=80

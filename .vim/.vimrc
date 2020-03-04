if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'scrooloose/nerdtree'
Plug '~/.fzf'
Plug 'fatih/vim-go'
Plug 'cormacrelf/vim-colors-github'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'elmcast/elm-vim'
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'udalov/kotlin-vim'
Plug 'neovimhaskell/haskell-vim'
call plug#end()

filetype plugin indent on
syntax on

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
colorscheme github

let g:lightline = { 'colorscheme': 'github' }
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

map <leader>w :w!<cr>
inoremap jj <esc>

"" Closing bracket completion
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

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
nnoremap <silent> <Leader>z :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>

" Open files in vertical horizontal split
nnoremap <silent> <Leader>Z :call fzf#run({
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

function! s:build_kotlin_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+\.kt$'
    return ""
  endif
endfunction

au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl
au FileType go nmap <leader>taj :GoAddTags json<cr>
au FileType go nmap <leader>tat :GoAddTags toml<cr>
au FileType go nmap <leader>tab :GoAddTags bson<cr>:GoAddTags bson,omitempty<cr>
au FileType go nmap <leader>tad :GoAddTags db<cr>
au FileType go nmap <leader>trj :GoRemoveTags json<cr>
au FileType go nmap <leader>trb :GoRemoveTags bson<cr>
au FileType go nmap <leader>trd :GoRemoveTags db<cr>
au FileType go nmap <leader>tr :GoRemoveTags<cr>
au filetype go inoremap <buffer> kk .<C-x><C-o>

augroup go
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" let g:go_metalinter_command='golangci-lint'
" let g:go_metalinter_autosave = 1
let g:go_metalinter_enabled = ['deadcode', 'errcheck', 'gosimple', 'govet', 'staticcheck', 'typecheck', 'unused', 'varcheck']
let g:go_def_mode='gopls'
let g:go_info_mode = 'gopls'
let g:go_list_type = "quickfix"
let g:go_fmt_command = "gofumports"
let g:go_fmt_fail_silently = 1
let g:syntastic_go_checkers = ['golangci-lint', 'govet']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_auto_type_info = 1 
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1

"
autocmd FileType c ClangFormatAutoEnable

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

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

let g:syntastic_python_checkers=['mypy']

if executable(expand('~/lsp/kotlin-language-server/server/bin/kotlin-language-server'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'kotlin-language-server',
        \ 'cmd': {server_info->[
        \     &shell,
        \     &shellcmdflag,
        \     expand('~/lsp/kotlin-language-server/server/bin/kotlin-language-server')
        \ ]},
        \ 'whitelist': ['kotlin']
        \ })
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:elm_syntastic_show_warnings = 1

let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2

" Open stack repl
au Filetype hs nmap <Leader>gt :<C-u>ter ++close stack repl<CR>

au Filetype kt nmap <leader>b :<C-u>ter ++close kotlinc %t<CR>
au Filetype kt nmap <Leader>t :<C-u>ter ++close kotlinc-jvm<CR>
set ttymouse=sgr

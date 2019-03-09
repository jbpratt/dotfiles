"call plug#begin()
"Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
"call plug#end()
execute pathogen#infect()
syntax on
filetype plugin indent on
set path+=**
set tabstop=2 shiftwidth=2 softtabstop=2
set autowrite
set number
let mapleader = ","
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

let NERDTreeIgnore=['\~$', '.o$', 'bower_components', 'node_modules', '__pycache__']
let NERDTreeWinSize=20

let g:netrw_banner=0        " disable banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view

nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>

nnoremap ,v :source $MYVIMRC<CR>
nnoremap ,e :edit $MYVIMRC<CR>

map <C-n> :NERDTreeToggle<CR>

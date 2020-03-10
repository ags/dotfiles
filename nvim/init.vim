autocmd! BufWritePost init.vim source %

call plug#begin('~/.local/share/nvim/plugged')

Plug '/usr/local/opt/fzf'

Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'

Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'lambdatoast/elm.vim', { 'for': 'elm' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'chr4/nginx.vim', { 'for': 'nginx' }

Plug 'arcticicestudio/nord-vim'

call plug#end()

set relativenumber

set background=dark
colorscheme nord

"set shortmess=IF
set inccommand=split

let mapleader = ";"

" tab navigation
nnoremap tj :tabprev<CR>
nnoremap ti :tabnext<CR>
nnoremap tk :tabnext<CR>
nnoremap tn :tabnew<CR>

nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>

" Ctrl+D deletes buffer
noremap <C-D> :bd<CR>

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

" ctrl+c to escape in insert mode
inoremap <c-c> <esc>

inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Treat @foo as a single word (useful for tab completion).
autocmd FileType ruby setlocal iskeyword+=@-@

" Enable spell checking in commit messages.
autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell

" Treat j2 nginx templates as nginx
autocmd BufRead,BufNewFile nginx.conf.j2 set ft=nginx
autocmd BufRead,BufNewFile */nginx/templates/*.conf.j2 set ft=nginx

" run goimports when saving go files
let g:go_fmt_command = "goimports"

let g:go_def_mode = 'gopls'

" ale config
let g:ale_go_gometalinter_options = "--disable-all
\ --enable=golint
\ --enable=vet
\ --enable=errcheck
\ --exclude 'should have comment or'
\"

let g:ale_linters = {'go': ['gometalinter']}

" Indentation; 2 space default
set smartindent
set autoindent
set expandtab
set tabstop=2
set softtabstop=0
set shiftwidth=0

" Ctrl+L turns off any highlighted matches
noremap <C-l> :nohlsearch<CR>

" Split to right side
set splitright

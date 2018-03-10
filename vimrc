" Disable vi compatibility
set nocompatible
filetype off

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'easysid/mod8.vim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'

Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'lambdatoast/elm.vim', { 'for': 'elm' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

call plug#end()

" File type detection and language dependent indenting.
filetype plugin indent on

" Indentation; 2 space default
set smartindent
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Line numbers are relative to the cursor line.
set relativenumber

" Show line and column number of the cursor.
set ruler

" Ignore case in patterns, unless the pattern contains upper case characters.
set ignorecase smartcase

" Disable modelines; not used, risk of security exploits.
set modelines=0

" Use visual bell instead of beeping
set visualbell

" Terminals are plenty fast these days.
set ttyfast

" Mapping and escape timeouts.
set timeout
set timeoutlen=1000 " mapped sequences
set ttimeoutlen=10  " escape sequence delay

" Highlight search matches.
set hlsearch

" Navigatable tab completion from Vim command line
set wildmenu
set wildmode=list:longest

" Split to right side
set splitright

" Allow backspacing over indents and start of insertion point.
set backspace=indent,start

" Store backup files in ~/.vim/sessions.
set backupdir=~/.vim/sessions
set backupcopy=yes
set dir=~/.vim/sessions

" Minimum number of lines to keep above/below cursor when scolling
set scrolloff=5

" Color scheme
set t_Co=256
set background=dark
colors mod8
syntax on

" Highlight trailing whitespace etc
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Leader of '\' is too far from home row.
let mapleader = ";"
let g:mapleader = ";"

" run goimports when saving go files
let g:go_fmt_command = "goimports"

" ale config
let g:ale_go_gometalinter_options = "--disable-all
\ --enable=golint
\ --enable=vet
\ --enable=errcheck
\ --exclude 'should have comment or'
\"

let g:ale_linters = {'go': ['gometalinter']}

" Reload .vimrc after save.
autocmd! BufWritePost .vimrc source %

augroup filetype_settings
  autocmd!
  autocmd BufRead,BufNewFile *.jbuilder,*.prawn setlocal filetype=ruby
  autocmd BufRead,BufNewFile *.hbs setlocal filetype=html
augroup END

" Treat @foo as a single word (useful for tab completion).
autocmd FileType ruby setlocal iskeyword+=@-@

" Enable spell checking in commit messages.
autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell

" convert 'a = 1' to 'let(:a) { 1 }'
nnoremap <leader>p :PromoteToLet<cr>

" insert a tab or try to complete word
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" ctrl+c to escape in insert mode
inoremap <c-c> <esc>

" Strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" tab navigation
nnoremap tj :tabprev<CR>
nnoremap ti :tabnext<CR>
nnoremap tk :tabnext<CR>
nnoremap tn :tabnew<CR>

" Ctrl+L turns off any highlighted matches
noremap <C-l> :nohlsearch<CR>
"
" Ctrl+D deletes buffer
noremap <C-D> :bd<CR>

nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>

nnoremap <leader>gi :GoImports<cr>

" Ctrl+D deletes current buffer.
nnoremap <C-d> :bdelete<CR>

" Convert to ruby 1.9 hash style
nnoremap <leader>9 xea:<esc>wdw

nnoremap <leader>T :call SetTestFileToCurrentFile()<CR>
nnoremap <leader>t :w\|:call SendCurrentTestToPipe()<CR>
nnoremap <leader>r :w\|:call ModalRunCurrentTest()<CR>

" Functions

function! PromoteToLet()
  normal! dd
  " :exec '?^\s*it\>'
  normal! P
  .s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  normal ==
endfunction
command! PromoteToLet :call PromoteToLet()

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

" async test running

function! SetTestFileToCurrentFile()
  let g:CurrentTestFile = @%
endfunction

function! GetCurrentTestFile()
  return g:CurrentTestFile
endfunction

function! GetTestRunner()
  return "bundle exec rspec -f d"
endfunction

function! GetCurrentTestCommand()
  return "" . GetTestRunner() . " " . GetCurrentTestFile()
endfunction

function! SendCurrentTestToPipe()
  let pipeName = ".test-commands"
  call system("echo " . GetCurrentTestCommand() .  " > " . pipeName)
endfunction

function! ModalRunCurrentTest()
  exec "!" . GetCurrentTestCommand()
endfunction

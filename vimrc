" Disable vi compatibility
set nocompatible

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'ags/tslime.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'jnwhiteh/vim-golang'
Bundle 'scrooloose/syntastic'
Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wlangstroth/vim-haskell'

" load indent file for the current filetype
filetype indent on
filetype plugin on

" Indentation; 2 space default
set smartindent
set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Show line numbers
set relativenumber

" Show line and column number
set ruler

" Color scheme
set t_Co=256
colors lucius
syntax on

" Highlight trailing whitespace etc
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Ignore case
set ignorecase
set smartcase

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

" highlight search matches
set hlsearch

" Leader of '\' is too far from home row.
let mapleader = ";"
let g:mapleader = ";"

" Mouse for scrolling etc in console.
set mouse=a

" Resize split panes with mouse within tmux.
" Also get live-updated text selection with mouse drag.
set ttymouse=xterm2

" Navigatable tab completion from Vim command line
set wildmenu
set wildmode=list:longest

" Split to right side
set splitright

" Allow backspacing over indents and start of insertion point.
set backspace=indent,start

" Custom file-to-syntax highlighting schemes
augroup filetype_settings
  autocmd!
  autocmd BufRead,BufNewFile *.jbuilder,*.prawn setlocal filetype=ruby
  autocmd BufRead,BufNewFile *.hbs setlocal filetype=html
augroup END

" Keywords
" @foo in ruby
au BufNewFile,BufRead *.rb setlocal iskeyword+=@-@
" #foo in scss
au BufNewFile,BufRead *.scss setlocal iskeyword+=#-#

" Strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" tab navigation
nmap tj :tabprev<CR>
nmap ti :tabnext<CR>
nmap tk :tabnext<CR>
nmap tn :tabnew<CR>

" Quick-edit .vimrc
nnoremap <leader>ev :tabnew<CR>:e $MYVIMRC<cr>

" Enter turns off any highlighted matches, then acts as normal
nnoremap <CR> :noh<CR><CR>

" auto-reload .vimrc after save.
autocmd! BufWritePost .vimrc source %

" move backup files to ~/.vim/sessions
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions

" Minimum number of lines to keep above/below cursor when scolling
set scrolloff=5

" ctrlp.vim
let g:ctrlp_max_height = 16
let g:ctrlp_custom_ignore = ''
let g:ctrlp_custom_ignore .= '/\..*/\|'
let g:ctrlp_custom_ignore .= '/tmp/\|'
let g:ctrlp_custom_ignore .= '/node_modules/\|'
let g:ctrlp_custom_ignore .= '/vendor/\|'
let g:ctrlp_custom_ignore .= '/dist/\|'
let g:ctrlp_custom_ignore .= '/app/bower_components/\|'
let g:ctrlp_custom_ignore .= 'REGEX_TERMINATOR'
nnoremap <leader>gs :CtrlP spec/<cr>
nnoremap <leader>gm :CtrlP app/models/<cr>
nnoremap <leader>gv :CtrlP app/views/<cr>
nnoremap <leader>gc :CtrlP app/controllers/<cr>
nnoremap <leader>ga :CtrlP app/assets/<cr>
nnoremap <leader>gl :CtrlP lib/<cr>
nnoremap <C-b> :CtrlPBuffer<CR>

" Split windows
nnoremap <leader>v <C-w>v
nnoremap <leader>s <C-w>s

" Convert to ruby 1.9 hash style
nnoremap <leader>9 xea:<esc>wdw

" ctrl+c to escape
imap <c-c> <esc>

" selective spell checking
if has('spell')
  " commit messages
  autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
endif

function! PromoteToLet()
  normal! dd
  " :exec '?^\s*it\>'
  normal! P
  .s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  normal ==
endfunction
command! PromoteToLet :call PromoteToLet()
map <leader>p :PromoteToLet<cr>

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" set a file to run with rspec
nnoremap <leader>T :let g:spec_file = @%<CR>
" run the set spec file
nnoremap <leader>t :w\|:call Send_to_Tmux("clear && bundle exec rspec -f d " . g:spec_file . " \n")<CR>

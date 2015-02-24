" Disable vi compatibility
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'

call vundle#end()

if filereadable(expand("~/.vim/functions.vim"))
  source ~/.vim/functions.vim
endif

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
set dir=~/.vim/sessions

" Minimum number of lines to keep above/below cursor when scolling
set scrolloff=5

" Color scheme
set t_Co=256
colors Tomorrow-Night
syntax on

" Highlight trailing whitespace etc
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Leader of '\' is too far from home row.
let mapleader = ";"
let g:mapleader = ";"

" ctrlp config
let g:ctrlp_max_height = 16
let g:ctrlp_custom_ignore = ''
let g:ctrlp_custom_ignore .= '/\..*/\|'
let g:ctrlp_custom_ignore .= '/tmp/\|'
let g:ctrlp_custom_ignore .= '/project/\|'
let g:ctrlp_custom_ignore .= '/target/\|'
let g:ctrlp_custom_ignore .= '/node_modules/\|'
let g:ctrlp_custom_ignore .= '/plugins/\|'
let g:ctrlp_custom_ignore .= 'REGEX_TERMINATOR'

" Reload .vimrc after save.
autocmd! BufWritePost .vimrc source %

augroup filetype_settings
  autocmd!
  autocmd BufRead,BufNewFile *.jbuilder,*.prawn setlocal filetype=ruby
  autocmd BufRead,BufNewFile *.hbs setlocal filetype=html
augroup END

augroup tab_settings
  autocmd!
  autocmd FileType php setlocal shiftwidth=2 tabstop=2 noexpandtab
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

" Quick-edit .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Ctrl+L turns off any highlighted matches
noremap <C-l> :nohlsearch<CR>

nnoremap <leader>gs :CtrlP spec/<cr>
nnoremap <leader>gm :CtrlP app/models/<cr>
nnoremap <leader>gv :CtrlP app/views/<cr>
nnoremap <leader>gc :CtrlP app/controllers/<cr>
nnoremap <leader>ga :CtrlP app/assets/<cr>
nnoremap <leader>gl :CtrlP lib/<cr>
nnoremap <C-b> :CtrlPBuffer<CR>

" Convert to ruby 1.9 hash style
nnoremap <leader>9 xea:<esc>wdw

nnoremap <leader>T :call SetTestFileToCurrentFile()<CR>
nnoremap <leader>t :w\|:call SendCurrentTestToPipe()<CR>
nnoremap <leader>r :w\|:call ModalRunCurrentTest()<CR>

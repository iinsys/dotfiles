" DevOps Vim Configuration
" Practical settings for DevOps work

" =============================================================================
" BASIC SETTINGS
" =============================================================================

" Enable line numbers
set number
set relativenumber

" Enable syntax highlighting
syntax on

" Set colorscheme (use default if available)
colorscheme default

" Enable file type detection
filetype on
filetype plugin on
filetype indent on

" Set tab settings
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Enable auto-indentation
set autoindent
set smartindent

" Enable line wrapping
set wrap
set linebreak

" Enable search highlighting
set hlsearch
set incsearch
set ignorecase
set smartcase

" Enable mouse support
set mouse=a

" Enable clipboard support
set clipboard=unnamedplus

" Set backup and swap file locations
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Enable persistent undo
set undofile

" Set status line
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" =============================================================================
" KEY MAPPINGS
" =============================================================================

" Set leader key
let mapleader = ","

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Quick navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Clear search highlighting
nnoremap <leader>c :nohlsearch<CR>

" Toggle line numbers
nnoremap <leader>n :set number!<CR>

" Toggle paste mode
nnoremap <leader>p :set paste!<CR>

" Quick file operations
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>s :split <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

" =============================================================================
" DEVOPS-SPECIFIC SETTINGS
" =============================================================================

" YAML files
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType yml setlocal tabstop=2 shiftwidth=2 expandtab

" JSON files
autocmd FileType json setlocal tabstop=2 shiftwidth=2 expandtab

" Dockerfile
autocmd FileType dockerfile setlocal tabstop=2 shiftwidth=2 expandtab

" Terraform files
autocmd FileType terraform setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType tf setlocal tabstop=2 shiftwidth=2 expandtab

" Shell scripts
autocmd FileType sh setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType bash setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType zsh setlocal tabstop=2 shiftwidth=2 expandtab

" Python files
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab

" Go files
autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab

" =============================================================================
" PLUGINS (Optional - requires plugin manager)
" =============================================================================

" Uncomment if you have vim-plug installed
" call plug#begin('~/.vim/plugged')
" 
" " Git integration
" Plug 'tpope/vim-fugitive'
" 
" " File explorer
" Plug 'scrooloose/nerdtree'
" 
" " Syntax checking
" Plug 'vim-syntastic/syntastic'
" 
" " Auto-completion
" Plug 'valloric/youcompleteme'
" 
" " Docker support
" Plug 'ekalinin/dockerfile.vim'
" 
" " Terraform support
" Plug 'hashivim/vim-terraform'
" 
" " Kubernetes support
" Plug 'andrewstuart/vim-kubernetes'
" 
" call plug#end()

" =============================================================================
" CUSTOM FUNCTIONS
" =============================================================================

" Function to toggle between tabs and spaces
function! ToggleTabSpaces()
    if &expandtab
        set noexpandtab
        echo "Using tabs"
    else
        set expandtab
        echo "Using spaces"
    endif
endfunction

" Function to remove trailing whitespace
function! RemoveTrailingWhitespace()
    let l:save_cursor = getpos(".")
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfunction

" Function to format JSON
function! FormatJSON()
    %!python -m json.tool
endfunction

" =============================================================================
" KEY MAPPINGS FOR FUNCTIONS
" =============================================================================

nnoremap <leader>t :call ToggleTabSpaces()<CR>
nnoremap <leader>w :call RemoveTrailingWhitespace()<CR>
nnoremap <leader>j :call FormatJSON()<CR>

" =============================================================================
" AUTOCOMMANDS
" =============================================================================

" Remove trailing whitespace on save
autocmd BufWritePre * :call RemoveTrailingWhitespace()

" Auto-reload vimrc when it's saved
autocmd BufWritePost .vimrc source %

" =============================================================================
" LOCAL CUSTOMIZATIONS
" =============================================================================

" Load local customizations if they exist
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

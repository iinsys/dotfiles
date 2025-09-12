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
" Plug 'tpope/vim-rhubarb'
" 
" " File explorer and navigation
" Plug 'scrooloose/nerdtree'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" 
" " Syntax checking and linting
" Plug 'vim-syntastic/syntastic'
" Plug 'dense-analysis/ale'
" 
" " Auto-completion and snippets
" Plug 'valloric/youcompleteme'
" Plug 'sirver/ultisnips'
" Plug 'honza/vim-snippets'
" 
" " Language support
" Plug 'ekalinin/dockerfile.vim'
" Plug 'hashivim/vim-terraform'
" Plug 'andrewstuart/vim-kubernetes'
" Plug 'fatih/vim-go'
" Plug 'python-mode/python-mode'
" Plug 'vim-python/python-syntax'
" 
" " Status line and UI
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'morhetz/gruvbox'
" 
" " Code formatting and utilities
" Plug 'prettier/vim-prettier'
" Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-surround'
" Plug 'tpope/vim-repeat'
" 
" " Tmux integration
" Plug 'christoomey/vim-tmux-navigator'
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

" Function to run current Python file
function! RunPythonFile()
    if &filetype == 'python'
        execute '!python %'
    endif
endfunction

" Function to run current shell script
function! RunShellScript()
    if &filetype == 'sh' || &filetype == 'bash' || &filetype == 'zsh'
        execute '!bash %'
    endif
endfunction

" Function to generate ctags
function! GenerateCtags()
    execute '!ctags -R .'
    echo "Ctags generated"
endfunction

" Function to open file under cursor
function! OpenFileUnderCursor()
    let filename = expand('<cfile>')
    if filereadable(filename)
        execute 'edit ' . filename
    else
        echo "File not found: " . filename
    endif
endfunction

" Function to toggle between header and source files
function! ToggleHeaderSource()
    let filename = expand('%:t:r')
    let extension = expand('%:e')
    
    if extension == 'h' || extension == 'hpp'
        " Try to find corresponding .c or .cpp file
        for ext in ['c', 'cpp', 'cc', 'cxx']
            let candidate = filename . '.' . ext
            if filereadable(candidate)
                execute 'edit ' . candidate
                return
            endif
        endfor
    elseif extension == 'c' || extension == 'cpp' || extension == 'cc' || extension == 'cxx'
        " Try to find corresponding .h or .hpp file
        for ext in ['h', 'hpp']
            let candidate = filename . '.' . ext
            if filereadable(candidate)
                execute 'edit ' . candidate
                return
            endif
        endfor
    endif
    
    echo "No corresponding file found"
endfunction

" Function to create a new file in the same directory
function! CreateNewFile()
    let dir = expand('%:p:h')
    let filename = input('New filename: ', dir . '/')
    if filename != ''
        execute 'edit ' . filename
    endif
endfunction

" =============================================================================
" KEY MAPPINGS FOR FUNCTIONS
" =============================================================================

nnoremap <leader>t :call ToggleTabSpaces()<CR>
nnoremap <leader>w :call RemoveTrailingWhitespace()<CR>
nnoremap <leader>j :call FormatJSON()<CR>
nnoremap <leader>r :call RunPythonFile()<CR>
nnoremap <leader>s :call RunShellScript()<CR>
nnoremap <leader>g :call GenerateCtags()<CR>
nnoremap <leader>f :call OpenFileUnderCursor()<CR>
nnoremap <leader>h :call ToggleHeaderSource()<CR>
nnoremap <leader>n :call CreateNewFile()<CR>

" Advanced navigation
nnoremap <leader>b :buffers<CR>
nnoremap <leader>o :only<CR>
nnoremap <leader>d :bdelete<CR>

" Quick file operations
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>sp :split <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

" Git operations (if fugitive is installed)
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gd :Gdiff<CR>

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

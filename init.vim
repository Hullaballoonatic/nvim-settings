set nocompatible

filetype on
filetype plugin on
filetype indent on

syntax on

set nu
set relativenumber
set hidden
set signcolumn=number
set colorcolumn=120

set cursorline

set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set ai "Auto indent"
set si "Smart indent"

set nobackup
set nowb
set noswapfile

set scrolloff=8

set nowrap

set incsearch
set ic
set smartcase

set showcmd
set showmode
set showmatch
set mat=2
set hlsearch
set updatetime=50
set shortmess+=c
set history=1000
set autoread
au FocusGained,BufEnter * checktime

set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*xlsx

set hid
set ruler

set lazyredraw
set foldcolumn=1
set cmdheight=2

let g:loaded_perl_provider = 0
let g:airline_powerline_fonts = 1
let g:airline_powerline_theme = "default"

" KEY MAPS ------------------------------------------------------------- {{{
nnoremap <SPACE> <Nop>

let mapleader = "\<Space>"

nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })<CR>
" }}}

" PLUGINS -------------------------------------------------------------- {{{
call plug#begin()
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'rtp': './install --all' }
Plug 'github/copilot.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'kyazdani42/nvim-web-devicons'
call plug#end()
" }}}

" TODO: setup nerdtree?
" TODO: setup coc
" TODO: setup ale?

" COLORS --------------------------------------------------------------- {{{
colorscheme gruvbox
highlight Normal guibg=none
set termguicolors
" }}}

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" COMMANDS ------------------------------------------------------------ {{{
augroup HULLA
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    autocmd VimEnter * hi Normal ctermbg=none
    autocmd VimEnter * NERDTree | wincmd p
augroup END
" }}}

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

" LSP --------------------------------------------------------------- {{{
set completeopt=menuone,longest,noinsert,noselect,preview

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" }}}

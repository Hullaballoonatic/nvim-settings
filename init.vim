" PLUGINS -------------------------------------------------------------- {{{
let vim_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(vim_plug_path))
    silent execute '!iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni "' . vim_plug_path . '" -Force '
    autocmd VimEnter * PlugInstall --sync | source $nvim_config/init.vim
endif

call plug#begin()

	" Core (treesitter, nvim-lspconfig, nvim-cmp, nvim-telescope, nvim-lualine)
	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
	Plug 'nvim-treesitter/playground'
	Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'kyazdani42/nvim-tree.lua'
    Plug 'github/copilot.vim'

	" Functionalities
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-surround'
	Plug 'mhinz/vim-signify'
	Plug 'jiangmiao/auto-pairs'
	Plug 'alvan/vim-closetag'
	Plug 'tpope/vim-abolish'
	Plug 'junegunn/vim-easy-align'
	Plug 'scrooloose/nerdcommenter'
	Plug 'Yggdroot/indentLine'
	Plug 'chrisbra/Colorizer'
	Plug 'KabbAmine/vCoolor.vim'
	Plug 'dkarter/bullets.vim'
	Plug 'wellle/context.vim'
	Plug 'antoinemadec/FixCursorHold.nvim'

	" Aesthetics - Colorschemes
	Plug 'dracula/vim', { 'as': 'dracula' }
	Plug 'zaki/zazen'
	Plug 'yuttie/hydrangea-vim'

    Plug 'junegunn/rainbow_parentheses.vim'
call plug#end()

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $nvim_config/init.vim
\| endif
" }}}

" COLORS --------------------------------------------------------------- {{{
" Functions and autocmds to run whenever changing colorschemes
function! TransparentBackground()
    highlight Normal guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    set fillchars+=vert:\│
    highlight WinSeparator gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
    highlight VertSplit gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
endfunction

" Use these colors for Pmenu, CmpPmenusBorder and TelescopeBorder when using dracula colorscheme
function! DraculaTweaks()
    " Pmenu colors when not using bordered windows
    highlight Pmenu guibg=#363948
    highlight PmenuSbar guibg=#363948
    " Completion/documentation Pmenu border color when using bordered windows
    highlight link CmpPmenuBorder NonText
    " Telescope borders
    highlight link TelescopeBorder Constant
endfunction

autocmd VimEnter * hi Normal ctermbg=none

augroup MyColors
    autocmd!
    autocmd ColorScheme dracula call DraculaTweaks()
    autocmd ColorScheme * call TransparentBackground()
augroup END

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

color dracula
set termguicolors
" }}}

" CONFIGURATIONS ------------------------------------------------------- {{{
""" Main
filetype plugin indent on
set nobackup nowb noswapfile autoread
autocmd FocusGained,BufEnter * checktime "goes with autoread to know if file changed outside of vim
set updatetime=50 history=1000
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent
set incsearch ignorecase smartcase hlsearch
set wildmode=longest,list,full wildmenu wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*xlsx
set ruler laststatus=2 showcmd showmode
" set list listchars=listchars=trail:»,tab:»-
" set fillChars+=vert:\
set nowrap
set encoding=utf-8
set scrolloff=8
set hidden
set number relativenumber
set title

""" Filetype-Specific
" HTML, XML, Jinja
autocmd FileType svelte setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2 autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>

" Markdown
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2

""" Core plugin configuration
 "Treesitter
augroup DraculaTreesitterSourcingFix
    autocmd!
    autocmd ColorScheme dracula runtime after/plugin/dracula.vim
    syntax on
augroup end

" nvim-cmp
set completeopt=menu,menuone,noselect

" signify
let g:signify_sign_add = '|'
let g:signify_sign_delete = '|'
let g:signify_sign_change = '|'
hi DiffDelete guifg=#ff5555 guibg=none

" indentLine
let g:indentLine_char = '▏'
let g:indentLine_defaultGroup = 'NonText'
" Disable indentLine from concealing json and markdown syntax (e.g. ```)
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" FixCursorHold for better performance
let g:cursorhold_updatetime = 100

" context.vim
let g:context_nvim_no_redraw = 1

" Neovim :Terminal
tmap <Esc> <C-\><C-n>
tmap <C-w> <Esc><C-w>
"tmap <C-d> <Esc>:q<CR>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

""" Core plugin configuration (lua)
lua << EOF
require('treesitter-config')
require('nvim-cmp-config')
require('lspconfig-config')
require('telescope-config')
require('lualine-config')
require('nvim-tree-config')
require('diagnostics')
-- require('nvim-lightbulb-config')
EOF

" KEY MAPS ------------------------------------------------------------- {{{
nnoremap <SPACE> <Nop>

let mapleader = "\<Space>"

" Core
nmap \ :NvimTreeFindFileToggle<CR>
" xmap <leader>a gaip*
" nmap <leader>a gaip*
" set to auto?
nmap <leader>h :RainbowParentheses!!<CR> 
nmap <leader>k :ColorToggle<CR>
nmap <silent> <leader><leader> :noh<CR>
" nmap <Tab> :bnext<CR> " buffer next
" nmap <S-Tab> :bprevious<CR> " buffer prev
" }}}

" Python
autocmd Filetype python nmap <leader>d <Plug>(pydocstring)
autocmd Filetype python nmap <leader>p :Black<CR>

" Solidity (requires: npm i --save-dev prettier prettier-plugin-solidity
autocmd Filetype solidity nmap <leader>p :0,$!npx prettier %<CR>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <leader>fc <cmd>Telescope colorscheme<CR>
nnoremap <leader>f/ <cmd>Telescope current_buffer_fuzzy_find<CR>

" COMMANDS ------------------------------------------------------------ {{{
augroup AUTOFORMAT
    autocmd!

    autocmd BufWritePre *.svelte lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.cs lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.html lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.css lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.scss lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
augroup END
" }}}

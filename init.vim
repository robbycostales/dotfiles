" Set leader key (spacebar)
nnoremap <SPACE> <Nop>
let mapleader = " "
let maplocalleader = " "
" + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
"                                    SETS
" + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

set shiftwidth=4 " Set indent size
set expandtab " Turn tabs into spaces
set smartindent " Smart indents
set guicursor= " Replace neovim default line cursor with block
set relativenumber " Relative line numbers
set nohlsearch " Remove highlighting after search
set hidden " Prevent save warnings when switching between buffers
set noerrorbells " No sound on errors
set nu " Show line nunber (next to relative line numbers)
set noswapfile " Get rid of swap files
set nobackup " Get rid of backup files
set undodir=~/.vim/undodir " Set directory to store undo files
set undofile " Allow undo files
set incsearch " Incremental search
set termguicolors " Use :highlight attributes instead of cterm attributes
set scrolloff=10 " Start scrolling early
set noshowmode " Gets rid o -- INSERT -- message (?)
set nowrap " Do not wrap
set colorcolumn=80 " Draw bar at column 80
set signcolumn=yes " Add bar to left to display signs (e.g. Git symbols)
" Give more space for displaying messages
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience
set updatetime=50
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set encoding=utf-8

" Prevent issues with switching between (anaconda) virtual environments
if has("mac")
    let g:python3_host_prog = '/Users/robertcostales/anaconda3'
elseif has("unix")
    let g:python3_host_prog = '/home/robby/anaconda3'
endif

" + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
"                            KEY MAPPINGS
" + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

" Shortcutting split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Shortcut split opening
nnoremap <leader>hs :split<CR>
nnoremap <leader>vs :vsplit<CR>

" Mappings to move lines
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
" inoremap <leader>j <Esc>:m .+1<CR>==gi
" inoremap <leader>k <Esc>:m .-2<CR>==gi
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv

" + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
"                            NICE FUNCTIONS
" + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

" Trim white space in file on each save
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Create autogroup to prevent multiple listeners from sourcing
augroup ROBBY
    " Clear all autocommands in group
    autocmd!
    " Trim whitespaces before writing files
    autocmd BufWritePre * :call TrimWhitespace()
    " Source on save
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
"                           INSTALL PLUGINS
" + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

" Plugins
call plug#begin('~/.vim/plugged')

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
" Theme
Plug 'gruvbox-community/gruvbox'
" Git support (:Git <>)
Plug 'tpope/vim-fugitive'
" Quoting / parenthesizing tools (cs'")
Plug 'tpope/vim-surround'
" Tree explorer
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
" Commenter
Plug 'scrooloose/nerdcommenter'
" Syntax checking (for Python, need PyLint installed)
Plug 'scrooloose/syntastic'
" Git differences
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
" Status tabline
Plug 'vim-airline/vim-airline'
" Tags
Plug 'universal-ctags/ctags'
Plug 'majutsushi/tagbar'
" Neovim lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
" Indent guides (visual)
Plug 'nathanaelkane/vim-indent-guides'
" Undo Tree
Plug 'mbbill/undotree'

call plug#end()

" + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
"                          PLUGIN CONFIGURATIONS
" + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

" TELESCOPE
" Key bindings
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" GRUVBOX
" Colorscheme
colorscheme gruvbox

" NERD TREE
" Allow line numbers
let NERDTreeShowLineNumbers=1
" Open
nmap <C-f> :NERDTreeToggle<CR>
" Comment
augroup NERDTREE
    autocmd!
    " Enable relative line numbers in NERDTree
    autocmd FileType nerdtree setlocal relativenumber
    " Open automatically on start
    " autocmd VimEnter * NERDTree
    " Smart closing
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END
" Make NERDTree scrolling faster (prevent lag)
let NERDTreeHighlightCursorline = 0
set lazyredraw

" AIRLINE
" View all buffers (when only one tab open)
let g:airline#extensions#tabline#enabled = 1

" NERD COMMENTER (NOTE: Default mappings have problems with space leader)
" Select default mappings (manual)
nmap <leader>cc <plug>NERDCommenterComment
vmap <leader>cc <plug>NERDCommenterComment
nmap <leader>cu <plug>NERDCommenterUncomment
vmap <leader>cu <plug>NERDCommenterUncomment
nmap <leader>ci <plug>NERDCommenterInvert
vmap <leader>ci <plug>NERDCommenterInvert
nmap <leader>cs <plug>NERDCommenterSexy
vmap <leader>cs <plug>NERDCommenterSexy
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
" Necessary for integration with other plugin(s) (?)
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" TAGBAR
let g:Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_2/bin/ctags'
nmap <leader>tb :TagbarToggle<CR>

" LSP
set completeopt=menuone,noinsert,noselect
nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.rust_analyzer.setup{ on_attach=require'completion'.on_attach }

" INDENT GUIDES
let g:indent_guides_enable_on_vim_startup = 1
set ts=4 sw=4 et
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" UNDO TREE
nnoremap <leader>ut :UndotreeToggle<CR>
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

" COMPLETION NVIM
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
"map <c-p> to manually trigger completion
imap <silent> <c-p> <Plug>(completion_trigger)

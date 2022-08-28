"----------------
" Plugin Manager
"----------------

" Vim-Plug
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"
  autocmd VimEnter * PlugInstall
endif

" Plugins
call plug#begin(expand('~/.config/nvim/plugged'))
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()

"------------------
" General settings
"------------------

set nocompatible            " disable compatibility to old-time vi
set termguicolors
set linebreak
set smartindent
set wildmode=list:longest,full
set title
set mouse=a
set showmatch               " show matching
set ignorecase              " case insensitive
set hlsearch                " highlight search
set gdefault                " Enable flag g in replace command like :%s/a/b/
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
filetype plugin indent on   "allow auto-indenting depending on file type
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
set noswapfile            " disable creating swap file

" Show ↪ at the beginning of wrapped lines
    if has('linebreak')
        let &sbr = nr2char(8618).' '
    endif

" Colors
set background=dark
colorscheme gruvbox
hi Comment gui=italic cterm=italic                      " italic comments
hi Search guibg=#b16286 guifg=#ebdbb2 gui=NONE          " search string highlight color
hi NonText guifg=bg                                     " mask ~ on empty lines
hi clear CursorLineNr                                   " use the theme color for relative number
hi CursorLineNr gui=bold                                " make relative number bold
hi SpellBad guifg=NONE gui=bold,undercurl               " misspelled words
" colors for git (especially the gutter)
hi Normal guibg=NONE ctermbg=NONE
hi DiffAdd  guibg=#1d2021 guifg=#98971a
hi DiffChange guibg=#1d2021 guifg=#d79921
hi DiffRemoved guibg=#1d2021 guifg=#cc241d

"-----------------
" Plugin settings
"-----------------

" built in plugins
let g:loaded_netrw = 0                                  " disable netew
let g:omni_sql_no_default_maps = 1                      " disable sql omni completion
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = expand('/usr/bin/python3')

" Colorizer
lua require'colorizer'.setup()

" Indenting
lua require'indent_blankline'.setup()

" Works for some fucking reason, looks cool enough
highlight IndentBlankLineChar guifg=#E5C07B gui=nocombine

" Doesn't really work, would be cool with gruv colors doe
"highlight IndentBlankLineChar guifg=#458588 gui=nocombine
"highlight IndentBlanklineIndent1 guifg=#fb4934 gui=nocombine
"highlight IndentBlanklineIndent2 guifg=#d79921 gui=nocombine
"highlight IndentBlanklineIndent3 guifg=#b8bb26 gui=nocombine
"highlight IndentBlanklineIndent4 guifg=#83a598 gui=nocombine
"highlight IndentBlanklineIndent5 guifg=#8ec07c gui=nocombine
"highlight IndentBlanklineIndent6 guifg=#d3869b gui=nocombine

" Lualine

lua << END
require('lualine').setup()
END

"---------------
" Commands
"---------------

au BufEnter * set fo-=c fo-=r fo-=o                     " stop annoying auto commenting on new lines
au FileType help wincmd L                               " open help in vertical split
au BufWritePre * :%s/\s\+$//e                           " remove trailing whitespaces before saving

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"----------
" Mappings
"----------

" general
let mapleader=","
nnoremap ; :
nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>
noremap <C-q> :q!<CR>
nmap <leader>q :bd<CR>
nmap \ <leader>q
noremap <leader>e :PlugInstall<CR>
nmap <leader>r :so ~/.config/nvim/init.vim<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
map <F4> :Startify<CR>
nmap <leader>g :Goyo<CR>
nmap <F9> mz:execute TabToggle()<CR>'z

" new line in normal mode and back
map <Enter> o<ESC>
map <S-Enter> O<ESC>

" use a different buffer for dd
nnoremap d "_d
vnoremap d "_d
vnoremap p "_dP
nnoremap x "_x

" emulate windows copy/cut behavior
vnoremap <C-c> "+y<CR>
vnoremap <C-x> "+d<CR>

" switch between splits using ctrl + {h,j,k,l}
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
noremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" disable hl with 2 esc
noremap <silent><esc> <esc>:noh<CR><esc>

" trim white spaces
nnoremap <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

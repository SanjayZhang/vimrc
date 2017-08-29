" use command bellow install vundle for vim:
"   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Custom Plugin Start
Plugin 'altercation/vim-colors-solarized'   " theme solarized
Plugin 'scrooloose/nerdtree'                " file/directory treee
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'           " code commenter
Plugin 'nathanaelkane/vim-indent-guides'
" Custom Plugin End

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Settings
" forbid cursor blink
set gcr=a:block-blinkon0
set laststatus=2
set ruler
set number
set cursorline
"set cursorcolumn
" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
"
syntax enable
syntax on
" Theme
set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
" Height of the command bar
set cmdheight=1

set showcmd
set showmode
set scrolloff=2
" Identify invisible characters and don't show them by default
set list listchars=eol:¬,tab:\ \ ,trail:·,
" <, >, <<, >> match indent
set shiftround
" Replace tab with 4 whitespace
"filetype indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Encoding, autoindent
set autoindent
set encoding=utf-8
set fileencodings=utf-8
set fileencoding=utf-8
set fileformats=unix,dos

" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Turn backup off, since most stuff is in SVN, git et.c anyway
set nobackup
set nowb
set noswapfile


" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" A buffer becomes hidden when it is abandoned
set hid

" Close the current buffer
map <leader>bd :bdelete<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>


" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>


" Turn on the wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Clipboard
set clipboard=unnamed
set pastetoggle=<F10>

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
"set whichwrap+=<,>,h,l

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" => Parenthesis/bracket
vnoremap $( <esc>`>a)<esc>`<i(<esc>
vnoremap $[ <esc>`>a]<esc>`<i[<esc>
vnoremap ${ <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $' <esc>`>a'<esc>`<i'<esc>
vnoremap $" <esc>`>a"<esc>`<i"<esc>
" Map auto complete of (, ", ', [
inoremap $( ()<esc>i
inoremap $[ []<esc>i
inoremap ${ {}<esc>i
inoremap $} {<esc>o}<esc>O
inoremap $' ''<esc>i
inoremap $" ""<esc>i

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2


" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


" Search
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" For regular expressions turn magic on
set magic

" NERDTree
" Open NERDTree
map <C-n> :NERDTreeToggle<CR>
map <leader>nt :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let g:NERDTreeWinSize=30
" Change default arrows
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" NeRDTree git  
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "u",
    \ "Renamed"   : "->",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "-",
    \ "Dirty"     : "!",
    \ "Clean"     : "c",
    \ 'Ignored'   : "~",
    \ "Unknown"   : "?"
    \ }
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="solarized"
" Ctrlp
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
nmap <silent> <Leader>i <Plug>IndentGuidesToggle

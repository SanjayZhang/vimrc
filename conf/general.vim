" Vundle Plugin stuff
set nocompatible              " be iMproved, required
filetype off                  " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" Put your non-Plugin stuff after this line

" Settings
" Forbid cursor blink
set gcr=a:block-blinkon0
set laststatus=2
set ruler
set number

set cursorline
autocmd WinEnter * set cursorline
autocmd WinLeave * set nocursorline
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
nmap <Leader>w :w!<CR>
" Fast quit
nmap <Leader>q :q<CR>
nmap <Leader>Q :q!<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Turn backup off, since most stuff is in SVN, git et.c anyway
set nobackup
set nowb
set noswapfile


" Smart way to move between windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" A buffer becomes hidden when it is abandoned
set hid

" Close the current buffer
map <Leader>bd :bdelete<CR>

" Close all the buffers
map <Leader>ba :bufdo bd<CR>

map <Leader>bn :bnext<CR>
map <Leader>bp :bprevious<CR>


" Useful mappings for managing tabs
map <Leader>t<Leader> :tabnew<CR>
map <Leader>to :tabonly<CR>
map <Leader>tc :tabclose<CR>
map <Leader>tm :tabmove<CR>
map <Leader>tn :tabnext<CR>
map <Leader>tp :tabprevious<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <Leader>te :tabedit <C-R>=expand("%:p:h")<CR>/

map <Leader>co ggVGy:tabnew<CR>:set syntax=qf<CR>pgg

" Cope
map <Leader>bc :botright cope<CR>
map <Leader>cn :cn<CR>
map <Leader>cp :cp<CR>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Switch CWD to the directory of the open buffer
map <Leader>cd :cd %:p:h<CR>:pwd<CR>


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

" Toggle paste mode on and off
map <Leader>pp :setlocal paste!<CR>

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
"set whichwrap+=<,>,h,l

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<CR>`z
nmap <M-k> mz:m-2<CR>`z
vmap <M-j> :m'>+<CR>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

nnoremap [e  :<C-U>execute 'move -1-'. v:count1<CR>
nnoremap ]e  :<C-U>execute 'move +'. v:count1<CR>

" Fast add space
nnoremap [<Space>  :<C-U>put! =repeat(nr2char(10), v:count1)<CR>'[
nnoremap ]<Space>  :<C-U>put =repeat(nr2char(10), v:count1)<CR>

" => Parenthesis/bracket
vnoremap $( <Esc>`>a)<Esc>`<i(<Esc>
vnoremap $[ <Esc>`>a]<Esc>`<i[<Esc>
vnoremap ${ <Esc>`>a}<Esc>`<i{<Esc>
vnoremap $$ <Esc>`>a"<Esc>`<i"<Esc>
vnoremap $' <Esc>`>a'<Esc>`<i'<Esc>
vnoremap $" <Esc>`>a"<Esc>`<i"<Esc>
" Map auto complete of (, ", ', [
inoremap $( ()<Esc>i
inoremap $[ []<Esc>i
inoremap ${ {}<Esc>i
inoremap $} {<Esc>o}<Esc>O
inoremap $' ''<Esc>i
inoremap $" ""<Esc>i

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2


" Pressing ,ss will toggle and untoggle spell checking
map <Leader>ss :setlocal spell!<CR>

" Shortcuts using <Leader>
map <Leader>sn ]s
map <Leader>sp [s
map <Leader>sa zg
map <Leader>s? z=


" Search
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <Space> /
map <C-Space> ?

" Disable highlight when <Leader><CR> is pressed
map <silent> <Leader>/ :noh<CR>

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

cnoremap %% <C-R>=escape(expand('%:h').'/', ' ')<CR>
noremap <Leader>ff :vimgrep /<C-R><C-W>/g <C-R>=escape(getcwd().'/', ' ')<CR>**<CR>:copen<CR>
noremap <Leader>fw :vimgrep /<C-R><C-W>/g <C-R>=escape(getcwd().'/', ' ')<CR>**
noremap <Leader>fc :vimgrep /<C-R><C-W>/g <C-R>=escape(expand('%:h').'/', ' ')<CR>**

" COMMAND-LINE MODE
" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

cnoremap <C-D> <Del>


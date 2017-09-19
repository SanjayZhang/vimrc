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
Plugin 'WinterXMQ/escalt.vim'               " Get Alt key to work in terminal
Plugin 'altercation/vim-colors-solarized'   " theme solarized
Plugin 'scrooloose/nerdtree'                " file/directory treee
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'jszakmeister/markdown2ctags'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'terryma/vim-expand-region'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdcommenter'           " code commenter
Plugin 'tpope/vim-fugitive'
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


" NERDTree
" Open NERDTree
map <F1> :NERDTreeToggle<CR>
map <Leader>nn :NERDTreeToggle<CR>
map <Leader>nt :NERDTreeToggle<CR>
map <Leader>nb :NERDTreeFromBookmark<Space>
map <Leader>nf :NERDTreeFind<CR>
" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let g:NERDTreeWinSize = 30
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

" Tagbar
nmap <C-F12> :TagbarToggle<CR>
" Autofocus on tagbar open
let g:tagbar_autofocus = 1
" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/.vim/bundle/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "solarized"
"let g:airline_powerline_fonts = 1

" Ctrlp
let g:ctrlp_map = '<Leader><Space>'
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
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
nmap <silent> <Leader>i <Plug>IndentGuidesToggle

" Multiple Cursors
let g:multi_cursor_next_key = '<C-N>'
let g:multi_cursor_prev_key = '<C-P>'
let g:multi_cursor_skip_key = '<C-X>'
let g:multi_cursor_quit_key = '<Esc>'

let g:multi_cursor_start_key = '<C-N>'
let g:multi_cursor_start_word_key = 'g<C-N>'

" NERD Commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Conflict with the map of cope, so map this
nmap <silent> <Leader>ce <plug>NERDCommenterNested

if has('win32')
  nmap <C-/> <Leader>c<Space>
  vmap <C-/> <Leader>c<Space>
else
  nmap <C-_> <Leader>c<Space>
  vmap <C-_> <Leader>c<Space>
endif

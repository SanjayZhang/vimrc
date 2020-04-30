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
" Plugin 'altercation/vim-colors-solarized'   " theme solarized
Plugin 'scrooloose/nerdtree'                " file/directory treee
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'jszakmeister/markdown2ctags'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Yggdroot/indentLine'
Plugin 'easymotion/vim-easymotion'
Plugin 'terryma/vim-expand-region'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'           " code commenter
" Plugin 'aklt/plantuml-syntax'
Plugin 'vimscript/plantuml'
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


" NERDTree
" Open NERDTree
map <F1> :NERDTreeToggle<CR>
map <Leader>nn :NERDTreeFocus<CR>
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
    \ "Modified"  : "~",
    \ "Staged"    : "+",
    \ "Untracked" : "*",
    \ "Renamed"   : "»",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "-",
    \ "Dirty"     : "!",
    \ "Clean"     : "ø",
    \ 'Ignored'   : "∙",
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

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
\ }

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" IndentLine
let g:indentLine_char = '│'
" Vim
let g:indentLine_color_term = 239
" None X terminal
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)

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

" PlantUML Syntax
" let g:plantuml_executable_script='java -jar c:\utils\plantuml\plantuml.jar'
"
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!chrome % &"
    elseif &filetype ==  'mkd'
        exec "!~/.vim/Markdown.pl % > %.html &"
        ecec "!chrome %.html &"
    endif
endfunc

function! GetDotVimPath(path)
    return "~/.vim/" . a:path
endfunction

for file in split(glob(GetDotVimPath('conf/*.vim')), '\n')
    exe 'source' file
endfor

fun! StripTrailingWhitespace()
    if &filetype =~ 'python\|perl'
        return
    endif
    %s/\s\+$//e
endfun

" Call on Filewrite
autocmd BufWritePre * call StripTrailingWhitespace()

" Call on mapping invocation
noremap <silent> <C-a> <Esc>:call StripTrailingWhitespace()<CR>

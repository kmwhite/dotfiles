augroup GIT
    autocmd!
    autocmd FileType gitcommit call s:GitDiffCachedPreview(18)
augroup END

function! s:GitDiffCachedPreview(max_height) abort
    if (!&previewwindow) && (expand('%:t') !~# 'index')
        DiffGitCached | wincmd L | wincmd p
    endif
endfunction

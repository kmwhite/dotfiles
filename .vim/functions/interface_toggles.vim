function! ToggleOverLengthHi()
    if exists("b:overlengthhi") && b:overlengthhi
        highlight clear OverLength
        let b:overlengthhi = 0
        echo "overlength hilight off"
    else
        " adjust colors/styles as desired
        highlight OverLength ctermbg=darkred gui=undercurl guisp=blue
        " change '81' to be 1+(number of columns)
	" 80 - new line - ' + ' - buffer = 75
        match OverLength /\%75v.\+/
        let b:overlengthhi = 1
        echo "overlength hilight on"
    endif
endfunction
map <silent> <C-l> <Esc>:call ToggleOverLengthHi()<CR>

function! ToggleSearchHL()
       if &hlsearch
            set nohlsearch
            echo "search hilight off"
       else
            set hlsearch
            echo "search hilight on"
       endif
endfunction
map <silent> <C-m> <Esc>:call ToggleSearchHL()<CR>

function! ToggleSpellingHL()
       if &spell
            set nospell
            echo "spell hilight off"
       else
            set spell
            echo "spell hilight on"
       endif
endfunction
map <silent> <C-n> <Esc>:call ToggleSpellingHL()<CR>

function! ToggleCursorHL()
       if &cursorline
            set nocursorcolumn " highlight the current column
            set nocursorline " highlight current line
            echo "cursor hilight off"
       else
            set cursorcolumn
            set cursorline
            echo "cursor hilight on"
       endif
endfunction
map <silent> <C-k> <Esc>:call ToggleCursorHL()<CR>

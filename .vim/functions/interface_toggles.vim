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

map <silent> <C-p> <Esc>:Files<CR>

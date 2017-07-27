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

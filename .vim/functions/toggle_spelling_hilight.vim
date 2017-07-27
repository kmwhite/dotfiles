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

function ToggleSearchHL()
       if &hlsearch
            set nohlsearch
            echo "search hilight off"
       else
            set hlsearch
            echo "search hilight on"
       endif
endfunction
map <silent> <C-m> <Esc>:call ToggleSearchHL()<CR>

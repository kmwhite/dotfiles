function ToggleOverLengthHi()
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

" Disable Crap
set guioptions-=m			"remove menu bar
set guioptions-=T			"remove toolbar
set guioptions-=r			"remove right-hand scrollbar

" Provide Mappings to Re-Enable Crap
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

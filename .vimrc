" Vim Configuration File

" Plug Setup
call plug#begin('~/.vim/plugged')
" Configuration Libraries
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'
" Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'chriskempson/base16-vim'
Plug 'srcery-colors/srcery-vim'
" Source Control
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
" Community
Plug 'junegunn/vim-github-dashboard'
" Language and Syntax
Plug 'vim-syntastic/syntastic'
Plug 'elixir-lang/vim-elixir'
Plug 'KabbAmine/zeavim.vim'
" File Management
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Tag Management
Plug 'xolox/vim-misc', { 'on': 'Tagbar' }
Plug 'xolox/vim-easytags', { 'on': 'Tagbar' }
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
call plug#end()

" Disable Arrow Keys
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>

" Vim needs a non-fish shell to run smoothly.
set shell=/bin/sh

if has("gui_running")
  set guioptions-=R
  set guioptions-=r
  set guioptions-=L
  set guioptions-=l
  set guifont=Iosevka\ Type\ Slab\ Medium\ 12
endif

" General Configs
set nocompatible                       " use Vim, not Vi
set ttyfast                            " smoother changes, alt:nottyfast
set virtualedit+=block                 " draw past eol with draw.vim
set showcmd                            " display incomplete commands
set noerrorbells                       " disable audible bells,
set visualbell                         " turn on visual bell, alt:novisualbell
set visualbell t_vb="<Esc>|f"          " turn off error beep/flash
set shortmess=atI                      " Abbreviate messages
set backspace=indent,eol,start         " Allow the erasure of data from a
                                       " another INSERT session
set tabpagemax=100                     " Increase tabs opened by `-p`

" helptags ~/.vim/doc                  " loading the Vim helptags
set notitle                            " disable 'Thanks for flying vim'

" Tabs, Indent and Whitespace (DEFAULTS: Overriden by autocmd)
set noautoindent                       " alt:autoindent
set nosmartindent                      " alt:smartindent
set nocindent                          " alt:cindent

" Searching
" See ToggleHLSearch() also
set incsearch                          " do incremental searching
set noignorecase                       " don't ignore case, alt:ignorecase

" Backups
set backup                             " keep a backup file
set bdir=~/.vim/bak                    " set the backup-directory
set bex=~                              " set the backup-extension

" Colors and Highlighting
" set termguicolors
syntax on                              " syntax highlighing
set t_Co=256                           " turn on 256 color mode
set showmatch                          " highlight matching brace

"" Dracula Colors
" set background=dark
" let g:dracula_italic = 0               " enable/disable italics
" let g:dracula_colorterm = 1            " configure `truecolor` support in term
" let g:fzf_colors = {
" 	\ 'fg': ['fg', 'Normal'],
" 	\ 'bg': ['bg', 'Normal'],
" 	\ 'hl': ['fg', 'Search'],
" 	\ 'fg+': ['fg', 'Normal'],
" 	\ 'bg+': ['bg', 'Normal'],
" 	\ 'hl+': ['fg', 'DraculaOrange'],
" 	\ 'info': ['fg', 'DraculaPurple'],
" 	\ 'border': ['fg', 'Ignore'],
" 	\ 'prompt': ['fg', 'DraculaGreen'],
" 	\ 'pointer': ['fg', 'Exception'],
" 	\ 'marker': ['fg', 'Keyword'],
" 	\ 'spinner': ['fg', 'Label'],
" 	\ 'header': ['fg', 'Comment'] }
" colorscheme dracula

"" Srcery Colors
" let g:srcery_bold = 1
" let g:srcery_italic = 1
" colorscheme srcery

"" Base16 Colors
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Modelines
set modeline                           " last lines in document sets Vim mode
set modelines=3                        " number lines checked for modelines

" Wrapping
set nowrap                             " don't wrap lines, alt:wrap
set whichwrap=b,s,h,l,<,>,[,]          " move freely between files

" Spelling
" See ToggleHLSpell() also
set nospell                            " turn on spelling, alt:spell

" Numbering
set number                             " show line numbers

" Scrolling
set scrolloff=3                        " keep 3 lines when scrolling
set nostartofline                      " don't jump to first whitespace in paging, alt:startofline
set ruler                              " show the cursor position, alt:noruler
                                       " set rulerformat=%15(%c%V\ %p%%%)
" Statusbar
" from https://github.com/spf13/spf13-vim/blob/master/.vimrc
if has('statusline')
  set laststatus=2                         " Show statusline (2 lines) on last window
  " Broken down into easily includeable segments
  set statusline=%<%f\ (%{&fenc})\             " Filename with Encoding
  set statusline+=%w%h%m%r                     " Options
  set statusline+=\ [%{&ff}/%Y]                " FileType
  " set statusline+=\ [%{getcwd()}]              " Current working directory
  set statusline+=%#warningmsg#
  set statusline+=%*
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%      " Right aligned file nav info
endif

" FileEncoding Magic!
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif

    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
else
    set encoding=iso-8859-1                " We aren't cool enough for UTF-8
    set fileencoding=ascii                 " We aren't cool enough for UTF-8
endif

" AutoCommand Magic!
if has("autocmd")

    " Enable file type detection
    if $HOME !~# '^/Users/'
        filetype off " Debian preloads this before the runtimepath is set
    endif

    if version > 600
        filetype plugin indent on
    else
        filetype on
    endif


    " Restore cursor position and set line
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " JavaScript
    autocmd FileType javascript
        \ setlocal textwidth=75|
        \ setlocal tabstop=2|
        \ setlocal softtabstop=2|
        \ setlocal shiftwidth=2|
        \ setlocal autoindent|
        \ setlocal expandtab|
        \ setlocal nospell

    " Ruby
    autocmd FileType ruby
        \ setlocal textwidth=75|
        \ setlocal tabstop=2|
        \ setlocal softtabstop=2|
        \ setlocal shiftwidth=2|
        \ setlocal autoindent|
        \ setlocal expandtab|
        \ setlocal nospell|
        \ setlocal omnifunc=rubycomplete#Complete

    " Perl
    autocmd FileType perl
        \ setlocal textwidth=75|
        \ setlocal tabstop=8|
        \ setlocal softtabstop=8|
        \ setlocal shiftwidth=8|
        \ setlocal autoindent|
        \ setlocal noexpandtab|
        \ setlocal nospell

    " YAML
    autocmd FileType yaml
        \ setlocal tabstop=2|
        \ setlocal softtabstop=2|
        \ setlocal shiftwidth=2|
        \ setlocal autoindent|
        \ setlocal expandtab|
        \ setlocal nospell

    " Make
    autocmd FileType make
        \ setlocal tabstop=8|
        \ setlocal softtabstop=8|
        \ setlocal shiftwidth=8|
        \ setlocal noexpandtab

    " C-like
    autocmd FileType c
        \ setlocal textwidth=75|
        \ setlocal tabstop=4|
        \ setlocal softtabstop=4|
        \ setlocal shiftwidth=4|
        \ setlocal noexpandtab

    " vim
    autocmd BufRead vim
        \ setlocal textwidth=75|
        \ setlocal tabstop=4|
        \ setlocal softtabstop=4|
        \ setlocal shiftwidth=4|
        \ setlocal expandtab|
        \ setlocal autoindent|
        \ setlocal nospell

    " CFEngine
    autocmd BufNewFile,BufRead *.cf setfiletype cfengine
    autocmd FileType cfengine
        \ setlocal textwidth=75|
        \ setlocal tabstop=8|
        \ setlocal softtabstop=8|
        \ setlocal shiftwidth=8|
        \ setlocal noexpandtab|
        \ setlocal autoindent|
        \ setlocal nospell

    " HTML
    autocmd BufNewFile,BufRead *.html.* setfiletype html
    autocmd FileType html
        \ setlocal textwidth=75|
        \ setlocal tabstop=2|
        \ setlocal softtabstop=2|
        \ setlocal shiftwidth=2|
        \ setlocal expandtab|
        \ setlocal spell

    " Plaintext
    autocmd BufNewFile,BufRead *.txt setfiletype plaintext
    autocmd FileType plaintext
        \ setlocal textwidth=75|
        \ setlocal tabstop=8|
        \ setlocal softtabstop=8|
        \ setlocal shiftwidth=8|
        \ setlocal noexpandtab|
        \ setlocal spell

    " Git Commit Messages
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setfiletype gitcommit
    autocmd FileType gitcommit
        \ setlocal backspace=2|
        \ setlocal textwidth=72|
        \ setlocal tabstop=8|
        \ setlocal softtabstop=8|
        \ setlocal shiftwidth=8|
        \ setlocal noexpandtab|
        \ setlocal spell

    " Omni-complete Enabling
    inoremap <Nul> <C-x><C-o>

endif

" Filewrite Mappings
cnoremap Wq wq
cnoremap WQ wq
cnoremap WW w !sudo tee 1>/dev/null %<CR>l<CR>

" Keyboard mappings
noremap ,e :e ~/.vimrc<cr>                                   " edit my .vimrc file
noremap ,u :source ~/.vimrc<cr>                              " update the system settings from my vimrc file

" Functions
source ~/.vim/functions/interface_toggles.vim
source ~/.vim/functions/strip_whitespace.vim

" YouCompleteMe Configuration
let g:ycm_server_python_interpreter="/usr/local/bin/python3.6"

" NERDTree Icon Overrides.
let g:NERDTreeDirArrowExpandable="→"
let g:NERDTreeDirArrowCollapsible="↘"

" Syntastic Option Overrides.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" EasyTags Configs
let g:easytags_async = 1

" TagBar Configs
nnoremap <F8> :TagbarToggle<CR>

" Vim Configuration File

" Plug Setup
call plug#begin('~/.vim/plugged')
" Colorschemes
Plug 'NLKNguyen/papercolor-theme'
" Source Control
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
" Community
Plug 'junegunn/vim-github-dashboard'
" Language and Syntax
Plug 'vim-syntastic/syntastic'
Plug 'elixir-lang/vim-elixir'
" File Management
Plug 'scrooloose/nerdtree',         { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter',    { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
" Tag Management
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
call plug#end()

" Disable Arrow Keys
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>

" Vim needs a non-fish shell to run smoothly.
set shell=/bin/bash

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
set t_Co=256                           " turn on 256 color mode
set showmatch                          " highlight matching brace
syntax on                              " syntax highlighing
set background=dark
colorscheme PaperColor

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
  set statusline+=%{fugitive#statusline()}     " Fuguitive Additions
  set statusline+=\ [%{&ff}/%Y]                " FileType
  set statusline+=\ [%{getcwd()}]              " Current working directory
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()} " Syntastic Additions
  set statusline+=%*
  let g:syntastic_enable_signs=1
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

    " Python
    " http://svn.python.org/projects/python/trunk/Misc/Vim/
    autocmd FileType python
        \ setlocal textwidth=75|
        \ setlocal tabstop=8|
        \ setlocal softtabstop=4|
        \ setlocal shiftwidth=4|
        \ setlocal expandtab|
        \ setlocal autoindent|
        \ setlocal nospell|
        \ setlocal complete+=k~/.vim/syntax/python.vim isk+=:,( |
        \ setlocal omnifunc=pythoncomplete#Complete|
        \ setlocal iskeyword+=:|
        \ setlocal foldmethod=indent|
        \ setlocal foldlevel=99|
        \ syn keyword pythonException try: except: finally:
        \ syn keyword pythonConditional if elif else:
    " autocmd BufWritePost *.py !find . -name '*.pyc' -exec rm {} \;
    let python_highlight_all  = 1

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

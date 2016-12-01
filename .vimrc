" Vim Configuration File

" Pathogen Setup
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

" Disable Arrow Keys
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>

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
set notitle                            " disable "Thanks for flying vim"

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
set ls=2                               " always show status line "%{fugitive#statusline()}"

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

    " Auto-trim trailing whitespaces
    autocmd BufWritePre * :%s/\s\+$//e

    " Restore cursor position and set line
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Python
    " http://svn.python.org/projects/python/trunk/Misc/Vim/
    autocmd Filetype python
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
    autocmd Filetype javascript
        \ setlocal textwidth=75|
        \ setlocal tabstop=2|
        \ setlocal softtabstop=2|
        \ setlocal shiftwidth=2|
        \ setlocal autoindent|
        \ setlocal expandtab|
        \ setlocal nospell

    " Ruby
    autocmd Filetype ruby
        \ setlocal textwidth=75|
        \ setlocal tabstop=2|
        \ setlocal softtabstop=2|
        \ setlocal shiftwidth=2|
        \ setlocal autoindent|
        \ setlocal expandtab|
        \ setlocal nospell|
        \ setlocal omnifunc=rubycomplete#Complete
    autocmd BufWritePost   *.rb !ruby -c %

    " Perl
    autocmd Filetype perl
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

" Customer command mappings
cmap Wq wq
cmap WQ wq
cmap WW w !sudo tee 1>/dev/null %<CR>l<CR>

" Keyboard mappings
map ,e :e ~/.vimrc<cr>                                   " edit my .vimrc file
map ,u :source ~/.vimrc<cr>                              " update the system settings from my vimrc file

" Functions
source ~/.vim/functions/toggle_overlength_hilight.vim
source ~/.vim/functions/toggle_search_hilight.vim
source ~/.vim/functions/toggle_spelling_hilight.vim
source ~/.vim/functions/toggle_cursor_hilight.vim

" NERDTree Icon Overrides.
let g:NERDTreeDirArrowExpandable="→"
let g:NERDTreeDirArrowCollapsible="↘"

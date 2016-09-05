set nocompatible
filetype off " required for vundle
let s:VIM_ROOT = $HOME . "/.config/rc/vim"
let &rtp .= "," . s:VIM_ROOT


" Vundle config
let &rtp .= "," . s:VIM_ROOT . "/bundle/vundle"
call vundle#begin()
Plugin 'Addisonbean/Vim-Xcode-Theme'
Plugin 'Chiel92/vim-autoformat'
Plugin 'Keithbsmiley/swift.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimshell.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'dcharbon/vim-flatbuffers'
Plugin 'derekelkins/agda-vim'
Plugin 'evanmiller/nginx-vim-syntax'
"Plugin 'gilligan/vim-lldb'
"Plugin 'wincent/command-t'
Plugin 'gmarik/Vundle.vim'
"Plugin 'jeaye/color_coded'
Plugin 'kana/vim-wwwsearch'
Plugin 'kien/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'leafgarland/typescript-vim.git'
Plugin 'mhinz/vim-startify'
Plugin 'mileszs/ack.vim.git'
Plugin 'morhetz/gruvbox'
Plugin 'racer-rust/vim-racer'
Plugin 'rhysd/vim-clang-format'
Plugin 'rking/ag.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive.git'
Plugin 'vim-scripts/a.vim'
call vundle#end()
filetype plugin indent on
" end Vundle config


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" clang-format
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortBlocksOnASingleLine" : "true",
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "ColumnLimit" : 90,
            \ "Standard" : "C++11"}

autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

" nerdtree
map <C-n> :NERDTreeToggle<CR>

" startify
let g:startify_files_number = 5
" Produced by 'figlet -f lean Vim'
let s:vim_banner = [
\ "",
\ "      _/      _/  _/",
\ "     _/      _/      _/_/_/  _/_/",
\ "    _/      _/  _/  _/    _/    _/",
\ "     _/  _/    _/  _/    _/    _/",
\ "      _/      _/  _/    _/    _/",
\ ""
\ ]

    "\ map(split(system(''), '\n'), '"    ". v:val') +
let g:startify_custom_header = s:vim_banner +
    \ map(split(system('python ' . s:VIM_ROOT . '/tip_of_the_day.py'), '\n'), '"    ". v:val')


"racer configuration
set hidden
let g:racer_cmd = "/Users/gk/.cargo/bin/racer"
let $RUST_SRC_PATH="/usr/local/src/rust/src/"

" autoformat
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']

" rainbow_parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
"let g:rbpt_loadcmd_toggle = 0
 " Always on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound  " ()
au Syntax * RainbowParenthesesLoadSquare " []
au Syntax * RainbowParenthesesLoadBraces " {}

set encoding=utf-8
set wildignore+=*/*.xcodeproj/*,*.o,*.so,*.pyc,*.swp,*.zip,*.gz

:let mapleader = ","

" C++ code completion ???
set completeopt=menuone
"filetype plugin on
set fileencodings=utf-8,cp1251


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" display
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" do not wrap long lines of text
set nowrap
" show command being entered
set showcmd
" show line numbers
set number
" <F2> -- toggles number
nnoremap <F2> :set nonumber!<CR>
" minimum number of columns to use for the line number
set nuw=4
" Show blank symbols
set list!
set listchars=tab:>-,trail:~,extends:>,precedes:<
" Minimal number of screen lines to keep above and below the cursor
set scrolloff=4
" Do not redraw screen while executing macros
set lazyredraw
" Highlight the screen line of the cursor
set cursorline

syntax on

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4
" windows always have status (needed for vim-powerline)
set laststatus=2
" show matching <> as well (% works too)
set matchpairs+=<:>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow backspacing over everything
set backspace=indent,eol,start
"" tabulation stuff
" In Insert mode: Use the appropriate number of spaces to insert <Tab>
set expandtab
" Number of spaces to use for each of (auto)indent. Used for 'cindent', >>, <<
set shiftwidth=4
" don't outdent hashes
inoremap # #

let s:AUTOCORRECTIONS = s:VIM_ROOT . "/autocorrect.vim"
exec "source " . s:AUTOCORRECTIONS
function AddAutocorrection()
    " yank word under cursor into @z
    normal "zyiw
    call inputsave()
    let l:correct = input('Autocorrect to: ')
    call inputrestore()
    if !empty(l:correct)
        exec ":iab " . @z . " " . l:correct
        exec "normal ciw" . l:correct
        call writefile(["iab " . @z . " " . l:correct], s:AUTOCORRECTIONS, "a")
        echon "Added autocorrection from " . @z . " to " . l:correct
    endif
endfunction
nmap <Leader>ac :call AddAutocorrection()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" searching
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Incremental search
set is


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap m :make<CR>
command! Q :q
command! Qa :qa
command! W :w
command! Wq :wq
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>> :tabnext<CR>
nnoremap <Leader>< :tabprev<CR>
nnoremap <F5> :GundoToggle<CR>
nnoremap t :CommandT<CR>


" completion stuff
inoremap ^] ^X^]
inoremap ^F ^X^F
inoremap ^D ^X^D
inoremap ^L ^X^L
" где ищем подстановки?
" . -  scan the current buffer ('wrapscan' is ignored)
" w - scan buffers from other windows
" b - scan other loaded buffers that are in the buffer list
" u - scan the unloaded buffers that are in the buffer list
" U - scan the buffers that are not in the buffer list
" k - scan the files given with the 'dictionary' option
" kspell - use the currently active spell checking |spell|
" k{dict} - scan the file {dict}.  Several 'k' flags can be given, patterns are valid too.  For example: >
"  :set cpt=k/usr/dict/*,k~/spanish
set complete=.,w,b,u,t,k/usr/include/GL/* " move to cpp related stuff
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"inoremap <Nul> <C-x><C-o>


set cindent

set autoindent

"set showmode
set spell spelllang=en
let &spellfile = s:VIM_ROOT . "spellfile.en.utf-8.add"
" doxygen syntax
":let g:load_doxygen_syntax=1
"nnoremap <silent> <F3> :set syntax=cpp.doxygen<CR>
" включаем крысу (:
"set mouse=a --- пропадал курсор )-;
" Use CTRL-S for saving, also in Insert mode
noremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <C-O>:update<CR>


" ---
" ???
set foldmethod=manual
" :color af

" python << EOL
" import vim
" def EvaluateCurrentRange():
"    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
" EOL
" map <C-h> :py EvaluateCurrentRange()

" Disabling bell
set vb

syntax enable
set background=dark
" colorscheme solarized
colorscheme gruvbox


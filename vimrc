set nocompatible
filetype off " required for vundle
let s:VIM_ROOT = $HOME . "/.config/rc/vim"
let &rtp .= "," . s:VIM_ROOT


" Vundle config
let &rtp .= "," . s:VIM_ROOT . "/bundle/vundle"
call vundle#begin()
"Plugin 'gilligan/vim-lldb'
"Plugin 'jeaye/color_coded'
Plugin 'Addisonbean/Vim-Xcode-Theme'
Plugin 'Chiel92/vim-autoformat'
Plugin 'Keithbsmiley/swift.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimshell.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'dcharbon/vim-flatbuffers'
Plugin 'fatih/vim-go'
Plugin 'gmarik/Vundle.vim'
Plugin 'jceb/vim-orgmode'
Plugin 'kana/vim-wwwsearch'
Plugin 'kien/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'leafgarland/typescript-vim.git'
Plugin 'mhinz/vim-startify'
Plugin 'mileszs/ack.vim.git'
Plugin 'morhetz/gruvbox'
Plugin 'rhysd/vim-clang-format'
Plugin 'rking/ag.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-speeddating'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/a.vim'
call vundle#end()
filetype plugin indent on
" end Vundle config


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline
let g:airline_powerline_fonts = 1
"let g:airline_left_sep=''
"let g:airline_right_sep=''
let g:airline_mode_map={'__': '-', 'n': 'N', 'i': 'I', 'R': 'R', 'c': 'C', 'v': 'V', 'V': 'V', '': 'V', 's': 'S', 'S': 'S', '': 'S',}
function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode'])
    "let g:airline_section_b = airline#section#create_left(['ffenc','file'])
    "let g:airline_section_c = airline#section#create(['%{getcwd()}'])
    let g:airline_section_x = airline#section#create(['%{getcwd()}'])
    let g:airline_section_y = airline#section#create([])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" autoformat
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']

" clang-format
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortBlocksOnASingleLine" : "false",
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "BreakStringLiterals" : "false",
            \ "ColumnLimit" : 90,
            \ "PointerAlignment" : "Left",
            \ "Standard" : "C++11"}

autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>F :ClangFormat<CR>
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

" nerdtree
map <C-n> :NERDTreeToggle<CR>

" orgmode
autocmd FileType org nnoremap <buffer> <Space> <Nop>
autocmd FileType org nnoremap <buffer> <Space>x :OrgCheckBoxToggle<CR>

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

" rust
autocmd FileType rust nnoremap <buffer><Leader>F :<C-u>RustFmt<CR>
autocmd FileType rust vnoremap <buffer><Leader>F :RustFmt<CR>

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

" YouCompleteMe
let g:ycm_auto_trigger = 1
let g:ycm_python_binary_path = 'python3'
let g:ycm_rust_src_path = $RUST_SRC_PATH

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

set encoding=utf-8
set wildignore+=*/*.xcodeproj/*,*.o,*.so,*.pyc,*.swp,*.zip,*.gz

let mapleader = ","

" C++ code completion ???
set completeopt=menuone
"filetype plugin on
set fileencodings=utf-8,cp1251


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" display
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight the screen line of the cursor
set cursorline
set guifont=Source\ Code\ Pro\ for\ Powerline:h12
" Do not redraw screen while executing macros
set lazyredraw
" Show blank symbols
set list!
set listchars=tab:>-,trail:~,extends:>,precedes:<
" Show matching <> as well (% works too)
set matchpairs+=<:>
" Do not wrap long lines of text
set nowrap
" Show line numbers
set number
" Minimum number of columns to use for the line number
set nuw=4
" Minimal number of screen lines to keep above and below the cursor
set scrolloff=4
" Show command being entered
set showcmd

syntax on

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4


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

function ConvertToNextCase()
    let l:script = s:VIM_ROOT . "/convert_case.py"
    exec ":pyfile " . l:script
endfunction

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
" Use CTRL-S for saving, also in Insert mode
noremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <C-O>:update<CR>
command! W :w
command! Wq :wq
nnoremap <Leader>a :Ag
nmap <Leader>ac :call AddAutocorrection()<CR>
nnoremap <Leader>C :call ConvertToNextCase()<CR>
nnoremap <Leader>f :YcmCompleter FixIt<CR>
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>> :tabnext<CR>
nnoremap <Leader>< :tabprev<CR>
nnoremap <Leader>" ciw"<ESC>pa"<ESC>
nnoremap <F5> :GundoToggle<CR>
"nnoremap t :CommandT<CR>
" <F2> -- toggles number
nnoremap <F2> :set nonumber!<CR>



set cindent
set autoindent

set spell spelllang=en
let &spellfile = s:VIM_ROOT . "spellfile.en.utf-8.add"
" doxygen syntax
":let g:load_doxygen_syntax=1
"nnoremap <silent> <F3> :set syntax=cpp.doxygen<CR>

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
if has("gui_macvim")
    set background=light
    colorscheme solarized
else
    colorscheme gruvbox
endif

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

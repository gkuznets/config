case `uname` in
    ("Darwin") local PLATFORM="macosx" ;;
    ("Linux") local PLATFORM="linux" ;;
    (*) local PLATFORM="unknown" ;;
esac

local RC_ROOT=$HOME/.config/rc

cpp_compiler() {
    case $PLATFORM in
        ("macosx") print "clang++ --std=c++1z -Wall -march=native" ;;
        ("linux") print "g++ --std=c++1z -Wall -march=native" ;;
        (*) print "c++" ;;
    esac
}

compile_cpp_and_run() {
    local executable=`mktemp -t compile_cpp_and_run.XXXXXX`
    trap 'rm -rf $executable'
    $(cpp_compiler) $@ -o $executable && $executable
}

# check if command exists
xexists() {
    test -x "`command -v $1`"
    return $?
}

system_concurrency() {
    case $PLATFORM in
        ("macosx") print `sysctl -n hw.ncpu` ;;
        ("linux") print `nproc` ;;
        (*) print 4 ;;
    esac
}

# Antigen
ADOTDIR=$HOME/.config/antigen
source $RC_ROOT/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle brew
antigen bundle git
antigen bundle z
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen apply

# bind UP and DOWN arrow keys to use history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Vi mode
bindkey -v
## backspace and ^h working even after returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
## ctrl-w removes word backwards
bindkey '^w' backward-kill-word

function zle-line-init zle-keymap-select {
    if [ $KEYMAP = "main" ]; then
        PROMPT_SYMBOL="»"
    else
        PROMPT_SYMBOL="#"
    fi
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Theme
if [ $UID -eq 0 ]; then USER_COLOR="red"; else USER_COLOR="white"; fi
local return_code="%(?..%{$fg[red]%}%? %{$reset_color%})"
collapse_path() {
    $RC_ROOT/collapse-path.py $(pwd | sed -e "s,^$HOME,~,") 35
}

if [ $PLATFORM = "linux" ]; then
    host_part="%2m:"
fi
# %* -- Current time of day in 24-hour format, with seconds.
PROMPT='${return_code}\
%{$FG[008]%}%*%{$reset_color%} \
$host_part\
$(collapse_path) \
$(git_prompt_info)\
%{$fg[$USER_COLOR]%}$PROMPT_SYMBOL %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}±%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="⚡"

# Variables
export EDITOR=vim
export EMAIL="gkuznets@ya.ru"
if [ -f $HOME/.config/email ]; then
    export EMAIL=`cat $HOME/.config/email`
fi
export GOPATH=$HOME/.go
export HOMEBREW_NO_ANALYTICS=1
export LC_ALL="en_US.UTF-8"
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH:$GOPATH/bin:/usr/local/opt/llvm/bin
if [ $PLATFORM = "linux" ]; then
    export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
    export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH
    export PATH=$HOME/.linuxbrew/bin:$HOME/.linuxbrew/opt/go/libexec/bin:$PATH
fi
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/include:$HOME/include
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Aliases
alias -- ++="$(cpp_compiler)"
alias -- +++=compile_cpp_and_run
alias -g ...="../.."
alias c="clear"
(xexists "cargo") && alias cg="cargo"
(xexists "brew") && alias b="brew"
alias e="vim"
alias :e="vim"
alias f="find . -name"
alias g="git --no-pager"
alias gti="git"
alias hd="head -n"
alias m="clear && make -j $(system_concurrency)"
alias md="mkdir"
alias n="ninja -j $(system_concurrency)"
alias o="open"
if xexists "ptpython"; then
    alias p="ptpython"
elif xexists "ipython3"; then
    alias p="ipython3"
else
    alias p="python3"
fi
alias p3="python3"
alias v="view"
(xexists "vagrant") && alias vg="vagrant"
alias wg="wget"

if xexists "gls"; then
    alias ls="gls --color=always -F"
fi
if xexists "grm"; then
    alias rm="grm"
fi

# OPAM configuration
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

[ -f $HOME/.config/local_zshrc ] && . $HOME/.config/local_zshrc

unset cpp_compiler
unset compile_cpp_and_run
unset xexists

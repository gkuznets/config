case `uname` in
    ("Darwin") local PLATFORM="macosx" ;;
    ("Linux") local PLATFORM="linux" ;;
    (*) local PLATFORM="unknown" ;;
esac

local RC_ROOT=$HOME/.config/rc

cpp_compiler() {
    case $PLATFORM in
        ("macosx") print "clang++ --std=c++14" ;;
        ("linux") print "g++ --std=c++14" ;;
        (*) print "c++" ;;
    esac
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

# Theme
if [ $UID -eq 0 ]; then USER_COLOR="red"; else USER_COLOR="white"; fi
local return_code="%(?..%{$fg[red]%}%? %{$reset_color%})"
collapse_path() {
    $RC_ROOT/collapse-path.py $(pwd | sed -e "s,^$HOME,~,") 25
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
%{$fg[$USER_COLOR]%}» %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}±%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="⚡"

# Variables
export EDITOR=vim
export EMAIL="gkuznets@ya.ru"
if [ -f $HOME/.config/email ]; then
    export EMAIL=`cat $HOME/.config/email
fi
export GOPATH=$HOME/.go
export HOMEBREW_NO_ANALYTICS=1
export LC_ALL="en_US.UTF-8"
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH:$GOPATH/bin
if [ $PLATFORM = "linux" ]; then
    export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
    export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH
    export PATH=$HOME/.linuxbrew/bin:$HOME/.linuxbrew/opt/go/libexec/bin:$PATH
fi

# Aliases
alias -- ++="$(cpp_compiler)"
alias -g ...="../.."
alias c="clear"
(xexists "brew") && alias b="brew"
alias e="vim"
alias :e="vim"
alias f="find . -name"
alias g="git"
alias gti="git"
alias m="clear && make -j $(system_concurrency)"
alias md="mkdir"
if xexists "ptpython"; then
    alias p="ptpython"
elif xexists "ipython3"; then
    alias p="ipython3"
else
    alias p="python3"
fi
alias v="vim"

# OPAM configuration
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

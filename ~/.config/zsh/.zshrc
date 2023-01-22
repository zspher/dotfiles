#=== ZINIT ============================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# Enable Zinit completions
source $ZINIT[BIN_DIR]/zinit.zsh \
  && autoload -Uz _zinit \
  && (( ${+_comps} )) \
  && _comps[zinit]=_zinit

#####################
# PROMPT            #
#####################

zinit lucid for \
        as"command" \
        from"gh-r" \
        atinit'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"' atload'eval "$(starship init zsh)"' \
    starship/starship

##########################
# OMZ Libs and Plugins   #
##########################
# IMPORTANT:
# Ohmyzsh plugins and libs are loaded first as some these sets some defaults which are required later on.
# Otherwise something will look messed up
# ie. some settings help zsh-autosuggestions to clear after tab completion
setopt promptsubst
# Explanation:
# 1. Loading tmux first, to prevent jumps when tmux is loaded after .zshrc
# 2. History plugin is loaded early (as it has some defaults) to prevent empty history stack for other plugins

zinit lucid for \
  atinit"HIST_STAMPS=dd.mm.yyyy" \
        OMZL::history.zsh

zinit wait lucid for \
    OMZL::clipboard.zsh \
    OMZL::compfix.zsh \
    OMZL::completion.zsh \
    OMZL::correction.zsh \
    wazum/zsh-directory-dot-expansion \
    OMZL::directories.zsh \
    OMZL::git.zsh \
    OMZL::grep.zsh \
    OMZL::key-bindings.zsh \
    OMZL::spectrum.zsh \
    OMZL::termsupport.zsh \
        atload"alias gcd='gco dev'" \
    OMZP::git \
    OMZP::fzf \
        atload"alias dcupb='docker-compose up --build'" \
    OMZP::docker-compose \
        as"completion" \
    OMZP::docker/_docker \
    djui/alias-tips \
    hlissner/zsh-autopair \
    chriskempson/base16-shell \
        atinit"
            zstyle ':prezto:*:*' color 'yes'
            zstyle ':prezto:module:utility' safe-ops 'no'" \
    PZTM::utility

#####################
# PLUGINS           #
#####################
zinit wait lucid for \
        light-mode atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20" atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
        light-mode atinit"
            typeset -gA FAST_HIGHLIGHT; FAST_HIGHLIGHT[git-cmsg-len]=100;
            zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
        atpull'zinit creinstall -q .' \
        atinit"
            zstyle ':completion:*' completer _expand _complete _ignored _approximate
            zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
            zstyle ':completion:*' menu select=2
            zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
            zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm,cmd -w -w'
            zstyle ':completion:*:descriptions' format '-- %d --'
            zstyle ':completion:*:processes' command 'ps -au$USER'
            zstyle ':completion:complete:*:options' sort false
            zstyle ':fzf-tab:complete:_zlua:*' query-string input
            zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'
            zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap" \
        blockf light-mode \
    zsh-users/zsh-completions \
        atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
            \${P}sed -i \
            '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
            \${P}dircolors -b LS_COLORS > c.zsh" \
        atpull'%atclone' pick"c.zsh" nocompile'!' \
        atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
    trapd00r/LS_COLORS

HISTFILE="$XDG_STATE_HOME"/zsh/history 
HISTSIZE=2000
SAVEHIST=2000

export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"

setopt auto_cd
setopt auto_pushd
cdpath=(. /run/media/$USER/drive2)
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"


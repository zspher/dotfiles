
# Use Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# Enable Zinit completions
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit lucid for \
    as"command" from"gh-r" \
    atinit'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"' \
    atload'eval "$(starship init zsh)"' \
    bpick'*unknown-linux-gnu*' \
    starship/starship 

zinit wait lucid for \
    PZTM::environment \
    PZTM::terminal \
    PZTM::history \
    PZTM::directory \
    PZTM::spectrum \
    atinit"
        zstyle ':prezto:*:*' color 'yes'
        zstyle ':prezto:module:utility' safe-ops 'no'
    "\
      PZTM::utility \
    PZTM::pacman \
    atinit"zstyle ':prezto:module:ssh:load' identities github" \
      PZTM::ssh \
    wazum/zsh-directory-dot-expansion \
    PZTM::gpg

zinit wait lucid for \
    OMZL::key-bindings.zsh \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::fzf \
    djui/alias-tips


zinit wait lucid for \
    light-mode atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20 ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=#3a4d57" atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
    light-mode atinit"
        typeset -gA FAST_HIGHLIGHT;
        FAST_HIGHLIGHT[git-cmsg-len]=100;
        zpcompinit;
        zpcdreplay;
    " \
        zdharma-continuum/fast-syntax-highlighting \
    light-mode blockf atpull'zinit creinstall -q .' \
    atinit"
        zstyle ':completion:*' completer _expand _complete _ignored _approximate
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
        zstyle ':completion:*' menu select=2
        zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
        zstyle ':completion:*:descriptions' format '-- %d --'
        zstyle ':completion:*:processes' command 'ps -au$USER'
        zstyle ':completion:complete:*:options' sort false
        zstyle ':fzf-tab:complete:_zlua:*' query-string input
        zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm,cmd -w -w'
        zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
        zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'
    " \
        zsh-users/zsh-completions \
   reset \
    atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
            \${P}sed -i \
            '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
            \${P}dircolors -b LS_COLORS > c.zsh" \
    atpull'%atclone' pick"c.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
        trapd00r/LS_COLORS

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000

export HOST_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
export DISPLAY="$HOST_IP:0.0"
export NO_AT_BRIDGE=1
export PULSE_SERVER="tcp:$HOST_IP"
export PDFVIEWER='wslview $(wslpath -w %s)'
export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"

setopt auto_cd
cdpath=( /mnt/d/ . ~ )
source "$HOME/.aliases"

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

zinit lucid for \
        atload"
            ZVM_VI_INSERT_ESCAPE_BINDKEY='jj'
            zvm_bindkey vicmd 'K' run-help"\
    "jeffreytse/zsh-vi-mode"

zinit wait lucid for \
        atinit"
            zstyle ':zim:termtitle' format '${SSH_CONNECTION:+%m} %2~'"\
    "zimfw/termtitle" \
        atinit"
            zstyle ':prezto:*:*' color 'yes'
            zstyle ':prezto:module:utility' safe-ops 'no'" \
        atload"
            alias lu='ll --total-size -S'
            alias lm='ll --hyperlink always'
            alias ls='lsd --group-directories-first'
            alias ll='ls -la --date +\"%d %b %y %H:%S\" --size short' \
            alias lc='ll -tr'
            alias lx='ll -X'
            alias lt='ll --tree'
            unset GREP_COLOR"\
    "PZTM::utility" \
        atinit"zstyle ':zim:input' double-dot-expand yes" \
    "zimfw/input" \
    "hlissner/zsh-autopair"

zinit wait lucid for \
        atinit"
            zicompinit;
            zstyle ':fzf-tab:*' switch-group ',' '.'
            zstyle ':fzf-tab:complete:_zlua:*' query-string input"\
        atinit'
            zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'\
    "Aloxaf/fzf-tab"

zinit wait lucid for \
        light-mode atinit"
            ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20" \
        atload"_zsh_autosuggest_start" \
    "zsh-users/zsh-autosuggestions" \
        light-mode atinit"
            typeset -gA FAST_HIGHLIGHT; FAST_HIGHLIGHT[git-cmsg-len]=100;zicdreplay" \
    "zdharma-continuum/fast-syntax-highlighting" \
        atpull'zinit creinstall -q .' \
        atinit"
            zstyle ':completion:*' completer _expand _complete _ignored _approximate
            zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
            zstyle ':completion:*' menu select=2
            zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
            zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm,cmd -w -w'
            zstyle ':completion:*:descriptions' format '[%d]'
            zstyle ':completion:*:processes' command 'ps -au$USER'
            zstyle ':completion:*:*:kill:*' list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=33'
            zstyle ':completion:complete:*:options' sort false" \
        blockf light-mode \
    "zsh-users/zsh-completions"

zinit lucid for "jeffreytse/zsh-vi-mode" 

zinit wait'1a' lucid for \
    "OMZP::fzf" \
    "hlissner/zsh-autopair" \
        atinit"
            zstyle ':zim:termtitle' format '%~'"\
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
            alias lt='ll --tree'"\
    "PZTM::utility" \
        atinit"zstyle ':zim:input' double-dot-expand yes" \
    "zimfw/input"

zinit wait'1b' lucid for \
        atinit"zicompinit; zicdreplay" \
    "zdharma-continuum/fast-syntax-highlighting" \
        atload"_zsh_autosuggest_start" \
    "zsh-users/zsh-autosuggestions" \
        blockf atpull'zinit creinstall -q .' \
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
    "zsh-users/zsh-completions"

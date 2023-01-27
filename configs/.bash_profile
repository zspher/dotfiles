#!/bin/bash
#
# ~/.bash_profile
#

# shellcheck source=/dev/null
[[ -f ~/.bashrc ]] && source ~/.bashrc

# **** xdg dirs **** #
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export XCURSOR_PATH=/usr/share/icons:${XDG_DATA_HOME}/icons 

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export KDEHOME="$XDG_CONFIG_HOME"/kde
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export PLATFORMIO_CORE_DIR="$XDG_DATA_HOME"/platformio
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export HISTFILE="$XDG_STATE_HOME"/zsh/history  

alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"'
export WINEPREFIX="$XDG_DATA_HOME"/wine
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export _Z_DATA="$XDG_DATA_HOME/z"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
# shellcheck disable=SC2016
export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
# shellcheck disable=SC2016
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.vim" | so $MYVIMRC'

export XCURSOR_PATH=/usr/share/icons:${XDG_DATA_HOME}/icons
export PYTHONSTARTUP="/etc/python/pythonrc"
export WAKATIME_HOME="$XDG_CONFIG_HOME"/wakatime
export WINEPREFIX="$XDG_DATA_HOME/wine"
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"
export RANDFILE="$XDG_CONFIG_HOME/openssl/rnd"
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc   
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history 

# **** theming **** #
export BAT_THEME="Catppuccin-mocha"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export GTK_THEME=Catppuccin-Mocha-Compact-Mauve-Dark

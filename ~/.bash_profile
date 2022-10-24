#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# **** xdg dirs **** #
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# export HISTFILE="${XDG_STATE_HOME}"/bash/history # -> ~/.bashrc
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export XCURSOR_PATH=/usr/share/icons:${XDG_DATA_HOME}/icons 

# mv ~/.gitconfig $XDG_CONFIG_HOME/git/config
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
#export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
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

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
export WINEPREFIX="$XDG_DATA_HOME"/wine
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export _Z_DATA="$XDG_DATA_HOME/z"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" : "$XDG_CONFIG_HOME/nvim/init.vim" | so $MYVIMRC'

# export GTK_THEME=Breeze-modified

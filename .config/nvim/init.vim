set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set pumblend=20
set winblend=20

if has('nvim-0.5')
    set noemoji
    lua require("init")
endif

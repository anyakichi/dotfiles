"
" .config.vim:
"       Configuration for vim plugins
"

call plug#begin(expand('~/.vim/bundle'))

Plug 'SirVer/ultisnips'
Plug 'anyakichi/ocp-indent-vim'
Plug 'anyakichi/skk.vim', {'on': '<Plug>(skk-toggle-im)'}
Plug 'anyakichi/taskpaper.vim'
Plug 'anyakichi/vim-circomp'
Plug 'anyakichi/vim-csutil'
Plug 'anyakichi/vim-histsearch'
Plug 'anyakichi/vim-ocp-index'
Plug 'anyakichi/vim-qfutil'
Plug 'anyakichi/vim-surround'
Plug 'anyakichi/vim-tabutil'
Plug 'anyakichi/vim-textobj-ifdef'
Plug 'anyakichi/vim-textobj-kakko'
Plug 'anyakichi/vim-textobj-subword'
Plug 'anyakichi/vim-textobj-xbrackets'
Plug 'benmills/vimux'
Plug 'cohama/agit.vim'
Plug 'eiiches/vim-ref-info'
Plug 'glts/vim-textobj-comment'
Plug 'hashivim/vim-vagrant'
Plug 'honza/vim-snippets'
Plug 'jamessan/vim-gnupg'
Plug 'jason0x43/vim-js-indent'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-fakeclip'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-smartinput'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'leafgarland/typescript-vim'
Plug 'ludovicchabant/vim-lawrencium'
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'sgur/vim-textobj-parameter'
Plug 'sjl/gundo.vim'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-ref'
Plug 'thinca/vim-visualstar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'vim-jp/autofmt'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'vim-scripts/DrawIt'
Plug 'vim-scripts/Mark--Karkat'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/moria'
Plug 'vim-scripts/vcscommand.vim', {'on': '<Plug>VCSVimDiff'}
Plug 'will133/vim-dirdiff'

if !has('patch-8.1.360')
    Plug 'lambdalisue/vim-unified-diff'
endif

call plug#end()

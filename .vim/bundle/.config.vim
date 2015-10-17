"
" dot.config.vim:
"       Configuration for vim bundle directory
"

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

map [Space]<Space> [Load]
nnoremap [Load] <Nop>

try
    call neobundle#begin(expand('~/.vim/bundle'))

    NeoBundleFetch 'Shougo/neobundle.vim'

    NeoBundle 'DrawIt'
    NeoBundle 'Mark--Karkat'
    NeoBundle 'a.vim'
    NeoBundle 'moria'
    NeoBundle 'utl.vim'

    NeoBundle 'http://repo.or.cz/r/vcscommand.git', '', 'http'
    NeoBundle 'FromtonRouge/OmniCppComplete'
    NeoBundle 'Shougo/vimproc', {'build': 'make'}
    NeoBundle 'SirVer/ultisnips'
    NeoBundle 'anyakichi/ocp-indent-vim'
    NeoBundle 'anyakichi/taskpaper.vim'
    NeoBundle 'anyakichi/vim-autoclose'
    NeoBundle 'anyakichi/vim-circomp'
    NeoBundle 'anyakichi/vim-csutil'
    NeoBundle 'anyakichi/vim-histsearch'
    NeoBundle 'anyakichi/vim-ocp-index'
    NeoBundle 'anyakichi/vim-qfutil'
    NeoBundle 'anyakichi/vim-surround'
    NeoBundle 'anyakichi/vim-tabutil'
    NeoBundle 'anyakichi/vim-textobj-ifdef'
    NeoBundle 'anyakichi/vim-textobj-kakko'
    NeoBundle 'anyakichi/vim-textobj-subword'
    NeoBundle 'anyakichi/vim-textobj-xbrackets'
    NeoBundle 'benmills/vimux'
    NeoBundle 'chriskempson/vim-tomorrow-theme'
    NeoBundle 'cohama/agit.vim'
    NeoBundle 'h1mesuke/unite-outline'
    NeoBundle 'h1mesuke/vim-alignta'
    NeoBundle 'honza/vim-snippets'
    NeoBundle 'jamessan/vim-gnupg'
    NeoBundle 'jason0x43/vim-js-indent'
    NeoBundle 'kana/vim-fakeclip'
    NeoBundle 'kana/vim-operator-user'
    NeoBundle 'kana/vim-textobj-indent'
    NeoBundle 'kana/vim-textobj-user'
    NeoBundle 'lambdalisue/vim-unified-diff'
    NeoBundle 'leafgarland/typescript-vim'
    NeoBundle 'ludovicchabant/vim-lawrencium'
    NeoBundle 'mattn/calendar-vim'
    NeoBundle 'scrooloose/nerdcommenter'
    NeoBundle 'sjl/gundo.vim'
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'thinca/vim-ref'
    NeoBundle 'thinca/vim-textobj-comment'
    NeoBundle 'thinca/vim-visualstar'
    NeoBundle 'tpope/vim-capslock'
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'tpope/vim-repeat'
    NeoBundle 'vim-jp/autofmt'
    NeoBundle 'w0ng/vim-hybrid'
    NeoBundle 'will133/vim-dirdiff'

    NeoBundleLazy 'anyakichi/csapprox', 'performance-tuning',
    \             {'autoload': {'commands': ['CSApprox']}}
    NeoBundleLazy 'anyakichi/skk.vim',{'autoload': {'functions': ['SkkToggle']}}
    NeoBundleLazy 'Shougo/unite.vim', {'autoload': {'commands': ['Unite']}}

    call neobundle#end()
catch
    " echo 'Install neobundle.vim to get plugins'
endtry

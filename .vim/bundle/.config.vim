"
" dot.config.vim:
"	Configuration for vim bundle directory
"

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

map [Space]<Space> [Load]
nnoremap [Load] <Nop>

let g:neobundle#types#git#default_protocol = 'https'

try
    call neobundle#begin(expand('~/.vim/bundle'))

    NeoBundleFetch 'https://github.com/Shougo/neobundle.vim.git'

    NeoBundle 'DirDiff.vim'
    NeoBundle 'DrawIt'
    NeoBundle 'Mark--Karkat'
    NeoBundle 'OmniCppComplete'
    NeoBundle 'VisIncr'
    NeoBundle 'a.vim'
    NeoBundle 'capslock.vim'
    NeoBundle 'moria'
    NeoBundle 'utl.vim'

    NeoBundle 'http://repo.or.cz/r/vcscommand.git', '', 'http'
    NeoBundle 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
    NeoBundle 'https://github.com/Shougo/vimproc.git',
    NeoBundle 'https://github.com/anyakichi/ocp-indent-vim.git'
    NeoBundle 'https://github.com/anyakichi/taskpaper.vim.git'
    NeoBundle 'https://github.com/anyakichi/vim-autoclose'
    NeoBundle 'https://github.com/anyakichi/vim-circomp'
    NeoBundle 'https://github.com/anyakichi/vim-csutil'
    NeoBundle 'https://github.com/anyakichi/vim-histsearch'
    NeoBundle 'https://github.com/anyakichi/vim-ocp-index'
    NeoBundle 'https://github.com/anyakichi/vim-qfutil'
    NeoBundle 'https://github.com/anyakichi/vim-surround.git'
    NeoBundle 'https://github.com/anyakichi/vim-tabutil'
    NeoBundle 'https://github.com/anyakichi/vim-textobj-ifdef'
    NeoBundle 'https://github.com/anyakichi/vim-textobj-kakko'
    NeoBundle 'https://github.com/anyakichi/vim-textobj-subword'
    NeoBundle 'https://github.com/anyakichi/vim-textobj-xbrackets'
    NeoBundle 'https://github.com/benmills/vimux.git'
    NeoBundle 'https://github.com/chriskempson/vim-tomorrow-theme.git'
    NeoBundle 'https://github.com/cohama/agit.vim'
    NeoBundle 'https://github.com/garbas/vim-snipmate.git'
    NeoBundle 'https://github.com/h1mesuke/vim-alignta.git'
    NeoBundle 'https://github.com/jamessan/vim-gnupg.git'
    NeoBundle 'https://github.com/jason0x43/vim-js-indent.git'
    NeoBundle 'https://github.com/kana/vim-fakeclip.git'
    NeoBundle 'https://github.com/kana/vim-operator-user.git'
    NeoBundle 'https://github.com/kana/vim-textobj-indent.git'
    NeoBundle 'https://github.com/kana/vim-textobj-user.git'
    NeoBundle 'https://github.com/leafgarland/typescript-vim.git'
    NeoBundle 'https://github.com/ludovicchabant/vim-lawrencium.git'
    NeoBundle 'https://github.com/mattn/calendar-vim.git'
    NeoBundle 'https://github.com/scrooloose/nerdcommenter.git'
    NeoBundle 'https://github.com/sjl/gundo.vim.git'
    NeoBundle 'https://github.com/thinca/vim-quickrun.git'
    NeoBundle 'https://github.com/thinca/vim-ref.git'
    NeoBundle 'https://github.com/thinca/vim-textobj-comment.git'
    NeoBundle 'https://github.com/thinca/vim-visualstar.git'
    NeoBundle 'https://github.com/tomtom/tlib_vim.git'
    NeoBundle 'https://github.com/tpope/vim-fugitive.git'
    NeoBundle 'https://github.com/tpope/vim-repeat.git'
    NeoBundle 'https://github.com/vim-jp/autofmt.git'
    NeoBundle 'https://github.com/w0ng/vim-hybrid.git'

    NeoBundleLazy 'https://github.com/anyakichi/csapprox.git',
    \             'performance-tuning',
    \             {'autoload': {'commands': ['CSApprox']}}


    NeoBundleLazy 'https://github.com/Shougo/unite.vim.git',
    \             {'autoload': {'commands': ['Unite']}}
    NeoBundle 'https://github.com/h1mesuke/unite-outline.git'

    NeoBundleLazy 'https://github.com/anyakichi/skk.vim.git',
    \             {'autoload': {'functions': ['SkkToggle']}}

    call neobundle#end()
catch
    " echo 'Install neobundle.vim to get plugins'
endtry

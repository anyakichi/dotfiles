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

let g:neobundle#default_options = {
\   'hg': { 'type': 'hg' },
\   'http': { 'type__shallow': 0 },
\}

try
    call neobundle#rc(expand('~/.vim/bundle'))

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
    NeoBundle 'https://github.com/Shougo/vimproc.git',
    NeoBundle 'https://github.com/anyakichi/csapprox.git', 'performance-tuning'
    NeoBundle 'https://github.com/anyakichi/ocp-indent-vim.git'
    NeoBundle 'https://github.com/anyakichi/taskpaper.vim.git'
    NeoBundle 'https://github.com/anyakichi/vim-surround.git'
    NeoBundle 'https://github.com/benmills/vimux.git'
    NeoBundle 'https://github.com/h1mesuke/vim-alignta.git'
    NeoBundle 'https://github.com/jamessan/vim-gnupg.git'
    NeoBundle 'https://github.com/kana/vim-fakeclip.git'
    NeoBundle 'https://github.com/kana/vim-operator-user.git'
    NeoBundle 'https://github.com/kana/vim-textobj-indent.git'
    NeoBundle 'https://github.com/kana/vim-textobj-user.git'
    NeoBundle 'https://github.com/mattn/calendar-vim.git'
    NeoBundle 'https://github.com/scrooloose/nerdcommenter.git'
    NeoBundle 'https://github.com/thinca/vim-quickrun.git'
    NeoBundle 'https://github.com/thinca/vim-textobj-comment.git'
    NeoBundle 'https://github.com/tpope/vim-repeat.git'
    NeoBundle 'https://github.com/vim-jp/autofmt.git'

    NeoBundle 'https://bitbucket.org/anyakichi/vim-autoclose'
    NeoBundle 'https://bitbucket.org/anyakichi/vim-circomp'
    NeoBundle 'https://bitbucket.org/anyakichi/vim-csutil'
    NeoBundle 'https://bitbucket.org/anyakichi/vim-histsearch'
    NeoBundle 'https://bitbucket.org/anyakichi/vim-qfutil'
    NeoBundle 'https://bitbucket.org/anyakichi/vim-tabutil'
    NeoBundle 'https://bitbucket.org/anyakichi/vim-textobj-ifdef'
    NeoBundle 'https://bitbucket.org/anyakichi/vim-textobj-subword'
    NeoBundle 'https://bitbucket.org/anyakichi/vim-textobj-xbrackets'
    NeoBundle 'https://bitbucket.org/sjl/gundo.vim', '', 'hg'
    NeoBundle 'https://www.sopht.jp/repos/hg/snipmate.vim', '', 'hg'
    NeoBundle 'https://www.sopht.jp/repos/hg/vim-ref'
    NeoBundle 'https://www.sopht.jp/repos/hg/vim-textobj-kakko'
    NeoBundle 'https://www.sopht.jp/repos/hg/vimwiki'

    NeoBundleLazy 'https://github.com/Shougo/unite.vim.git',
    \             {'autoload': {'commands': ['Unite']}}
    NeoBundle 'https://github.com/h1mesuke/unite-outline.git'

    NeoBundleLazy 'https://github.com/anyakichi/skk.vim.git',
    \             {'autoload': {'functions': ['SkkToggle']}}
catch
    " echo 'Install neobundle.vim to get plugins'
endtry

if has('nvim')
    let s:plug_vim_path = stdpath('data') . '/site/autoload/plug.vim'
    let s:plug_dir = stdpath('data') . '/plugged'
else
    let s:plug_vim_path = expand('~/.vim/autoload/plug.vim')
    let s:plug_dir = expand('~/.vim/bundle')
endif

function s:bootstrap()
    silent execute '!curl -fLo ' . s:plug_vim_path . ' --create-dirs
    \   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo 'vim-plug has been installed'
endfunction

command! -nargs=0 -bar PlugBootstap call s:bootstrap()

if !filereadable(s:plug_vim_path)
    finish
endif

call plug#begin(s:plug_dir)

Plug 'SirVer/ultisnips'
Plug 'anyakichi/skk.vim', {'on': '<Plug>(skk-toggle-im)'}
Plug 'anyakichi/vim-circomp'
Plug 'anyakichi/vim-csutil'
Plug 'anyakichi/vim-qfutil'
Plug 'anyakichi/vim-surround'
Plug 'anyakichi/vim-tabutil'
Plug 'anyakichi/vim-textobj-ifdef'
Plug 'anyakichi/vim-textobj-kakko'
Plug 'anyakichi/vim-textobj-subword'
Plug 'anyakichi/vim-textobj-xbrackets'
Plug 'benmills/vimux'
Plug 'eiiches/vim-ref-info'
Plug 'glts/vim-textobj-comment'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-vagrant'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
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
Plug 'mbbill/undotree'
Plug 'mhartington/oceanic-next'
Plug 'peitalin/vim-jsx-typescript'
Plug 'plasticboy/vim-markdown'
Plug 'prabirshrestha/async.vim'
Plug 'previm/previm'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'rescript-lang/vim-rescript'
Plug 'rust-lang/rust.vim'
Plug 'sbdchd/neoformat'
Plug 'sgur/vim-textobj-parameter'
Plug 't9md/vim-quickhl'
Plug 'thinca/vim-quickrun'
Plug 'thinca/vim-ref'
Plug 'thinca/vim-visualstar'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tyru/open-browser.vim'
Plug 'vim-jp/autofmt'
Plug 'vim-jp/vital.vim'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'vim-scripts/DrawIt'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/vcscommand.vim', {'on': '<Plug>VCSVimDiff'}
Plug 'will133/vim-dirdiff'

if has('nvim-0.5')
    Plug 'ckipp01/stylua-nvim'
    Plug 'hrsh7th/nvim-compe'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/lsp-status.nvim'
else
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/vim-lsp'
endif

if !has('nvim') && !has('patch-8.1.360')
    Plug 'lambdalisue/vim-unified-diff'
endif

call plug#end()

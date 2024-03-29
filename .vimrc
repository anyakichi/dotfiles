scriptencoding utf-8

let s:plug_vim_path = expand('~/.vim/autoload/plug.vim')
let s:plug_dir = expand('~/.local/share/vim/plugged')

function s:bootstrap()
    silent execute '!curl -fLo ' . s:plug_vim_path . ' --create-dirs
    \   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo 'vim-plug has been installed'
endfunction

command! -nargs=0 -bar PlugBootstrap call s:bootstrap()

if filereadable(s:plug_vim_path)
    call plug#begin(s:plug_dir)

    Plug 'AndrewRadev/linediff.vim'
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'andymass/vim-matchup'
    Plug 'anyakichi/vim-csutil'
    Plug 'anyakichi/vim-qfutil'
    Plug 'anyakichi/vim-surround'
    Plug 'anyakichi/vim-tabutil'
    Plug 'anyakichi/vim-textobj-ifdef'
    Plug 'anyakichi/vim-textobj-kakko'
    Plug 'anyakichi/vim-textobj-subword'
    Plug 'anyakichi/vim-textobj-xbrackets'
    Plug 'chrisbra/csv.vim'
    Plug 'github/copilot.vim'
    Plug 'glts/vim-textobj-comment'
    Plug 'haya14busa/vim-edgemotion'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'itchyny/lightline.vim'
    Plug 'jamessan/vim-gnupg'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'kana/vim-operator-user'
    Plug 'kana/vim-smartinput'
    Plug 'kana/vim-textobj-indent'
    Plug 'kana/vim-textobj-user'
    Plug 'lambdalisue/suda.vim'
    Plug 'machakann/vim-swap'
    Plug 'mattn/vim-lsp-settings'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'mbbill/undotree'
    Plug 'mhartington/oceanic-next'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'previm/previm'
    Plug 'rafamadriz/friendly-snippets'
    Plug 'rescript-lang/vim-rescript'
    Plug 'rust-lang/rust.vim'
    Plug 'sgur/vim-textobj-parameter'
    Plug 't9md/vim-quickhl'
    Plug 'thinca/vim-partedit'
    Plug 'thinca/vim-quickrun'
    Plug 'thinca/vim-ref'
    Plug 'thinca/vim-visualstar'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tyru/capture.vim'
    Plug 'tyru/open-browser.vim'
    Plug 'vim-jp/autofmt'
    Plug 'vim-jp/vital.vim'
    Plug 'vim-scripts/DoxygenToolkit.vim'
    Plug 'vim-scripts/DrawIt'
    Plug 'voldikss/vim-translator'
    Plug 'will133/vim-dirdiff'
    Plug 'yuezk/vim-js'

    if !has('patch-8.1.360')
        Plug 'lambdalisue/vim-unified-diff'
    endif

    call plug#end()
endif


"
" Options
"
set backspace=indent,eol,start
set tabpagemax=50

set laststatus=2
set showcmd

set display=lastline
set lazyredraw
set notitle

set tags=./tags;,tags

if $COLORTERM ==# "truecolor"
    let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
    let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

    " Undercurl should be supported on modern terminals which support true
    " colors.
    let &t_Cs = "\e[4:3m\e[58;5;9m"
    let &t_Ce = "\e[4:0m\e[59m"
endif

set history=10000
set wildmenu

set directory=~/.local/share/vim/swap//
set undodir=~/.local/share/vim/undo//
silent !mkdir -p ~/.local/share/vim/swap ~/.local/share/vim/undo

set timeout
set ttimeoutlen=50

silent! set formatoptions+=j

source $VIMRUNTIME/macros/matchit.vim


" Encodings
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,euc-jp,cp932,iso-2022-jp,utf-16,ucs-2le,ucs-2

" Indentation
set autoindent
set expandtab
set shiftround
set shiftwidth=4
set smartindent
set softtabstop=0
set tabstop=8
set cinoptions=>2s,e0,n0,f0,{0,}0,^0,:0,=2s,l1,b0,g2s,h2s,p2s,t0,
              \i2s,+1s,c1s,C0,/0,(0,u0,U0,w1,W0,m1,j1,)20,*30

" Searching
set nohlsearch
set ignorecase
set incsearch
set smartcase

" Formatting
set formatoptions+=rolmB
set textwidth=78

" Completion
set complete=.,w,b,u
set completeopt=menuone
set pumheight=10

" Appearance
set background=dark
set colorcolumn=81
set cursorline

" True colors
if $COLORTERM ==# "truecolor"
    set termguicolors
endif

" Diff
set diffopt+=vertical
let &diffopt .= ',indent-heuristic,algorithm:histogram'

" Folding
set nofoldenable

" Command line
set wildmode=longest,list,full

" Visual mode
set virtualedit=block

" Buffer
set hidden

" Window
set splitbelow
set splitright
set winminheight=0

" Backup and swap
set nobackup
set undofile

" Mappings
set cedit=<C-x>
set pastetoggle=<C-q>

" Spell checking
set spelllang=en_us,cjk

" Cscope
if has('cscope')
    if executable('gtags-cscope')
        set cscopeprg=gtags-cscope
    endif
    set cscopetag
    set cscopetagorder=0
    silent! set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
endif

set guicursor=i-ci-ve:ver25,r-cr-o:hor20
set mouse=a

filetype plugin indent on


let g:lightline = {
\   'active': {
\       'left': [
\           ['mode', 'paste'],
\           ['readonly', 'relativepath', 'modified'],
\           ['lspstatus']
\       ],
\       'right': [
\           ['lineinfo'],
\           ['percent'],
\           ['fileformat', 'fileencoding', 'filetype', 'lspinfo']
\       ]
\   },
\   'inactive': {
\       'left': [['readonly', 'relativepath', 'modified']],
\       'right': [['lineinfo'], ['percent']]
\   },
\   'component': {
\       'fileencoding': '%{substitute(&fenc, "^utf-8$", "", "")}',
\       'fileformat': '%{&ff ==# "unix" ? "" : &ff}',
\       'filetype': '%{&ft}',
\       'lspstatus': '%<%{LspStatus()}',
\   },
\   'component_visible_condition': {
\       'fileencoding': '&fenc != "utf-8"',
\       'fileformat': '&ff != "unix"',
\       'filetype': '&ft != ""',
\   },
\   'tabline': {
\       'left': [['tabs']],
\       'right': []
\   },
\}


"
" Syntax coloring
"
augroup MyColorScheme
    autocmd!

    autocmd ColorScheme OceanicNext
    \   highlight! Normal guifg=#c0c5ce guibg=#1b2b34
    \|  highlight! Statement gui=NONE
    \|  highlight! link Conditional Statement
    \|  highlight! link Repeat Statement
    \|  highlight! link Label Statement
    \|  highlight! link Keyword Statement
    \|  highlight! link Exception Statement
    \|  highlight! PreProc guifg=#c594c5
    \|  highlight! link Include PreProc
    \|  highlight! link Define PreProc
    \|  highlight! link Macro PreProc
    \|  highlight! link PreCondit PreProc
    \|  highlight! Error guifg=bg guibg=#ec5f67
    \|  highlight! Todo guifg=bg guibg=#fac863
    \|  highlight! LspInformationText gui=inverse
    \|  highlight! SpellBad guisp=#ec5f67
    \|  highlight! Spelllocal guisp=#5fb3b3
    \|  highlight! SpellCap guisp=#6699cc
    \|  highlight! SpellRare guisp=#c594c5
    \|  highlight! link mailHeaderKey Constant

    autocmd ColorScheme base16-*
    \   highlight! Statement gui=NONE
    \|  highlight! link Conditional Statement
    \|  highlight! link Repeat Statement
    \|  highlight! link Label Statement
    \|  highlight! link Keyword Statement
    \|  highlight! link Exception Statement
    \|  highlight! Folded gui=italic
    \|  highlight! Comment gui=italic
    \|  execute 'highlight! Identifier guifg=#' . g:base16_gui0C
    \|  execute 'highlight! PreProc guifg=#' . g:base16_gui0E
    \|  highlight! link Include PreProc
    \|  highlight! link Macro PreProc
    \|  highlight! link Structure Type
augroup END

syntax on

let g:lightline.colorscheme = 'oceanicnext'
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext


"
" Mappings
"
let g:maplocalleader = "[Space]"
map <Space> [Space]
noremap [Space] <Nop>

nmap t [Tab]
nnoremap [Tab] <Nop>
nnoremap [Tab]; t

nnoremap <C-g> <Nop>
nnoremap <C-g><C-g> <C-g>

nnoremap Y y$
nnoremap ZQ <Nop>
nnoremap ZZ <Nop>

noremap j gj
noremap k gk
noremap gj j
noremap gk k

nnoremap dP "_ddP

cnoremap <silent> <expr> <CR>
\        getcmdtype() == '/' ? "\<CR>:set hlsearch\<CR>" : "\<CR>"
nnoremap <silent> * *:set hlsearch<CR>
nnoremap <silent> # #:set hlsearch<CR>
nnoremap <silent> g* g*:set hlsearch<CR>
nnoremap <silent> g# g#:set hlsearch<CR>
nnoremap <silent> <Esc><Esc> :<C-u>set nohlsearch<CR>

nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap <silent> g<C-n> :<C-u>tablast<CR>
nnoremap <silent> g<C-p> :<C-u>tabfirst<CR>
nmap <C-g><C-n> g<C-n>
nmap <C-g><C-p> g<C-p>

nnoremap <silent> [Tab]a :<C-u>tabs<CR>

nnoremap <silent> [Tab]b :<C-u>call tabutil#buffer(v:count1)<CR>
nnoremap <silent> [Tab]n :<C-u>call tabutil#bnext(v:count1)<CR>
nnoremap <silent> [Tab]p :<C-u>call tabutil#bprevious(v:count1)<CR>
nnoremap <silent> [Tab]x :<C-u>quit<CR>
nnoremap <silent> [Tab]D :<C-u>bdelete<CR>
nmap [Tab]g [Tab]b

nnoremap <silent> [Tab]l :<C-u>call tabutil#move(v:count1)<CR>
nnoremap <silent> [Tab]h :<C-u>call tabutil#move(-v:count1)<CR>
nnoremap <silent> [Tab]L :<C-u>tabmove<CR>
nnoremap <silent> [Tab]H :<C-u>tabmove 0<CR>
nnoremap <silent> <expr> [Tab]M ":\<C-u>tabmove " . v:count . "\<CR>"

nnoremap [Tab]o :<C-u>Files<Space>
nnoremap [Tab]t :<C-u>TFiles<Space>
nnoremap [Tab]s :<C-u>SFiles<Space>
nnoremap [Tab]v :<C-u>VFiles<Space>
nmap <expr> [Tab]O "[Tab]o" . <SID>relpath()
nmap <expr> [Tab]T "[Tab]t" . <SID>relpath()
nmap <expr> [Tab]S "[Tab]s" . <SID>relpath()
nmap <expr> [Tab]V "[Tab]v" . <SID>relpath()

nnoremap <silent> [Tab]d :<C-u>call <SID>tabclose()<CR>
nnoremap <silent> [Tab]q :<C-u>call tabutil#only()<CR>
nnoremap <silent> [Tab]u :<C-u>call tabutil#undo()<CR>
nnoremap <silent> [Tab]U :<C-u>call tabutil#undoall()<CR>

nnoremap <silent> [Tab]<C-t> :<C-u>call tabutil#split()<CR>
nnoremap <silent> [Tab]<C-s> :<C-u>call tabutil#wsplit()<CR>
nnoremap <silent> [Tab]<C-v> :<C-u>call tabutil#vsplit()<CR>
nmap [Tab]m [Tab]<C-t>

nnoremap <silent> [Tab]r :<C-u>call tabutil#reorganize()<CR>
nnoremap <silent> [Tab]R :<C-u>call tabutil#reorganize1()<CR>

nnoremap <silent> [Tab]] :<C-u>tab tag <C-r><C-w><CR>
nnoremap <silent> [Tab]; :<C-u>tab tjump <C-r><C-w><CR>
nnoremap <silent> [Tab]<CR> :<C-u>tab wincmd <C-v><CR><CR>
nnoremap [Tab]f <C-w>gf
nnoremap [Tab]F <C-w>gF

nnoremap [Tab]c <C-w>c
nnoremap <Esc>h <C-w>h
nnoremap <Esc>j <C-w>j
nnoremap <Esc>k <C-w>k
nnoremap <Esc>l <C-w>l

nnoremap Q q
nnoremap q <Nop>

nnoremap q: q:
nnoremap q/ q/
nnoremap q? q?

" Quickfix
nnoremap <silent> q\ :<C-u>call qfutil#toggle()<CR>

nnoremap <silent> g<C-j> :<C-u>call qfutil#last(v:count)<CR>
nnoremap <silent> g<C-k> :<C-u>call qfutil#first(v:count)<CR>
nmap <C-g><C-j> g<C-j>
nmap <C-g><C-k> g<C-k>

nnoremap <silent> q. :<C-u>call qfutil#toggle_window()<CR>
nnoremap <silent> qq :<C-u>call qfutil#qq(v:count)<CR>
nnoremap <silent> qn :<C-u>call qfutil#nfile(v:count)<CR>
nnoremap <silent> qp :<C-u>call qfutil#pfile(v:count)<CR>
nnoremap <silent> qa :<C-u>call qfutil#list()<CR>
nnoremap <silent> qo :<C-u>call qfutil#older(v:count)<CR>
nnoremap <silent> qi :<C-u>call qfutil#newer(v:count)<CR>

nnoremap <silent> <expr> qM qfutil#make()
nnoremap qm :<C-u>QFMake<Space>
nnoremap qg :<C-u>QFGrep<Space>
nnoremap qcs :<C-u>QFCscope find s<Space>
nnoremap qcg :<C-u>QFCscope find g<Space>
nnoremap qcd :<C-u>QFCscope find d<Space>
nnoremap qcc :<C-u>QFCscope find c<Space>
nnoremap qct :<C-u>QFCscope find t<Space>
nnoremap qce :<C-u>QFCscope find e<Space>
nnoremap qcf :<C-u>QFCscope find f<Space>
nnoremap qci :<C-u>QFCscope find i<Space>
nnoremap qca :<C-u>QFCscope find a<Space>

nnoremap <silent> q] :<C-u>call qfutil#ltag()<CR>

nnoremap <silent> + :<C-u>RegSave +<CR>

" Cscope
nmap <C-\><C-\> <Plug>(csutil-toggle-csto)

for s:type in ['s', 'g', 'd', 'c', 't', 'e']
    let s:mapping = '<C-\>' . s:type
    let s:target = ':<C-u>call csutil#find("<cword>", "' . s:type .
    \                                      '", qfutil#_mode())<CR>'
    execute 'nnoremap' '<silent>' s:mapping s:target
endfor

for s:type in ['f', 'i']
    let s:mapping = '<C-\>' . s:type
    let s:target = ':<C-u>call csutil#find("<cfile>", "' . s:type .
    \                                      '", qfutil#_mode())<CR>'
    execute 'nnoremap' '<silent>' s:mapping s:target
endfor
unlet s:type s:mapping s:target

onoremap a9 a(
onoremap i9 i(
onoremap a0 a{
onoremap i0 i{
onoremap a, a<
onoremap i, i<

try
    call operator#user#define_ex_command('sort', 'sort')
catch
endtry
map [Space]s <Plug>(operator-sort)

nnoremap <silent> [Space]<C-]> <C-]>
nnoremap <silent> [Space]/ :<C-u>set hlsearch! hlsearch?<CR>
nnoremap <silent> [Space]z :<C-u>call <SID>toggle_spell()<CR>
nnoremap <silent> [Space]Z :<C-u>let b:spell = -1<CR>
nnoremap <silent> [Space]V :<C-u>edit $HOME/.vimrc<CR>
nnoremap <silent> [Space]v :<C-u>source $HOME/.vimrc<CR>
nnoremap <silent> [Space]c :<C-u>call <SID>toggle_cc()<CR>
nnoremap <silent> [Space]<Tab> :<C-u>HlAnnoyingSpaceToggle<CR>
nnoremap [Space]= `[=`]

" Insert and command mode mappings
noremap! <C-a> <Home>
noremap! <C-b> <Left>
noremap! <C-f> <Right>

inoremap <C-u> <C-g>u<C-u>
inoremap <expr> <C-w> pumvisible() ? <SID>p_ctrl_w() : "\<C-g>u" . <SID>ctrl_w()

inoremap <expr> <C-j> pumvisible() ? "\<Down>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<Up>" : "\<C-k>"
inoremap <expr> <C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr> <C-b> pumvisible() ? "\<PageUp>" : "\<Left>"
inoremap <expr> <C-a> pumvisible() ? "\<C-a>" : "\<Home>"
inoremap <expr> <C-e> pumvisible() ? "\<C-e>" : "\<End>"
inoremap <expr> <C-y> pumvisible() ? "\<C-y>"
\                                  : <SID>insert_word_from_line(line('.') - 1)
inoremap <expr> <C-_> <SID>compkey("\<C-x>\<C-f>")

inoremap <C-g><C-l> <C-o>b<C-o>g~w<C-o>w<Right>
inoremap <C-g>L <C-o>b<C-o>gUw<C-o>w<Right>
inoremap <C-g>l <C-o>b<C-o>guw<C-o>w<Right>

inoremap <expr> <C-g>= <SID>border_line('=')
inoremap <expr> <C-g>- <SID>border_line('-')
inoremap <expr> <C-g>~ <SID>border_line('~')
inoremap <expr> <C-g>^ <SID>border_line('^')
inoremap <expr> <C-g>" <SID>border_line('"')

cnoremap <C-n> <PageDown>
cnoremap <C-p> <PageUp>
cnoremap <C-g> <C-r>=<SID>kill_arg()<CR>
cnoremap <expr> <C-_> <SID>relpath()

" Comma separated numbers
nnoremap <silent> <C-g>, :<C-u>call <SID>separate_number_with_comma_n()<CR>
inoremap <expr> <C-g>, <SID>separate_number_with_comma_i()

tnoremap <C-\><C-f> <C-\><C-n>:call nvim_win_set_width(0, &columns)<CR>i


"
" Auto commands
"
augroup MyAutoCmd
    autocmd!

    " Cursor line
    autocmd WinLeave *                  setlocal nocursorline
    autocmd WinEnter,BufRead *          setlocal cursorline

    " Window resize
    autocmd VimResized *                wincmd =

    " Fix up settings after loading all plugins
    autocmd VimEnter *                  call s:vim_enter_hook()

    " Open the quickfix window automatically
    autocmd QuickFixCmdPost [^l]*       cwindow | let g:qfutil_mode = 'c'
    autocmd QuickFixCmdPost l*          lwindow | let g:qfutil_mode = 'l'

    " Additional settings for each file type
    autocmd FileType c,go,help          setlocal noet
    autocmd FileType css,docbk,eruby,html,javascript,javascriptreact,json,
                    \markdown,ocaml,reason,rescript,rst,ruby,scheme,scss,
                    \tex,typescript,typescriptreact,xhtml,xml,yaml
    \   setlocal sw=2
    autocmd FileType asciidoc,gitcommit,mail,markdown,rst,tex,text
    \   setlocal tw=72 | let b:spell = -1
    autocmd FileType go                 setlocal ts=4
    autocmd FileType markdown           setlocal fo+=or | nmap [Space]p vi~[Space]p
    autocmd FileType python             setlocal fo-=t sts=0

    " Spell checking
    autocmd InsertEnter * let &l:spell = !!get(b:, 'spell', 0)
    autocmd InsertLeave * let &l:spell = !(get(b:, 'spell', 0) - 1)

    " View PDF in Vim.
    autocmd BufReadPost *pdf silent %!pdftotext -nopgbrk -layout "%" -
augroup END

if !has('nvim-0.5')
    augroup MyAutoCmd
        " Use syntax complete
        autocmd Filetype *
        \   if &omnifunc == ""
        \|      setlocal omnifunc=syntaxcomplete#Complete
        \|  endif

        " LSP
        autocmd CompleteChanged *
        \   if (type(v:event) == v:t_string && v:event == '') ||
        \      (type(v:event) == v:t_dict && get(v:event['completed_item'], 'word', '') == '')
        \|      inoremap <buffer> <expr> <CR> "\<C-e>\<CR>"
        \|      inoremap <buffer> <expr> <C-e> "\<End>"
        \|  else
        \|      silent! iunmap <buffer> <CR>
        \|      silent! iunmap <buffer> <C-e>
        \|  endif

        autocmd CompleteDone *
        \   silent! iunmap <buffer> <CR>
        \|  silent! iunmap <buffer> <C-e>

        autocmd User lsp_buffer_enabled call s:lsp_setup()
        autocmd User lsp_diagnostics_updated call lightline#update()
    augroup END
endif


"
" Plugins
"

" vital.vim
let s:V = vital#vital#new()
call s:V.load('Vim.ScriptLocal')

" autofmt.vim
set formatexpr=autofmt#japanese#formatexpr()
let g:autofmt_allow_over_tw = 2

" edgemotion.vim
nnoremap <C-j> <Plug>(edgemotion-j)
nnoremap <C-k> <Plug>(edgemotion-k)

" fzf
let s:FZF_SID_PREFIX = "<SNR>".s:V.Vim.ScriptLocal.sid("autoload/fzf/vim.vim")."_"
let s:fzf_state = tempname()
let $FZF_STATE = s:fzf_state

let g:fzf_action = {
\   'ctrl-t': 'tab split',
\   'ctrl-v': 'vsplit',
\}
let g:fzf_buffers_jump = 1
let g:fzf_files_options = [
\   '--ansi',
\   "--header-lines", "1",
\   "--bind", "ctrl-d:reload(fzf-file change-directory && fzf-file list)",
\   "--bind", "ctrl-r:reload(fzf-file cycle-restricted && fzf-file list)",
\   "--bind", "ctrl-s:reload(fzf-file up-directory && fzf-file list)",
\   "--bind", "ctrl-x:reload(fzf-file cycle-type && fzf-file list)",
\   "--bind", "ctrl-/:toggle-preview",
\   "--preview", 'fzf-file view {} | head -500',
\   "--preview-window", "hidden"
\]
let g:fzf_preview_window = ['hidden,right,50%,<70(down,40%)', 'ctrl-/']

command! -bar -bang -range=% Commits let b:fzf_winview = winsaveview() | <line1>,<line2>call s:fzf_commits(0, fzf#vim#with_preview({ "placeholder": "" }), <bang>0)
command! -bar -bang -range=% BCommits let b:fzf_winview = winsaveview() | <line1>,<line2>call s:fzf_commits(1, fzf#vim#with_preview({ "placeholder": "" }), <bang>0)
command! -bang -nargs=* -complete=file Files call s:fzf_xfiles("edit", <bang>0, <f-args>)
command! -bang -nargs=* -complete=file TFiles call s:fzf_xfiles("tabedit", <bang>0, <f-args>)
command! -bang -nargs=* -complete=file SFiles call s:fzf_xfiles("split", <bang>0, <f-args>)
command! -bang -nargs=* -complete=file VFiles call s:fzf_xfiles("vsplit", <bang>0, <f-args>)
command! -bang -nargs=* History call s:fzf_history(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* RG call s:fzf_rg(<q-args>, <bang>0)

nnoremap <silent> <C-_> :<C-u>Files<CR>
nnoremap <silent> <C-g>. :<C-u>History<CR>
nnoremap <silent> <C-g>/ :<C-u>History/<CR>
nnoremap <silent> <C-g>: :<C-u>History:<CR>
nnoremap <silent> <C-g>; :<C-u>History:<CR>
nnoremap <silent> <C-g><C-_> :<C-u>Files <C-r>=<SID>relpath()<CR><CR>
nnoremap <silent> <C-g><C-g> :<C-u>RG!<CR>
nnoremap <C-g>g :<C-u>RG! <C-r>=expand("<cword>")<CR>
nnoremap <silent> <C-g><C-l> :<C-u>BLines<CR>
nnoremap <silent> <C-g><C-m> :<C-u>Marks<CR>
nnoremap <silent> <C-g><C-t> :<C-u>Tags<CR>
nnoremap <silent> <C-g><C-w> :<C-u>Windows<CR>
nnoremap <silent> <C-g>C :<C-u>Commits<CR>
nnoremap <silent> <C-g>L :<C-u>Lines<CR>
nnoremap <silent> <C-g>c :<C-u>BCommits<CR>
nnoremap <silent> <C-s> :<C-u>Buffers<CR>
nnoremap <silent> [Tab]/ :<C-u>Buffers<CR>

function! s:fzf_commits(buffer_local, extra, bang) range
    call extend(a:extra["options"], [
    \   '--bind', 'ctrl-r:execute-silent(fzf-git log toggle-graph)+reload(fzf-git log view)',
    \   '--bind', 'ctrl-x:execute(fzf-git log switch)+reload(fzf-git log view)',
    \])
    let range = call(s:FZF_SID_PREFIX.'given_range', [a:firstline, a:lastline])
    let source = 'fzf-git log view'
    if len(range) || a:buffer_local
        let current = expand('%')
        let source .= len(range)
        \   ? printf(' -L %d,%d:%s --no-patch', range[0], range[1], fzf#shellescape(current))
        \   : (' --follow '.fzf#shellescape(current))
    else
        call extend(a:extra["options"], [
        \   '--bind', 'ctrl-d:execute(fzf-git log files)+reload(fzf-git log view)',
        \])
    endif
    let a:extra["source"] = source
    call writefile([], s:fzf_state)

    if exists('b:fzf_winview')
        call winrestview(b:fzf_winview)
        unlet b:fzf_winview
    endif
    return call(s:FZF_SID_PREFIX.'commits', [range, 0, [a:extra, a:bang]])
endfunction

function! s:fzf_files(arg, extra, bang)
    call writefile(["type=f", "depth=0"], s:fzf_state)
    call fzf#vim#files(a:arg, a:extra, a:bang)
endfunction

function! s:fzf_xfile(sink, bang, path)
    try
        let extra = fzf#vim#with_preview()
        if a:sink != "edit"
            let extra.sink = a:sink
        endif
        call s:fzf_files(a:path, extra, a:bang)
    catch
        execute a:sink a:path
    endtry
endfunction

function! s:fzf_xfiles(sink, bang, ...)
    if a:0 == 0
        return s:fzf_xfile(a:sink, a:bang, "")
    else
        let files = copy(a:000)
        let dir = ""

        let i = len(files) - 1
        while i >= 0
            if isdirectory(files[i])
                let dir = remove(files, i)
                break
            endif
            let i -= 1
        endwhile

        for file in files
            execute a:sink file
        endfor

        if dir != ""
            return s:fzf_xfile(a:sink, a:bang, dir)
        endif
    endif
endfunction

function! s:fzf_history_source(type)
    let source = call(s:FZF_SID_PREFIX.'history_source', [a:type])
    let source[0] = substitute(source[0], "Ctrl-E", "Ctrl-Y", "")
    return source
endfunction

function! s:fzf_cmd_history_sink(lines)
    if a:lines[0] == 'ctrl-y'
        let a:lines[0] = 'ctrl-e'
    endif
    call call(s:FZF_SID_PREFIX.'cmd_history_sink', [a:lines])
endfunction

function! s:fzf_search_history_sink(lines)
    if a:lines[0] == 'ctrl-y'
        let a:lines[0] = 'ctrl-e'
    endif
    call call(s:FZF_SID_PREFIX.'search_history_sink', [a:lines])
endfunction

function! s:fzf_history(arg, extra, bang)
    let bang = a:bang || a:arg[len(a:arg)-1] == '!'
    if a:arg[0] == ':'
        call fzf#vim#command_history({
    \   'options': ['--no-expect', '--expect', 'ctrl-y'],
    \   'source': s:fzf_history_source(':'),
    \   'sink*': function('s:fzf_cmd_history_sink'),
    \}, bang)
    elseif a:arg[0] == '/'
        call fzf#vim#search_history({
    \   'options': ['--no-expect', '--expect', 'ctrl-y'],
    \   'source': s:fzf_history_source('/'),
    \   'sink*': function('s:fzf_search_history_sink'),
    \}, bang)
    else
        call fzf#vim#history(a:extra, bang)
    endif
endfunction

function! s:fzf_rg(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    if a:query != ""
        let initial_command = printf(command_fmt, shellescape(a:query))
    else
        let initial_command = 'rg || true'
    endif
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" easy-align.vim
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" matchup
let g:matchup_matchparen_offscreen = {'method': 'popup'}

" qfutil.vim
let g:qfutil_default_grep_file = '%:h'

" quickhl.vim
nmap [Space]m <Plug>(quickhl-manual-this)
xmap [Space]m <Plug>(quickhl-manual-this)
nmap [Space]M :<C-u>QuickhlManualAdd!<Space>
nmap [Space]n <Plug>(quickhl-manual-toggle)
nmap [Space]N <Plug>(quickhl-manual-reset)
nmap <silent> <Esc><Esc> <Plug>(quickhl-manual-reset):set nohlsearch<CR>

" quickrun.vim
let g:quickrun_config = {}

command! -nargs=* -range -complete=customlist,quickrun#complete QuickRun1
\ call quickrun#run('-start <line1> -end <line2> ' . <q-args>)

nmap <Leader>r <Plug>(quickrun)
nmap <Leader>e <Plug>(quickrun-op)
nmap <silent> <Leader>ee :QuickRun1<CR>

" vim-partedit
let g:partedit#opener = 'split'
vnoremap [Space]p :Partedit<Space>-filetype<Space><C-r>=<SID>partedit_filetype()<CR>

function! s:partedit_filetype()
    let pre = getline(getpos("'<")[1] - 1)
    let filetype = matchstr(pre, '\v```\zs[-a-zA-Z0-9_]+\ze')
    if filetype != ""
        return filetype
    else
        return 'markdown'
    endif
endfunction

" ref.vim
let g:ref_man_cmd = 'man'
let g:ref_man_lang = 'C'
let g:ref_detect_filetype = {'_': 'man'}
let g:ref_no_default_key_mappings = 1

nnoremap <silent> K :<C-u>call <SID>ref('split')<CR>
nmap <silent> [Tab]K :<C-u>call <SID>ref('tabnew')<CR>
vnoremap <silent> K :<C-u>call <SID>ref('visual')<CR>

cabbrev <expr> R   (getcmdline() =~# "^R" && getcmdpos() == 2)
\                    ? "Ref " . ref#detect() : "R"
cabbrev <expr> Man (getcmdline() =~# "^Man" && getcmdpos() == 4)
\                    ? "Ref man" : "Man"

" smartinput.vim
silent! call smartinput#define_rule({
\   'at': '\%(^\|\s\)then\%#$',
\   'char': '<Enter>', 'input': '<Enter>fi<Up><End><Enter>',
\   'filetype': ['sh', 'zsh']
\})
silent! call smartinput#define_rule({
\   'at': '\%(^\|\s\)in\%#$',
\   'char': '<Enter>', 'input': '<Enter>esac<Up><End><Enter>',
\   'filetype': ['sh', 'zsh']
\})
silent! call smartinput#define_rule({
\   'at': '\%(^\|\s\)do\%#$',
\   'char': '<Enter>', 'input': '<Enter>done<Up><End><Enter>',
\   'filetype': ['sh', 'zsh']
\})
silent! call smartinput#define_rule({
\   'at': '\v%(^|\s)%(do|then|function(\s+[A-Za-z_][A-Za-z_0-9]*)?\([^)]*\))%#$',
\   'char': '<Enter>', 'input': '<Enter>end<Up><End><Enter>',
\   'filetype': ['lua']
\})
silent! call smartinput#define_rule({
\   'at': '\%#', 'char': "'", 'input': "'",
\   'filetype': ['rust']
\})
silent! call smartinput#define_rule({
\   'at': '^\s*augroup\s.*\%#',
\   'char': '<CR>', 'input': "<Enter>augroup END<Up><End><Enter>",
\   'filetype': ['vim']
\})
for s:x in ['for', 'function', 'if', 'try', 'while']
    silent! call smartinput#define_rule({
    \   'at': '^\s*' . s:x . '\>.*\(end' . s:x . '\)\@<!\%#$',
    \   'char': '<Enter>',
    \   'input': '<Enter>end' . s:x . '<Up><End><Enter>',
    \   'filetype': ['vim']
    \})
endfor
for s:x in ['''''''\%#''''''', '"""\%#"""', '```\%#```']
    silent! call smartinput#define_rule({
    \   'at': s:x, 'char': '<Enter>', 'input': '<Enter><Enter><Up><Esc>"_S'
    \})
endfor
unlet s:x

" surround.vim
nmap s <Plug>Ysurround
nmap ss <Plug>Yssurround
nmap S <Plug>Ysurround$
nmap gs <Plug>Ygsurround
nmap gsgs <Plug>Ygssurround
nmap gss <Plug>Ygssurround
nmap gS <Plug>Ygsurround$

" textobj-xbrackets
omap af <Plug>(textobj-xbrackets-x(_)-a)
omap if <Plug>(textobj-xbrackets-x(_)-i)
xmap af <Plug>(textobj-xbrackets-x(_)-a)
xmap if <Plug>(textobj-xbrackets-x(_)-i)

" vim-textobj-user
call textobj#user#plugin('quotes', {
  \   'triple_single_quote-a': {
  \       'pattern': "'''\\_.\\{-}'''",
  \       'select': "a3'",
  \   },
  \   'triple_single_quote-i': {
  \       'pattern': "'''\\zs\\_.\\{-}\\ze'''",
  \       'select': "i3'",
  \   },
  \   'triple_double_quote-a': {
  \       'pattern': '"""\_.\{-}"""',
  \       'select': 'a3"',
  \   },
  \   'triple_double_quote-i': {
  \       'pattern': '"""\zs\_.\{-}\ze"""',
  \       'select': 'i3"',
  \   },
  \   'triple_back_quote-a': {
  \       'pattern': '\s*```.*\n\_.\{-}\s*```',
  \       'select': 'a3`',
  \       'region-type': 'V',
  \   },
  \})

xnoremap i3` <Plug>(textobj-quotes-triple_back_quote-a)o<Down>o<Up>$
omap i3` :normal Vi3`<CR>

" visualstar.vim
xmap <silent> *  <Plug>(visualstar-*):set hlsearch<CR>
xmap <silent> #  <Plug>(visualstar-#):set hlsearch<CR>
xmap <silent> g* <Plug>(visualstar-g*):set hlsearch<CR>
xmap <silent> g# <Plug>(visualstar-g#):set hlsearch<CR>

" vsnip
imap <expr> <C-l>   vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'


"
" Functions
"
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

function! LspStatus() abort
    let lsp_counts = lsp#get_buffer_diagnostics_counts()
    return printf("E%d W%d", lsp_counts['error'], lsp_counts['warning'])
endfunction


function! s:lsp_setup()
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> <C-]> <Plug>(lsp-definition)
endfunction

function! s:compkey(key)
    let pre = "\<C-r>=pumvisible() ? \"\\<C-y>\": ''\<CR>"
    let down = "\<C-r>=pumvisible() ? \"\\<Down>\" : ''\<CR>"
    return pre . a:key . "\<C-p>" . down
endfunction

function! s:relpath()
    let path = expand('%:~:.:h')
    if path == '' || path == '.'
        return ''
    else
        return path . '/'
    endif
endfunction

function! s:tabclose()
    for bufnr in range(1, winnr('$'))
        if getwinvar(bufnr, '&buftype') ==# 'quickfix'
            tabclose
            return
        endif
    endfor
    call tabutil#close()
endfunction

function! s:insert_word_from_line(lnum)
    return matchstr(getline(a:lnum), '\%' . virtcol('.') . 'v\%(\k\+\|.\)')
endfunction

function! s:qfmode_p()
    return getqflist() != [] || getloclist(0) != []
endfunction

function! s:p_ctrl_w()
    let pos = searchpos('\<\|\>', 'bn')
    let n = col('.') - pos[1]
    return n > 0 ? repeat("\<C-h>", n) : "\<C-w>"
endfunction

function! s:ctrl_w()
    if strpart(getline('.'), col('.') - 3, 2) =~ '\s\s'
        return "\<C-o>:let &sts=&ts\<CR>\<BS>\<C-o>:let &sts=0\<CR>"
    endif
    return "\<C-w>"
endfunction

function! s:kill_arg()
    let line = getcmdline()
    let pos = getcmdpos() - 2

    if pos < 0
        return ""
    endif

    let c = strlen(substitute(matchstr(line[:pos], '\S*\s*$'), ".", "x", "g"))
    return repeat("\<C-h>", c)
endfunction

function! s:border_line(char)
    let prevline = line('.') - 1
    if prevline == 0
        return ''
    endif
    return repeat(a:char, strdisplaywidth(getline(prevline)) - col('.') + 1)
endfunction

function! s:toggle_spell()
    setlocal spell!
    let b:spell = &l:spell
    setlocal spell?
endfunction

function! s:toggle_cc()
    if &l:cc != 0
        let &l:cc = 0
    else
        let &l:cc = 81
    endif
endfunction

function! s:ref(open)
    if &filetype ==# 'vim'
        if a:open == 'tabnew'
            execute 'silent! tab help ' . expand("<cword>")
        else
            execute 'silent! help ' . expand("<cword>")
        endif
        if &filetype !=# 'help'
            echo 'No entry'
        endif
    else
        try
            call ref#open(ref#detect(), expand("<cword>"), {'open': a:open})
        catch /^ref:/
            echo 'No entry'
        endtry
    endif
endfunction

function! s:get_comma_separated_number_pos(...)
    let line = a:0 > 0 ? a:1 : getline('.')
    let pos = a:0 > 1 ? a:2 : col('.') - 1
    let len = len(line)

    if line[pos] !~ '[0-9,]'
        " Not a number
        return [-1, -1]
    endif

    let begin = pos - len(matchstr(line[:(pos)], '[0-9,]\+$')) + 1
    let end   = pos + len(matchstr(line[(pos):], '^[0-9,]\+')) - 1

    return [begin, end]
endfunction

function! s:separate_number_with_comma(num)
    let num = substitute(a:num, ',', '', 'g')
    let res = ''
    for i in range(len(num))
        if i % 3 == 0
            let res = ',' . res
        endif
        let res = num[len(num) - 1 - i] . res
    endfor
    return res[:-2]
endfunction

function! s:separate_number_with_comma_n()
    let line = getline('.')
    let range = s:get_comma_separated_number_pos(line)

    if range[0] == -1
        return
    endif

    let new = s:separate_number_with_comma(line[range[0]:range[1]])
    call setline('.', line[:(range[0] - 1)] . new . line[(range[1] + 1):])
endfunction

function! s:separate_number_with_comma_i()
    let line = getline('.')
    let pos = col('.') - 1

    if line[pos] =~ '[0-9]' || line[pos - 1] !~ '[0-9]'
        return ''
    endif

    let range = s:get_comma_separated_number_pos(line, pos - 1)
    return repeat("\<BS>", range[1] - range[0] + 1) .
    \      s:separate_number_with_comma(line[range[0]:range[1]])
endfunction

function! s:vim_enter_hook()
endfunction


"
" Local settings
"
if filereadable($HOME . '/.vim/local.vim')
    source $HOME/.vim/local.vim
endif


"
" Epilogue
"
if !exists('s:loaded_vimrc')
    let s:loaded_vimrc = 1
else
    call s:vim_enter_hook()
endif

set secure

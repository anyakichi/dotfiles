scriptencoding utf-8

source ~/.config/nvim/init.d/plug.vim


"
" Options
"
if !has('nvim')
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

    set directory=~/.vim/swap//
    set undodir=~/.vim/undo//

    set timeout
    set ttimeoutlen=50

    silent! set formatoptions+=j

    source $VIMRUNTIME/macros/matchit.vim
endif

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
if executable('gtags-cscope')
    set cscopeprg=gtags-cscope
endif
set cscopetag
set cscopetagorder=0
silent! set cscopequickfix=s-,c-,d-,i-,t-,e-,a-

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
" Commands
"
command! -nargs=? -bang -bar -complete=help H tab help<bang> <args>


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

nnoremap [Tab]o :<C-u>edit<Space>
nnoremap [Tab]t :<C-u>tab split<Space>
nnoremap [Tab]s :<C-u>split<Space>
nnoremap [Tab]v :<C-u>vsplit<Space>
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

nnoremap <silent> [Tab]. :<C-u>call scratch#toggle('tab')<CR>

nnoremap <expr> [Tab]<C-h> &ft =~ "vim\\<Bar>help"
\                               ? ":tab help "
\                               : ":Ref -open=tabnew " . ref#detect() . ' '

nnoremap Q q
nnoremap q <Nop>

nnoremap q: q:
nnoremap q/ q/
nnoremap q? q?

" Quickfix
nnoremap <silent> q\ :<C-u>call qfutil#toggle()<CR>

nnoremap <silent> <C-j> :<C-u>call <SID>c_j(v:count)<CR>
nnoremap <silent> <C-k> :<C-u>call <SID>c_k(v:count)<CR>
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

onoremap aa a>
onoremap ia i>
onoremap ar a]
onoremap ir i]

nnoremap <expr> gc
\               '`[' .
\               ((col("'[") == 1 && col("']") >= len(getline("']")))?'V':'v') .
\               '`]'
vnoremap <silent> gc :<C-u>normal gc<CR>
onoremap <silent> gc :<C-u>normal gc<CR>

try
    call operator#user#define_ex_command('sort', 'sort')
catch
endtry
map [Space]s <Plug>(operator-sort)

nnoremap <silent> [Space]<C-]> <C-]>
nnoremap <silent> [Space]/ :<C-u>set hlsearch! hlsearch?<CR>
nnoremap <silent> [Space]] :<C-u>call <SID>toggle_nmap_ctrl_right_bracket()<CR>
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
inoremap <expr> <C-k> pumvisible() ? "\<Up>" : circomp#start()
inoremap <expr> <C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr> <C-b> pumvisible() ? "\<PageUp>" : "\<Left>"
inoremap <expr> <C-i> pumvisible() ? circomp#next() : "\<C-i>"
inoremap <expr> <C-a> pumvisible() ? circomp#prev() : "\<Home>"
inoremap <expr> <C-e> pumvisible() ? "\<C-e>" : "\<End>"
inoremap <expr> <C-y> pumvisible() ? "\<C-y>"
\                                  : <SID>insert_word_from_line(line('.') - 1)
inoremap <expr> <C-_> <SID>compkey("\<C-x>\<C-f>")

inoremap <C-g><CR> <C-o>o
inoremap <silent> <C-g><C-x> <C-r>=<SID>newxmlline()<CR>

inoremap <C-g><C-l> <C-o>b<C-o>g~w<C-o>w<Right>
inoremap <C-g>L <C-o>b<C-o>gUw<C-o>w<Right>
inoremap <C-g>l <C-o>b<C-o>guw<C-o>w<Right>

inoremap <expr> <C-g>= <SID>border_line('=')
inoremap <expr> <C-g>- <SID>border_line('-')
inoremap <expr> <C-g>~ <SID>border_line('~')

cnoremap <C-n> <PageDown>
cnoremap <C-p> <PageUp>
cnoremap <C-g> <C-r>=<SID>kill_arg()<CR>
cnoremap <expr> <C-_> <SID>relpath()

" Comma separated numbers
nnoremap <silent> <C-g>, :<C-u>call <SID>separate_number_with_comma_n()<CR>
inoremap <expr> <C-g>, <SID>separate_number_with_comma_i()


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
    autocmd QuickFixCmdPost [^l]*       cwindow
    autocmd QuickFixCmdPost l*          lwindow

    " Additional settings for each file type
    autocmd FileType c,go,help          setlocal noet
    autocmd FileType css,docbk,eruby,html,javascript,javascriptreact,json,
                    \markdown,ocaml,reason,rescript,rst,ruby,scheme,scss,
                    \tex,typescript,typescriptreact,xhtml,xml,yaml
    \   setlocal sw=2
    autocmd FileType asciidoc,gitcommit,mail,markdown,rst,tex,text
    \   setlocal tw=72 | let b:spell = -1
    autocmd FileType go                 setlocal ts=4
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

" a.vim
let g:alternateExtensions_H = "C,M,CPP,CXX,CC"
let g:alternateExtensions_h = "c,m,cpp,cxx,cc,CC"
let g:alternateExtensions_M = "H"
let g:alternateExtensions_m = "h"

" autofmt.vim
set formatexpr=autofmt#japanese#formatexpr()
let g:autofmt_allow_over_tw = 2

" cecutil.vim
nmap [Tab]= <Plug>SaveWinPosn
nmap [Tab]- <Plug>RestoreWinPosn

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
\   "--bind", "ctrl-d:reload(fzf-file go-parent && fzf-file list)",
\   "--bind", "ctrl-r:reload(fzf-file toggle-depth && fzf-file list)",
\   "--bind", "ctrl-s:reload(fzf-file reset-parent && fzf-file list)",
\   "--bind", "ctrl-/:toggle-preview",
\   "--preview", 'fzf-file view {} | head -500',
\   "--preview-window", "hidden"
\]

command! -bar -bang BCommits call s:fzf_bcommits(<bang>0)
command! -bar -bang Commits call s:fzf_commits(<bang>0)
command! -bang -nargs=? -complete=dir Files call s:fzf_files(<q-args>, <bang>0)
command! -bang -nargs=* History call s:fzf_command_history(<bang>0)
command! -bang -nargs=* RG call s:fzf_rg(<q-args>, <bang>0)

nnoremap <silent> <C-_> :<C-u>Files<CR>
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

function! s:fzf_bcommits(fullscreen)
    call writefile([], s:fzf_state)
    call fzf#vim#buffer_commits({
    \   'options': [
    \       '--bind', 'ctrl-d:execute(fzf-git log files)+reload(fzf-git log view)',
    \       '--bind', 'ctrl-r:execute-silent(fzf-git log toggle-graph)+reload(fzf-git log view)',
    \       '--bind', 'ctrl-x:execute(fzf-git log switch)+reload(fzf-git log view)',
    \   ],
    \   'source': 'fzf-git log view '.fzf#shellescape(expand('%')),
    \}, a:fullscreen)
endfunction

function! s:fzf_commits(fullscreen)
    call writefile([], s:fzf_state)
    call fzf#vim#commits({
    \   'options': [
    \       '--bind', 'ctrl-d:execute(fzf-git log files)+reload(fzf-git log view)',
    \       '--bind', 'ctrl-r:execute-silent(fzf-git log toggle-graph)+reload(fzf-git log view)',
    \       '--bind', 'ctrl-x:execute(fzf-git log switch)+reload(fzf-git log view)',
    \   ],
    \   'source': 'fzf-git log view',
    \}, a:fullscreen)
endfunction

function! s:fzf_files(dir, fullscreen)
    call writefile(["type=f", "depth=0"], s:fzf_state)
    call fzf#vim#files(a:dir, a:fullscreen)
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

function! s:fzf_command_history(fullscreen)
    call fzf#vim#command_history({
    \   'options': ['--no-expect', '--expect', 'ctrl-y'],
    \   'source': s:fzf_history_source(':'),
    \   'sink*': function('s:fzf_cmd_history_sink'),
    \}, a:fullscreen)
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

" scratch.vim
let g:scratch_filetype = 'ruby'

" skk.vim
let g:skk_auto_save_jisyo = 1
let g:skk_egg_like_newline = 1
let g:skk_sticky_key = ';'
let g:skk_manual_save_jisyo_keys = "g<C-s>"

let g:skk_user_rom_kana_rules = ""
    \. "(	（\<NL>"
    \. ")	）\<NL>"
let g:skk_special_midasi_keys = "<>"

let g:skk_ascii_mode_string = 'aA'
let g:skk_hira_mode_string = 'あ'
let g:skk_kata_mode_string = 'ア'
let g:skk_zenei_mode_string = 'Ａ'
let g:skk_abbrev_mode_string = 'aあ'

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

if has('nvim-0.5')
    let s:SMARTINPUT_SID_PREFIX = "<SNR>".s:V.Vim.ScriptLocal.sid("autoload/smartinput.vim")."_"
    function! s:confirm()
        return compe#confirm(call(s:SMARTINPUT_SID_PREFIX . '_trigger_or_fallback', ["\<CR>", "\<CR>"]))
    endfunction
    inoremap <silent><expr> <CR> <SID>confirm()
    inoremap <silent><expr> <C-e> compe#close('<End>')
endif

" surround.vim
nmap s <Plug>Ysurround
nmap ss <Plug>Yssurround
nmap S <Plug>Ysurround$
nmap gs <Plug>Ygsurround
nmap gsgs <Plug>Ygssurround
nmap gss <Plug>Ygssurround
nmap gS <Plug>Ygsurround$

" tohtml.vim
let g:html_use_css = 1
let g:use_xhtml = 1

" ultisnips
let g:UltiSnipsNoPythonWarning = 1
let g:UltiSnipsExpandTrigger = "<C-]>"
let g:UltiSnipsJumpForwardTrigger = "<C-i>"
let g:UltiSnipsJumpBackwardTrigger = "<C-o>"

" vimux.vim
let g:VimuxResetSequence = ""

nmap <silent> [Space]r  :<C-u>set opfunc=<SID>vimux_send<CR>g@
nmap <silent> [Space]R  :<C-u>set opfunc=<SID>vimux_send<CR>g@$
nmap <silent> [Space]rr :<C-u>call <SID>vimux_send(v:count1)<CR>
nmap <silent> [Space];  :<C-u>call VimuxRunCommand(";;\n", 0)<CR>

xmap <silent> [Space]r  :<C-u>call <SID>vimux_send('v')<CR>
xmap <silent> [Space]R  :<C-u>call <SID>vimux_send('V')<CR>

function! s:vimux_send(type)
    call s:do_opfunc(a:type, 'VimuxRunCommand', 0)
endfunction

" visualstar.vim
xmap <silent> *  <Plug>(visualstar-*):set hlsearch<CR>
xmap <silent> #  <Plug>(visualstar-#):set hlsearch<CR>
xmap <silent> g* <Plug>(visualstar-g*):set hlsearch<CR>
xmap <silent> g# <Plug>(visualstar-g#):set hlsearch<CR>


"
" Functions
"
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

function! LspStatus() abort
    if has('nvim-0.5')
        if luaeval('#vim.lsp.buf_get_clients() > 0')
            return substitute(luaeval("require('lsp-status').status()"), '%%', '%', 'g')
        endif
        return ''
    else
        let lsp_counts = lsp#get_buffer_diagnostics_counts()
        return printf("E%d W%d", lsp_counts['error'], lsp_counts['warning'])
    endif
endfunction

function! s:toggle_nmap_ctrl_right_bracket()
    if mapcheck('<C-]>', 'n') == ""
        nmap <buffer> <C-]> <Plug>(lsp-definition)
    else
        silent! nunmap <buffer> <C-]>
    endif
endfunction

function! s:lsp_setup()
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> <C-]> <Plug>(lsp-definition)
endfunction

function! s:do_opfunc(type, func, ...)
    let type_map = {"char": "v", "line": "V", "block": "\<C-v>"}

    let reg_save = [getreg('a'), getregtype('a')]
    let sel_save = &selection
    let cb_save  = &clipboard

    let &selection = "inclusive"
    set clipboard-=unnamed clipboard-=unnamedplus

    if has_key(type_map, a:type)
        silent execute 'normal! `[' . type_map[a:type] . '`]"ay'
    elseif index(["v", "V", "\<C-v>"], a:type) >= 0
        silent execute 'normal! `<' . a:type . '`>"ay'
    elseif a:type =~ '^\d\+$'
        execute 'silent normal! ' . a:type . '"ayy'
    else
        let &selection = sel_save
        let &clipboard = cb_save
        return
    endif

    let lines = split(@a, "\n\zs")
    for line in lines
        if a:0
            call call(a:func, [line, a:1])
        else
            call call(a:func, [line])
        endif
    endfor

    let &clipboard = cb_save
    let &selection = sel_save
    call setreg('a', reg_save[0], reg_save[1])
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
    if scratch#is_visible()
        call scratch#close()
    else
        for bufnr in range(1, winnr('$'))
            if getwinvar(bufnr, '&buftype') ==# 'quickfix'
                tabclose
                return
            endif
        endfor
        call tabutil#close()
    endif
endfunction

function! s:insert_word_from_line(lnum)
    return matchstr(getline(a:lnum), '\%' . virtcol('.') . 'v\%(\k\+\|.\)')
endfunction

function! s:qfmode_p()
    return getqflist() != [] || getloclist(0) != []
endfunction

function! s:c_j(count)
    if s:qfmode_p()
        call qfutil#next(a:count)
    else
        execute 'normal! ' . a:count . ']c'
    endif
endfunction

function! s:c_k(count)
    if s:qfmode_p()
        call qfutil#previous(a:count)
    else
        execute 'normal! ' . a:count . '[c'
    endif
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

function! s:newxmlline()
    let col = col(".")
    copy .
    if col != 1
        execute 'normal!' (col - 1) . 'l'
    endif
    normal! dit
    return ''
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
    " a.vim
    silent! iunmap <Leader>ih
    silent! iunmap <Leader>is
    silent! iunmap <Leader>ihn
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

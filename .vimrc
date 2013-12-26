"
" dot.vimrc:
"	Vim configuration
"

scriptencoding utf-8
set nocompatible

source ~/.vim/bundle/.config.vim


"
" Options
"
set backspace=indent,eol,start

" Encodings
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp,utf-16,ucs-2le,ucs-2

" Indentation
set autoindent
set noexpandtab
set shiftround
set shiftwidth=4
set smartindent
set tabstop=8
set cinoptions=>2s,e0,n0,f0,{0,}0,^0,:0,=2s,l1,b0,g2s,h2s,p2s,t0,
	      \i2s,+1s,c1s,C0,/0,(0,u0,U0,w1,W0,m1,j1,)20,*30

" Status information
set laststatus=2
set showcmd
set statusline=%!MakeStatusLine()
set tabline=%!MakeTabLine()

" Searching
set nohlsearch
set ignorecase
set incsearch
set smartcase

" Formatting
set formatoptions=tcroqlmB
set textwidth=78

" Completion
set complete=.,w,b,u
set completeopt=menuone
set pumheight=10

" Appearance
set ambiwidth=double
set background=dark
set cursorline
set display=lastline
set notitle

" Folding
set nofoldenable

" Command line
set history=1000
set wildmenu
set wildmode=list:longest,full

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
set directory=~/.vim/swap

" Timeouts
set timeout
set timeoutlen=3000
set ttimeoutlen=50

" Mappings
set cedit=<C-x>
set pastetoggle=<C-q>

" File searching
set path=.,/usr/include,/usr/pkg/include,/usr/local/include
set tags=./tags;/

" Cscope
set cscopetag
set cscopetagorder=1
set cscopequickfix=s-,c-,d-,i-,t-,e-

if has("mouse")
    set mouse=a
endif

let g:filetype_m = 'objc'

filetype plugin indent on


"
" Syntax coloring
"
syntax on
if has('gui_macvim')
    set background=light
elseif (has('gui') || v:version >= 703) && &t_Co == 256
    if !has('gui_running')
	let g:CSApprox_hook_pre = [
	\   'highlight TabLine gui=none guifg=fg guibg=#334b7d',
	\   'highlight TabLineFill gui=none guifg=fg guibg=#334d7d',
	\   'highlight TabLineSel gui=bold guifg=fg guibg=bg',
	\   'highlight RedundantSpaces guibg=#303030']
    endif

    silent! colorscheme moria
else
    silent! colorscheme nya
endif

highlight link IdeographicSpace RedundantSpaces
match IdeographicSpace /　/


"
" Commands
"
command! -nargs=? -bang -bar -complete=help H tab help<bang> <args>

command! -nargs=1 RegCopy call s:regcopy(<q-args>)


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
\	 getcmdtype() == '/' ? "\<CR>:set hlsearch\<CR>" : "\<CR>"
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
\				? ":tab help "
\				: ":Ref -open=tabnew " . ref#detect() . ' '

nnoremap Q q
nnoremap q <Nop>

nnoremap q: q:
nnoremap q/ q/
nnoremap q? q?

" Quickfix
nnoremap <silent> q\ :<C-u>call qfutil#toggle()<CR>

nnoremap <silent> <C-j> :<C-u>call qfutil#next(v:count)<CR>
nnoremap <silent> <C-k> :<C-u>call qfutil#previous(v:count)<CR>
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

nnoremap <silent> <expr> qm qfutil#make()
nnoremap qM :<C-u>QFMake<Space>
nnoremap q<Space> :<C-u>QFMake<Space>
nnoremap qg :<C-u>QFGrep<Space>
nnoremap qG :<C-u>QFGrep <C-r><C-w><Space>

nnoremap <silent> q] :<C-u>call qfutil#ltag()<CR>

" Cscope
nmap <C-\><C-\> <Plug>(csutil-toggle-csto)

for s:type in ['s', 'g', 'd', 'c', 't', 'e']
    let s:mapping = '<C-\>' . s:type
    let s:target = ':<C-u>call csutil#find("<cword>", "' . s:type .
    \					   '", qfutil#_mode())<CR>'
    execute 'nnoremap' '<silent>' s:mapping s:target
endfor

for s:type in ['f', 'i']
    let s:mapping = '<C-\>' . s:type
    let s:target = ':<C-u>call csutil#find("<cfile>", "' . s:type .
    \					   '", qfutil#_mode())<CR>'
    execute 'nnoremap' '<silent>' s:mapping s:target
endfor
unlet s:type s:mapping s:target

onoremap aa a>
onoremap ia i>
onoremap ar a]
onoremap ir i]

nnoremap <expr> gc
\		'`[' .
\		((col("'[") == 1 && col("']") >= len(getline("']")))?'V':'v') .
\		'`]'
vnoremap <silent> gc :<C-u>normal gc<CR>
onoremap <silent> gc :<C-u>normal gc<CR>

try
    call operator#user#define_ex_command('sort', 'sort')
catch
endtry
map [Space]s <Plug>(operator-sort)

nnoremap <silent> [Space]/ :<C-u>set hlsearch! hlsearch?<CR>
nnoremap <silent> [Space][ :<C-u>call <SID>toggle_fttag()<CR>
nnoremap <silent> [Space]z :<C-u>set spell! spell?<CR>
nnoremap <silent> [Space]V :<C-u>edit $HOME/.vimrc<CR>
nnoremap <silent> [Space]v :<C-u>source $HOME/.vimrc<CR>
nnoremap [Space]= `[=`]

" Insert and command mode mappings
noremap! <C-a> <Home>
noremap! <C-b> <Left>
noremap! <C-f> <Right>

inoremap <C-u> <C-g>u<C-u>
inoremap <expr> <C-w> "\<C-g>u" . <SID>ctrl_w()

inoremap <expr> <C-j> pumvisible() ? "\<Down>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<Up>" : circomp#start()
inoremap <expr> <C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr> <C-b> pumvisible() ? "\<PageUp>" : "\<Left>"
inoremap <expr> <C-i> pumvisible() ? circomp#next() : "\<C-i>"
inoremap <expr> <C-a> pumvisible() ? circomp#prev() : "\<Home>"
inoremap <expr> <C-e> pumvisible() ? "\<C-e>" : "\<End>"
inoremap <expr> <C-y> pumvisible() ? "\<C-y>"
\				   : <SID>insert_word_from_line(line('.') - 1)
inoremap <expr> <C-_> <SID>compkey("\<C-x>\<C-f>", 1)

inoremap <C-g><CR> <C-o>o
inoremap <silent> <C-g><C-x> <C-r>=<SID>newxmlline()<CR>

inoremap <expr> <C-g>= <SID>border_line('=')
inoremap <expr> <C-g>- <SID>border_line('-')
inoremap <expr> <C-g>~ <SID>border_line('~')

cnoremap <C-n> <PageDown>
cnoremap <C-p> <PageUp>
cnoremap <C-g> <C-r>=<SID>kill_arg()<CR>
cnoremap <C-q> <C-r>=<SID>grep_go_to_pattern()<CR>
cnoremap <expr> <C-_> <SID>relpath()

" Comma separated numbers
nnoremap <silent> <C-g>, :<C-u>call <SID>separate_number_with_comma_n()<CR>
inoremap <expr> <C-g>, <SID>separate_number_with_comma_i()


"
" Auto commands
"
augroup MyAutoCmd
    autocmd!

    autocmd WinLeave *			setlocal nocursorline
    autocmd WinEnter,BufRead *		setlocal cursorline

    " Fix up settings after loading all plugins
    autocmd VimEnter *                  call s:vim_enter_hook()

    " Hook function for buffer
    autocmd BufNewFile,BufReadPost *    call s:buffer_hook()

    " Open the quickfix window automatically
    autocmd QuickFixCmdPost [^l]*       cwindow
    autocmd QuickFixCmdPost l*          lwindow

    " Use syntax complete
    autocmd Filetype *
    \	if &omnifunc == ""
    \|	    setlocal omnifunc=syntaxcomplete#Complete
    \|	endif

    " Additional settings for each file type
    autocmd FileType haskell,ocaml,python,ruby,vim
    \   setlocal et
    autocmd FileType docbk,eruby,html,markdown,ocaml,ruby,scheme,tex,xhtml,xml
    \   setlocal sw=2
    autocmd FileType python	        setlocal fo-=t sts=0
    autocmd FileType mail		setlocal tw=72
    autocmd FileType taskpaper		setlocal sw=2 ts=2
    autocmd FileType vimwiki		setlocal fo+=mB

    " Syntax setup
    autocmd VimEnter *
    \	call s:matchupdate('RedundantSpaces', '\(\s\+$\| \+\ze\t\)')
    autocmd InsertEnter *
    \	call s:matchupdate('RedundantSpaces', '\(\s\+$\| \+\ze\t\)\%#\@!')
    autocmd InsertLeave *
    \	call s:matchupdate('RedundantSpaces', '\(\s\+$\| \+\ze\t\)')

    " View PDF in Vim.
    autocmd BufReadPost *pdf silent %!pdftotext -nopgbrk -layout "%" -
augroup END


"
" Plugins
"

" CSApprox
let g:CSApprox_verbose_level = 0
let g:CSApprox_bang_at_startup = 1
let g:CSApprox_approximator_cache_xterm = {
\   '008b8b':  30, 'd0d0d0': 252, '87df71': 113, '7ee0ce': 116, 'ee2c2c': 196,
\   '41609e':  61, '2ceeee':  51, '8b0000':  88, '2c2cee':  21, 'bdcae3': 152,
\   '90e090': 114, 'ee2cee': 201, 'e0e000': 184, 'e0cd78': 186, '7ec0ee': 111,
\   '334b7d':  60, '9999ff': 105, 'ffffff': 231, '25365a':  23, 'ffb3ff': 219,
\   '000000':  16, '6381be':  67, '1e90ff':  33, 'ff7272': 203, 'f09479': 210,
\   'ffff00': 226, '202020': 234, '008b00':  28, 'e8b87e': 180, '97abd5': 110,
\   '8fa5d1': 110, 'ffdb72': 221, '0000cd':  20, '00008b':  18, '404040': 238,
\   '4e4e4e': 239, 'a0a0a0': 247, '8ccbea': 116, '00e700':  40, 'd7a0d7': 182,
\   'd0d0a0': 187, 'a4e57e': 150, '606060':  59, 'ffa500': 214, '00a0ff':  39,
\   '494949': 238}

" NERD_commenter
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1

nmap <Leader>cc <Plug>NERDCommenterAlignLeft
vmap <Leader>c	<Plug>NERDCommenterComment
nmap <Leader>C	<Plug>NERDCommenterToEOL
vmap <Leader>C	<Plug>NERDCommenterAlignLeft
nmap <Leader>xm <Plug>NERDCommenterMinimal
nmap <Leader>xs <Plug>NERDCommenterSexy
vmap <Leader>xm <Plug>NERDCommenterMinimal
vmap <Leader>xs <Plug>NERDCommenterSexy
nmap <Leader>xa <Plug>NERDCommenterAltDelims
nmap <Leader>u	<Plug>NERDCommenterUncomment
vmap <Leader>u	<Plug>NERDCommenterUncomment

" a.vim
let g:alternateExtensions_H = "C,M,CPP,CXX,CC"
let g:alternateExtensions_h = "c,m,cpp,cxx,cc,CC"
let g:alternateExtensions_M = "H"
let g:alternateExtensions_m = "h"

" alignta.vim
nnoremap <silent> <Leader>as :Alignta! \S\+<CR>
xnoremap <silent> <Leader>as :Alignta! \S\+<CR>
nnoremap <Leader>al :Alignta!<Space>
xnoremap <Leader>al :Alignta!<Space>

" autofmt.vim
set formatexpr=autofmt#japanese#formatexpr()
let g:autofmt_allow_over_tw = 2

" capslock.vim
imap <C-l> <Plug>CapsLockToggle

" cecutil.vim
nmap [Tab]= <Plug>SaveWinPosn
nmap [Tab]- <Plug>RestoreWinPosn

" mark.vim
nmap [Space]m <Plug>MarkSet
xmap [Space]m <Plug>MarkSet
nmap [Space]M <Plug>MarkRegex
xmap [Space]M <Plug>MarkRegex
nmap [Space]n <Plug>MarkToggle
nmap [Space]N <Plug>MarkAllClear
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
nmap <silent> <Esc><Esc> <Plug>MarkAllClear:set nohlsearch<CR>

" matchit.vim
source $VIMRUNTIME/macros/matchit.vim

" omnicppcomplete.vim
let g:OmniCpp_ShowPrototypeInAbbr = 1
let g:OmniCpp_MayCompleteArrow = 0
let g:OmniCpp_MayCompleteDot = 0
let g:OmniCpp_MayCompleteNamespace = 0
let g:OmniCpp_MayCompleteScope = 0
let g:OmniCpp_SelectFirstItem = 2

" qfutil.vim
let g:qfutil_default_grep_file = '%:h'

" quickrun.vim
let g:quickrun_config = {}

command! -nargs=* -range -complete=customlist,quickrun#complete QuickRun1
\ call quickrun#run('-start <line1> -end <line2> ' . <q-args>)

nmap <Leader>r <Plug>(quickrun)
nmap <Leader>e <Plug>(quickrun-op)
nmap <silent> <Leader>ee :QuickRun1<CR>

" ref.vim
let g:ref_detect_filetype = {'_': 'man'}
let g:ref_no_default_key_mappings = 1

if !executable("manpath")
    let g:ref_man_manpath = '/usr/share/man:/usr/pkg/man:/usr/local/man'
endif

nnoremap <silent> K :<C-u>call <SID>ref('split')<CR>
nmap <silent> [Tab]K :<C-u>call <SID>ref('tabnew')<CR>
vnoremap <silent> K :<C-u>call <SID>ref('visual')<CR>

cabbrev <expr> R   (getcmdline() =~# "^R" && getcmdpos() == 2)
\		     ? "Ref " . ref#detect() : "R"
cabbrev <expr> Man (getcmdline() =~# "^Man" && getcmdpos() == 4)
\		     ? "Ref man" : "Man"

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

" snipmate.vim
let g:snips_author = 'INAJIMA Daisuke'

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

" twitvim.vim
let g:twitvim_enable_python = 1
nmap [Space]t :PosttoTwitter<CR>

" unite.vim
let g:unite_source_outline_cache_limit = 1000000

nnoremap [Space]uo :<C-u>Unite outline<CR>

" vcscommand.vim
let g:VCSCommandMapPrefix = '<Leader>v'
let g:VCSCommandVCSTypePreference = ['bzr', 'cvs', 'git', 'svk', 'svn']

" vimux.vim
let g:VimuxResetSequence = ""

nmap <silent> [Space]r	:<C-u>set opfunc=<SID>vimux_send<CR>g@
nmap <silent> [Space]R	:<C-u>set opfunc=<SID>vimux_send<CR>g@$
nmap <silent> [Space]rr	:<C-u>call <SID>vimux_send(v:count1)<CR>
nmap <silent> [Space];	:<C-u>call VimuxRunCommand(";;\n", 0)<CR>

xmap <silent> [Space]r	:<C-u>call <SID>vimux_send('v')<CR>
xmap <silent> [Space]R	:<C-u>call <SID>vimux_send('V')<CR>

function! s:vimux_send(type)
    call s:do_opfunc(a:type, 'VimuxRunCommand', 0)
endfunction

" vimwiki.vim
let g:vimwiki_list = [
\   { 'path': '~/vimwiki', 'path_html': '~/Web/wiki', 'auto_export': 1 }
\]
let g:vimwiki_badsyms = ' '
let g:vimwiki_hl_headers = 1

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

function! MakeStatusLine()
    let s  = '%<%f %y'
    let s .= '[' . (&fenc != '' ? &fenc : &enc) . ']'
    if &ff != 'unix'
	let s .= '[' . &ff . ']'
    endif
    if &bin
	let s .= '[bin]'
    endif
    let s .= '%m%r'
    let s .= '%='
    let extra = ''
    if exists("*SkkGetModeStr")
	let extra .= SkkGetModeStr()
    endif
    if exists("*CapsLockStatusline")
	let extra .= CapsLockStatusline()
    endif
    if extra !~ '^\s*$'
	let s .= extra . ' '
    endif
    let s .= winwidth('%') >= 80 ? '%-14.' : '%-8.'
    let s .= '(%l,%c%V%) %P'
    return s
endfunction

function! MakeTabLine()
    let s = ''

    for n in range(1, tabpagenr('$'))
	if n == tabpagenr()
	    let s .= '%#TabLineSel#'
	else
	    let s .= '%#TabLine#'
	endif

	let s .= '%' . n . 'T'

	let s .= ' %{MakeTabLabel(' . n . ')} '

	let s .= '%#TabLineFill#%T'
	let s .= '|'
    endfor

    let s .= '%#TabLineFill#%T'
    let s .= '%=%#TabLine#'
    let s .= '%{fnamemodify(getcwd(), ":~:h")}%<'
    return s
endfunction

function! MakeTabLabel(n)
    let bufnrs = tabpagebuflist(a:n)
    let bufnr = bufnrs[tabpagewinnr(a:n) - 1]

    let bufname = bufname(bufnr)
    if bufname == ''
	let bufname = '[No Name]'
    else
	let bufname = fnamemodify(bufname, ":t")
    endif

    let no = len(bufnrs)
    if no == 1
	let no = ''
    endif

    let mod = len(filter(bufnrs, 'getbufvar(v:val, "&modified")')) ? '+' : ''
    let sp = (no . mod) == '' ? '' : ' '

    let s = no . mod . sp . bufname
    return s
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

function! s:regcopy(reg)
    if a:reg ==# '&'
	call {fakeclip#_sid_prefix()}write_pastebuffer(@@)
    else
	execute 'let' '@'.a:reg '= @@'
    endif
endfunction

function! s:compkey(key, ...)
    let repeat = a:0 > 0 ? a:1 : 0

    let pre = repeat ? "\<C-y>" : ""
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

function! s:matchupdate(group, pattern)
    for match in getmatches()
	if match['group'] ==# a:group
	    call matchdelete(match['id'])
	endif
    endfor

    call matchadd(a:group, a:pattern)
endfunction

function! s:insert_word_from_line(lnum)
    return matchstr(getline(a:lnum), '\%' . virtcol('.') . 'v\%(\k\+\|.\)')
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

function! s:grep_go_to_pattern()
    let cmdline = getcmdline()
    let index = matchend(cmdline, '\v\C(l?grep|QFGrep)\s+\S+')
    if index >= 0
	call setcmdpos(index + 1)
    endif
    return ""
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

function! s:toggle_fttag()
    let tags_file = '~/.vim/tags/' . &filetype . '.tags'
    let tags_save = &l:tags
    execute 'setl tags+=' . tags_file
    if tags_save == &l:tags
	execute 'setl tags-=' . tags_file
    endif
    setl tags?
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

    " capslock.vim
    execute 'inoremap <expr> <C-l> pumvisible() ? "\<C-l>" : "' .
    \				       maparg("<Plug>CapsLockToggle", 'i') . '"'

    " skk.vim
    inoremap <expr> <C-j> pumvisible() ? "\<Down>" : "\<C-r>=SkkToggle()\<CR>"

    " snipmate.vim
    inoremap <silent> <expr> <C-]> pumvisible() ?
    \			"\<C-]>" :
    \			"\<C-r>=TriggerSnippet(" .
    \			    "<SID>compkey(\"\\<lt>C-x>\\<lt>C-]>\"), 1)\<CR>"
    inoremap <silent> <expr> <Tab> pumvisible() ?
    \			circomp#next() :
    \			"\<C-r>=TriggerSnippet(\"\\<Tab>\", 0)\<CR>"
    snoremap <silent> <C-]> <Esc>i<Right><C-r>=TriggerSnippet("\<C-]>", 1)<CR>
    snoremap <silent> <Tab> <Esc>i<Right><C-r>=TriggerSnippet("\<Tab>", 0)<CR>
    inoremap <silent> <S-Tab> <c-r>=BackwardsSnippet("\<S-Tab>")<CR>
    snoremap <silent> <S-Tab>
    \	     <Esc>i<Right><C-r>=BackwardsSnippet("\<S-Tab>")<CR>
endfunction

function! s:buffer_hook()
    if findfile('build.sh', '.;') != ''
	" NetBSD source tree
	return
    elseif findfile('conf.py', '.;') != ''
	" Shpinx document
	if executable('gmake')
	    set makeprg=gmake
	endif
    endif

    silent call s:toggle_fttag()
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

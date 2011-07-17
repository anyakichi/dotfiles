"
" dot.vimrc:
"	Vim configuration
"

scriptencoding utf-8

"
" set runtimepath by pathogen.vim
"
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


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
set softtabstop=8
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
set formatoptions=tcroqnlmM
set textwidth=78

" Completion
set complete-=t
set completeopt=menuone

" Appearance
set ambiwidth=double
set background=dark
set cursorline
set display=lastline

" Command line
set history=1000
set wildmenu
set wildmode=list:longest,full

" Visual mode
set virtualedit=block

" Buffer
set hidden
set switchbuf=usetab

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
set pastetoggle=<C-_>

" File searching
set path=.,/usr/include,/usr/pkg/include,/usr/local/include
set tags=./tags;/

" Compatibility
set cpoptions+=$

if has("mouse")
    set mouse=a
endif

let g:filetype_m = 'objc'

filetype plugin indent on


"
" Syntax coloring
"
syntax on
if (has('gui') || v:version >= 703) && &t_Co == 256
    if !has('gui_running')
	let g:CSApprox_hook_post = [
	\   'execute "hi TabLine cterm=none ctermfg=fg ctermbg=" .
	\	     g:CSApprox_approximator_function(0x33, 0x4b, 0x7d)',
	\   'execute "hi TabLineFill cterm=none ctermfg=fg ctermbg=" .
	\	     g:CSApprox_approximator_function(0x33, 0x4b, 0x7d)',
	\   'hi TabLineSel cterm=bold ctermfg=fg ctermbg=bg']
    endif

    silent! colorscheme moria
else
    silent! colorscheme nya
endif

highlight RedundantSpaces guibg=#808080 ctermbg=Grey


"
" Commands
"
command! -nargs=? -bang -bar -complete=help H tab help<bang> <args>

command! -register RegCopy let @<reg> = @@


"
" Mappings
"
let g:maplocalleader = "[Space]"
map <Space> [Space]
noremap [Space] <Nop>

nmap t [Tab]
nnoremap [Tab] <Nop>
nnoremap [Tab]; t

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

nnoremap <silent> [Tab]a :<C-u>tabs<CR>

nnoremap <silent> <expr> [Tab]b ':<C-u>tab sbuffer ' . v:count1 . '<CR>'
nnoremap <silent> <expr> [Tab]n ':<C-u>tab sbnext ' . v:count1 . '<CR>'
nnoremap <silent> <expr> [Tab]p ':<C-u>tab sbprevious ' . v:count1 . '<CR>'
nnoremap <silent> [Tab]x :<C-u>quit<CR>
nnoremap <silent> [Tab]D :<C-u>bdelete<CR>
nmap [Tab]g [Tab]b

nnoremap <silent> [Tab]l :<C-u>call tabutil#move(v:count1)<CR>
nnoremap <silent> [Tab]h :<C-u>call tabutil#move(-v:count1)<CR>
nnoremap <silent> [Tab]L :<C-u>tabmove<CR>
nnoremap <silent> [Tab]H :<C-u>tabmove 0<CR>
nnoremap <silent> <expr> [Tab]M ':<C-u>tabmove ' . v:count . '<CR>'

nnoremap [Tab]o :<C-u>edit<Space>
nnoremap [Tab]t :<C-u>tabnew<Space>
nnoremap [Tab]s :<C-u>split<Space>
nnoremap [Tab]v :<C-u>vsplit<Space>
nnoremap <expr> [Tab]O ':<C-u>edit ' . GetRelativePath()
nnoremap <expr> [Tab]T ':<C-u>tabnew ' . GetRelativePath()
nnoremap <expr> [Tab]S ':<C-u>split ' . GetRelativePath()
nnoremap <expr> [Tab]V ':<C-u>vsplit ' . GetRelativePath()

nnoremap <silent> [Tab]d :<C-u>call <SID>tabclose()<CR>
nnoremap <silent> [Tab]q :<C-u>call tabutil#only()<CR>
nnoremap <silent> [Tab]u :<C-u>call tabutil#undo()<CR>
nnoremap <silent> [Tab]U :<C-u>call tabutil#undoall()<CR>

nnoremap <silent> [Tab]<C-t> :<C-u>call tabutil#split()<CR>
nnoremap <silent> [Tab]<C-s> :<C-u>call tabutil#wsplit()<CR>
nnoremap <silent> [Tab]<C-v> :<C-u>call tabutil#vsplit()<CR>
nmap [Tab]m [Tab]<C-t>
nmap [Tab]; [Tab]<C-t>

nnoremap <silent> [Tab]r :<C-u>call tabutil#reorganize()<CR>
nnoremap <silent> [Tab]R :<C-u>call tabutil#reorganize1()<CR>

nnoremap <silent> [Tab]] :<C-u>tab tag <C-r>=expand("<cword>")<CR><CR>
nnoremap [Tab]f <C-w>gf
nnoremap [Tab]F <C-w>gF

nnoremap [Tab]c <C-w>c
nnoremap <Esc>h <C-w>h
nnoremap <Esc>j <C-w>j
nnoremap <Esc>k <C-w>k
nnoremap <Esc>l <C-w>l

nnoremap <silent> [Tab]. :<C-u>call scratch#toggle('tab')<CR>

nnoremap <expr> [Tab]<C-h> &ft =~ 'vim\<Bar>help'
\				? ":tab help "
\				: ":Ref -open=tabnew " . ref#detect() . ' '
nnoremap <expr> <C-h> &ft =~ 'vim\<Bar>help' ? ":help "
\					     : ":Ref " . ref#detect() .' '

nnoremap Q q
nnoremap q <Nop>

nnoremap q: q:
nnoremap q/ q/
nnoremap q? q?

nnoremap <silent> qq :<C-u>cc<CR>
nnoremap <silent> qn :<C-u>cnext<CR>
nnoremap <silent> qp :<C-u>cprevious<CR>
nnoremap <silent> qN :<C-u>clast<CR>
nnoremap <silent> qP :<C-u>cfirst<CR>
nnoremap <silent> ql :<C-u>clist<CR>
nnoremap <silent> qo :<C-u>colder<CR>
nnoremap <silent> qi :<C-u>cnewer<CR>
nnoremap <silent> qm :<C-u>make<CR>
nnoremap qM :<C-u>make<Space>
nnoremap qg :<C-u>grep<Space>
nnoremap <silent> <expr> q. (exists("g:qfixnr") ? ":cclose" : ":copen") . '<CR>'

nnoremap <expr> gc
\		'`[' .
\		['v','V'][(col("'[") == 1 && col("']") >= len(getline("']")))] .
\		'`]'
vnoremap <silent> gc :<C-u>normal gc<CR>
onoremap <silent> gc :<C-u>normal gc<CR>

nnoremap <silent> [Space]/ :<C-u>set hlsearch! hlsearch?<CR>
nnoremap <silent> [Space][ :<C-u>call <SID>toggle_fttag()<CR>
nnoremap <silent> [Space]z :<C-u>set spell! spell?<CR>
nnoremap <silent> [Space]s :sort<CR>
xnoremap <silent> [Space]s :sort<CR>
nnoremap <silent> [Space]V :<C-u>edit $HOME/.vimrc<CR>
nnoremap <silent> [Space]v :<C-u>source $HOME/.vimrc<CR>
nnoremap [Space]= `[=`]

for i in range(char2nr('a'), char2nr('z'))
    let c = nr2char(i)
    execute 'nnoremap <silent> [Space]"' . c . ' :<C-u>RegCopy ' . c . '<CR>'
endfor

cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <PageDown>
cnoremap <C-p> <PageUp>

inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
inoremap <C-u> <C-g>u<C-u>
inoremap <C-l> <C-o><C-l>
inoremap <expr> <C-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') .
\			       'v\%(\k\+\\|.\)')


"
" Auto commands
"
augroup vimrc-filetype
    au!
    au FileType python				setl fo-=t
    au FileType docbk,html,markdown,xhtml,xml	setl sw=2
    au FileType eruby,ruby,scheme,tex		setl sw=2
    au FileType mail				setl tw=72
    au FileType vimwiki				setl fo+=mM
augroup END

augroup vimrc-quickfix
    au!
    au BufWinEnter quickfix let g:qfixnr = bufnr("$")
    au BufWinLeave * if exists("g:qfixnr") && expand("<abuf>") == g:qfixnr |
    \			unlet! g:qfixnr | endif
augroup END

augroup vimrc-syntax
    au!
    au VimEnter    * call <SID>matchupdate('RedundantSpaces',
    \					   '\(\s\+$\| \+\ze\t\)')
    au InsertEnter * call <SID>matchupdate('RedundantSpaces',
    \					   '\(\s\+$\| \+\ze\t\)\%#\@!')
    au InsertLeave * call <SID>matchupdate('RedundantSpaces',
    \					   '\(\s\+$\| \+\ze\t\)')
augroup END

augroup vimrc-pdf
    au!
    au BufReadPost *pdf silent %!pdftotext -nopgbrk -layout "%" -
augroup END


"
" Plugins
"

" CSApprox
let g:CSApprox_verbose_level = 0

" NERD_commenter
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1

nmap <Leader>cc <Plug>NERDCommenterAlignLeft
vmap <Leader>c  <Plug>NERDCommenterComment
nmap <Leader>C  <Plug>NERDCommenterToEOL
vmap <Leader>C  <Plug>NERDCommenterAlignLeft
nmap <Leader>xm <Plug>NERDCommenterMinimal
nmap <Leader>xs <Plug>NERDCommenterSexy
vmap <Leader>xm <Plug>NERDCommenterMinimal
vmap <Leader>xs <Plug>NERDCommenterSexy
nmap <Leader>xa <Plug>NERDCommenterAltDelims
nmap <Leader>u  <Plug>NERDCommenterUncomment
vmap <Leader>u  <Plug>NERDCommenterUncomment

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
imap <C-a> <Plug>CapsLockToggle

" cecutil.vim
nmap [Tab]= <Plug>SaveWinPosn
nmap [Tab]- <Plug>RestoreWinPosn

" matchit.vim
source $VIMRUNTIME/macros/matchit.vim

" omnicppcomplete.vim
let g:OmniCpp_ShowPrototypeInAbbr = 1
let g:OmniCpp_MayCompleteArrow = 0
let g:OmniCpp_MayCompleteDot = 0
let g:OmniCpp_MayCompleteNamespace = 0
let g:OmniCpp_MayCompleteScope = 0
let g:OmniCpp_SelectFirstItem = 2

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

nnoremap <silent> K :<C-u>call <SID>ref('normal')<CR>
vnoremap <silent> K :<C-u>call <SID>ref('visual')<CR>

nmap [Tab]K K[Tab]m

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

" vcscommand.vim
let g:VCSCommandMapPrefix = '<Leader>v'

" vimwiki.vim
let g:vimwiki_list = [
\   { 'path': '~/vimwiki', 'path_html': '~/Web/wiki', 'auto_export': 1 }
\]
let g:vimwiki_badsyms = ' '
let g:vimwiki_hl_headers = 1


"
" Functions
"
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

function! GetRelativePath()
    let path = expand('%:~:.:h')
    return path == '.' ? '' : path . '/'
endfunction

function! s:tabclose()
    if scratch#is_visible()
	call scratch#close()
    else
	call tabutil#close()
    endif
endfunction

if !exists('s:matches')
    let s:matches = {}
endif
function! s:matchupdate(group, pattern)
    if has_key(s:matches, a:group)
	try
	    call matchdelete(s:matches[a:group])
	catch
	    return
	endtry
    endif

    let s:matches[a:group] = matchadd(a:group, a:pattern)
endfunction

function! s:toggle_fttag()
    let tags_file = '~/.vim/tags/' . &filetype . '.tags'
    let tags_save = &l:tags
    execute 'setl tags+=' . tags_file
    if tags_save == &l:tags
	execute 'setl tags-=' . tags_file
    endif
endfunction

function! s:ref(mode)
    if &filetype ==# 'vim'
	execute 'silent! help ' . expand("<cword>")
	if &filetype !=# 'help'
	    echo 'No entry'
	endif
    else
	call ref#K(a:mode)
    endif
endfunction


"
" Local settings
"
if filereadable($HOME . '/.vim/local.vim')
    source $HOME/.vim/local.vim
endif

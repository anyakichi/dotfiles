"
" dot.vimrc:
" 	Vim configuration
"

"
" Options
"
set backspace=indent,eol,start

set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp,utf-16,ucs-2le,ucs-2

set ambiwidth=double

set tabstop=8
set shiftwidth=4
set noexpandtab
set autoindent
set smartindent
set shiftround

set showcmd
set cursorline
set laststatus=2
set statusline=%!MakeStatusLine()
set tabline=%!MakeTabLine()

set nohlsearch
set ignorecase
set incsearch
set smartcase

set formatoptions=tcroqlmM
set textwidth=78

set background=dark
set display=lastline
set virtualedit=block

set splitbelow
set splitright
set winminheight=0

set nobackup
set directory=~/.vim/swap
set hidden

set timeout
set timeoutlen=3000
set ttimeoutlen=50

set history=1000
set wildmode=list:longest,full
set wildmenu

set cinoptions=>2s,e0,n0,f0,{0,}0,^0,:0,=2s,l1,b0,g2s,h2s,p2s,t0,
		\i2s,+1s,c1s,C0,/0,(0,u0,U0,w1,W0,m1,j1,)20,*30

set path=.,/usr/include,/usr/pkg/include,/usr/local/include

set completeopt=menuone

set clipboard& clipboard^=unnamed
set pastetoggle=<C-_>

if has("mouse")
    set mouse=a
endif

if has("path_extra")
    set tags=./tags;/
endif

let g:filetype_m = 'objc'

let ctagsprg = '/usr/pkg/bin/exctags'

filetype plugin indent on


"
" Syntax coloring
"
syntax on
if has("gui") && &t_Co == 256
    let g:CSApprox_hook_pre = 'hi Normal guifg=#d0d0d0 guibg=#262626'
    let g:CSApprox_hook_post = [
	\'exe "hi TabLine cterm=none ctermfg=fg ctermbg=" .
	    \g:CSApprox_approximator_function(0x33, 0x4b, 0x7d)',
	\'exe "hi TabLineFill cterm=none ctermfg=fg ctermbg=" .
	    \g:CSApprox_approximator_function(0x33, 0x4b, 0x7d)',
	\'hi TabLineSel cterm=bold ctermfg=fg ctermbg=bg']

    colorscheme moria
else
    colorscheme nya
endif


"
" Commands
"
command! -nargs=? -bang -bar -complete=help H tab help<bang> <args>
command! -nargs=1 -bar -complete=file T tabnew <args>
command! -nargs=1 -bar -complete=file V vnew <args>
command! -nargs=1 -bar -complete=file W new <args>


"
" Mappings
"
let g:maplocalleader = "[Space]"
nmap <Space> [Space]
xmap <Space> [Space]
nnoremap [Space] <Nop>
xnoremap [Space] <Nop>

nmap t [Tab]
nnoremap [Tab] <Nop>
nnoremap [Tab]; t

noremap Q gq
nnoremap Y y$
nnoremap ZQ <Nop>
nnoremap ZZ <Nop>

noremap j gj
noremap k gk
noremap gj j
noremap gk k

nnoremap dP dd"2P

nnoremap / /\v
nnoremap ? ?\v
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap <silent> <C-h> :<C-u>set hlsearch!<CR>

nnoremap [Tab]o :<C-u>edit<Space>
nnoremap <expr> [Tab]O ':<C-u>edit ' . GetRelativePath()
nnoremap <silent> [Tab]n :bnext<CR>
nnoremap <silent> [Tab]p :bprevious<CR>
nnoremap <silent> [Tab]D :<C-u>bdelete<CR>
nnoremap <silent> [Tab]l :<C-u>buffers<CR>

nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap [Tab]t :<C-u>tabnew<Space>
nnoremap <expr> [Tab]T ':<C-u>tabnew ' . GetRelativePath()
nnoremap <silent> [Tab]<CR> :<C-u>tabnew<CR>
nnoremap [Tab]h :<C-u>tab help<Space>
nnoremap <silent> [Tab]] :<C-u>tab tag <C-r>=expand("<cword>")<CR><CR>
nnoremap <silent> [Tab]d :<C-u>tabclose<CR>
nnoremap <silent> [Tab]m :<C-u>call MoveToNewTab()<CR>
nnoremap <silent> [Tab]M :<C-u>call MoveToNewWindow()<CR>
nmap	 [Tab]K <Leader>Ktm
nnoremap [Tab]gf <C-w>gf
nnoremap [Tab]gF <C-w>gF
for n in range(1, 9)
    exe 'nnoremap <silent> [Tab]' . n ' :<C-u>tabnext ' . n . '<CR>'
endfor

nnoremap [Tab]s :<C-u>split<Space>
nnoremap <expr> [Tab]S ':<C-u>split ' . GetRelativePath()
nnoremap [Tab]v :<C-u>vsplit<Space>
nnoremap <expr> [Tab]V ':<C-u>vsplit ' . GetRelativePath()
nnoremap [Tab]c <C-w>c
nnoremap <Esc>h <C-w>h
nnoremap <Esc>j <C-w>j
nnoremap <Esc>k <C-w>k
nnoremap <Esc>l <C-w>l

nnoremap <silent> [Space]v :<C-u>edit $HOME/.vimrc<CR>
nnoremap <silent> [Tab]<Space>v :<C-u>tabnew $HOME/.vimrc<CR>
nnoremap <silent> [Space]V :<C-u>source $HOME/.vimrc<CR>
nnoremap <silent> [Space]s :!sort<CR>
xnoremap <silent> [Space]s :!sort<CR>
nnoremap <silent> [Space]t :exe '!(cd %:p:h; ' . ctagsprg . ' *)&'<CR>

cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
inoremap <C-u> <C-g>u<C-u>


"
" Abbreviations
"
ab #C	Copyright (c) YEAR INAJIMA Daisuke All rights reserved.
ab #L	
\Permission is hereby granted, free of charge, to any person obtaining a<CR>
\copy of this software and associated documentation files (the "Software"),<CR>
\to deal in the Software without restriction, including without limitation<CR>
\the rights to use, copy, modify, merge, publish, distribute, sublicense,<CR>
\and/or sell copies of the Software, and to permit persons to whom the<CR>
\Software is furnished to do so, subject to the following conditions: <CR>
\<CR>
\The above copyright notice and this permission notice shall be included in<CR>
\all copies or substantial portions of the Software.<CR>
\<CR>
\THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<CR>
\IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,<CR>
\FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE<CR>
\AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<CR>
\LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING<CR>
\FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER<CR>
\DEALINGS IN THE SOFTWARE.
ab #B	
\Redistribution and use in source and binary forms, with or without<CR>
\modification, are permitted provided that the following conditions<CR>
\are met:<CR>
\1. Redistributions of source code must retain the above copyright<CR>
\   notice, this list of conditions and the following disclaimer.<CR>
\<BS><BS><BS>
\2. Redistributions in binary form must reproduce the above copyright<CR>
\   notice, this list of conditions and the following disclaimer in the<CR>
\<BS><BS><BS>
\   documentation and/or other materials provided with the distribution.<CR>
\<BS><BS><BS><CR>
\THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY<CR>
\EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED<CR>
\WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE<CR>
\DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY<CR>
\DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES<CR>
\(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR<CR>
\SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER<CR>
\CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT<CR>
\LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY<CR>
\OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF<CR>
\SUCH DAMAGE.
ab #P	
\This library is free software; you can redistribute it and/or modify<CR>
\it under the same terms as Perl itself. 


"
" Auto commands
"
augroup vimrc-filetype
    au!
    au FileType python					setl fo-=t
    au FileType docbk,eruby,html,ruby,tex,xhtml,xml	setl sw=2
    au FileType mail					setl tw=72
    au FileType scheme					setl sw=2
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

" autofmt.vim
set formatexpr=autofmt#japanese#formatexpr()
let g:autofmt_allow_over_tw = 2

" man.vim
runtime ftplugin/man.vim

" matchit.vim
source $VIMRUNTIME/macros/matchit.vim

" neocomplcache
let g:NeoComplCache_EnableAtStartup = 0
let g:NeoComplCache_MaxList = 10
let g:NeoComplCache_SmartCase = 1
let g:NeoComplCache_CtagsProgram = ctagsprg

" taglist.vim
let g:Tlist_Ctags_Cmd = ctagsprg

" tohtml.vim
let g:html_use_css = 1
let g:use_xhtml = 1

" vcscommand.vim
let g:VCSCommandMapPrefix = '<Leader>v'


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
    if path == '.'
	return ""
    else
	return path . '/'
    endif
endfunction

function! MoveToNewTab()
    tab split
    tabprevious

    if winnr('$') > 1
	close
    elseif bufnr('$') > 1
	buffer #
    endif

    tabnext
endfunction

function! MoveToNewWindow()
    let bufnr = bufnr('%')

    if winnr('$') > 1
	close
    elseif bufnr('$') > 1
	buffer #
    endif

    vnew
    let tmpnr = bufnr('%')

    execute 'buffer ' . bufnr
    execute 'bwipeout ' . tmpnr
endfunction


"
" Local settings
"
if filereadable($HOME . '/.vim/local.vim')
    source $HOME/.vim/local.vim
endif

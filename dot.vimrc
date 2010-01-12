"
" dot.vimrc:
" 	Vim configuration
"

set backspace=indent,eol,start

set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp,utf-16,ucs-2le,ucs-2

set tabstop=8
set shiftwidth=4
set noexpandtab
set autoindent
set smartindent
set shiftround

set winminheight=0

set showcmd
set laststatus=2
set statusline=%<%f\ %y%{'['.(&fenc!=''?&fenc:&enc).']'}%m%r%=%-14.(%l,%c%V%)\ %P
set cursorline

set nohlsearch
set ignorecase
set incsearch
set smartcase

set formatoptions=tcroqlmM
set textwidth=78

set ambiwidth=double

set nobackup

set cinoptions=>2s,e0,n0,f0,{0,}0,^0,:0,=2s,l1,b0,g2s,h2s,p2s,t0,
		\i2s,+1s,c1s,C0,/0,(0,u0,U0,w1,W0,m1,j1,)20,*30

set path=.,/usr/include,/usr/pkg/include,/usr/local/include

set completeopt=menuone

set pastetoggle=<C-_>

if has("cscope")
  set cscopetag
  set nocscopeverbose
  if filereadable("cscope.out")
    cs add cscope.out
  endif
  set cscopeverbose
endif

if has("path_extra")
  set tags=./tags;/
endif

let g:filetype_m = 'objc'
let g:maplocalleader = ";"

filetype plugin indent on


" Plugins

" NERD_commenter
let g:NERDSpaceDelims = 1
let g:NERDShutUp = 1

" a.vim
let g:alternateExtensions_H = "C,M,CPP,CXX,CC"
let g:alternateExtensions_h = "c,m,cpp,cxx,cc,CC"
let g:alternateExtensions_M = "H"
let g:alternateExtensions_m = "h"

" autofmt.vim
set runtimepath^=~/.vim/dist/autofmt
set formatexpr=autofmt#japanese#formatexpr()
let g:autofmt_allow_over_tw = 2

" matchit.vim
source $VIMRUNTIME/macros/matchit.vim

" neocomplcache
set runtimepath^=~/.vim/dist/neocomplcache
let g:NeoComplCache_EnableAtStartup = 1
let g:NeoComplCache_MaxList = 10
let g:NeoComplCache_SmartCase = 1

" taglist.vim
let Tlist_Ctags_Cmd = "/usr/pkg/bin/exctags"

" utl.vim
let g:utl_rc_app_browser = "silent !firefox '%u' &"

" vcscommand
set runtimepath^=~/.vim/dist/vcscommand


" Mappings

noremap Q gq
nnoremap Y y$

noremap j gj
noremap k gk

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

nmap <silent> <C-N> :set hlsearch!<CR>

cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>

inoremap <C-B> <Left>
inoremap <C-F> <Right>
inoremap <C-L> <Esc><C-L>a
inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>" : "\<CR>"

nmap ,v :new $HOME/.vimrc<CR>
nmap ,s :source $HOME/.vimrc<CR>

nmap ,t :!(cd %:p:h;exctags *)&<CR>

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

command! -nargs=1 Retab call Retab(<f-args>)
function! Retab(before)
    let s:tabstop = &tabstop
    let &tabstop = a:before
    execute "retab " s:tabstop
    unlet s:tabstop
endfunction

" Auto commands
autocmd FileType docbk,eruby,html,ruby,tex,xhtml,xml	setlocal sw=2
autocmd FileType mail					setlocal tw=72
autocmd FileType scheme setlocal sw=2


" Syntax coloring
syntax on
colorscheme nya

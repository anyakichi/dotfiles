"	$Id$

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

set formatoptions=croqlmM
set textwidth=78

set ambiwidth=double

set nobackup

set cinoptions=>2s,e0,n0,f0,{0,}0,^0,:0,=2s,l1,b0,g2s,h2s,p2s,t0,
		\i2s,+1s,c1s,C0,/0,(0,u0,U0,w1,W0,m1,j1,)20,*30

set path=.,/usr/include,/usr/pkg/include,/usr/local/include

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
  set tags=tags;/
endif

let maplocalleader = ";"

filetype plugin indent on


" Plugins

" EnhancedCommentify
let g:EnhCommentifyBindInInsert = "No"

" howm-mode.vim
let g:howm_dir = '~/howm'
let g:howm_findprg = "find"
let g:howm_grepprg = "grep"
let g:howm_instantpreview = 1

" matchit.vim
source $VIMRUNTIME/macros/matchit.vim

" taglist.vim
let Tlist_Ctags_Cmd = "/usr/pkg/bin/exctags"


" Mappings
noremap Q gq
nnoremap Y y$

noremap j gj
noremap k gk

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

nmap <silent> <C-N> :set hlsearch!<CR>

inoremap <C-B> <Left>
inoremap <C-F> <Right>
inoremap <C-L> <Esc><C-L>a

nmap ,v :new $HOME/.vimrc<CR>
nmap ,s :source $HOME/.vimrc<CR>

nmap ,t :!(cd %:p:h;exctags *)&<CR>

ab #C	Copyright (c) YEAR Inajima Daisuke All rights reserved.
ab #I	$Id$
ab #L	
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
\<BS><BS><BS>
\3. The name of the copyright holder may not be used to endorse or<CR>
\   promote products derived from this software without specific prior<CR>
\<BS><BS><BS>
\   written permission.<CR>
\<BS><BS><BS><CR>
\THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ``AS IS'' AND ANY EXPRESS<CR>
\OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED<CR>
\WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE<CR>
\DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY<CR>
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
colorscheme anyakichi

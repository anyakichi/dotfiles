"	$Id$

setlocal shiftwidth=2

" Browser setting for Mac OS X
noremap  <buffer> <LocalLeader>f :update<CR>:silent :!open $PWD/% &<CR><CR>

nnoremap <buffer> <LocalLeader>1	:s#\v^(\s*)(.*)$#\1<h1>\2</h1>#<CR>
nnoremap <buffer> <LocalLeader>2	:s#\v^(\s*)(.*)$#\1<h2>\2</h2>#<CR>
nnoremap <buffer> <LocalLeader>3	:s#\v^(\s*)(.*)$#\1<h3>\2</h3>#<CR>
nnoremap <buffer> <LocalLeader>4	:s#\v^(\s*)(.*)$#\1<h4>\2</h4>#<CR>
nnoremap <buffer> <LocalLeader>5	:s#\v^(\s*)(.*)$#\1<h5>\2</h5>#<CR>
nnoremap <buffer> <LocalLeader>p	:s#\v^(\s*)(.*)$#\1<p>\2</p>#<CR>
nnoremap <buffer> <LocalLeader>l	:s#\v^(\s*)(.*)$#\1<li>\2</li>#<CR>
nnoremap <buffer> <LocalLeader>dt	:s#\v^(\s*)(.*)$#\1<dt>\2</dt>#<CR>
nnoremap <buffer> <LocalLeader>dd	:s#\v^(\s*)(.*)$#\1<dd>\2</dd>#<CR>

inoremap <buffer> <LocalLeader>; ;
inoremap <buffer> <LocalLeader><Space> &nbsp;
inoremap <buffer> <LocalLeader>< &lt;
inoremap <buffer> <LocalLeader>> &gt;
inoremap <buffer> <LocalLeader>& &amp;
inoremap <buffer> <LocalLeader>br <br />
inoremap <buffer> <LocalLeader>hr <hr />
inoremap <buffer> <LocalLeader>1 <h1></h1><Esc>4hi
inoremap <buffer> <LocalLeader>2 <h2></h2><Esc>4hi
inoremap <buffer> <LocalLeader>3 <h3></h3><Esc>4hi
inoremap <buffer> <LocalLeader>4 <h4></h4><Esc>4hi
inoremap <buffer> <LocalLeader>5 <h5></h5><Esc>4hi
inoremap <buffer> <LocalLeader>p <p></p><Esc>3hi
inoremap <buffer> <LocalLeader>l <li></li><Esc>4hi
inoremap <buffer> <LocalLeader>o <ol><Esc>o</ol><Esc>O<Tab><li></li><Esc>F<i
inoremap <buffer> <LocalLeader>u <ul><Esc>o</ul><Esc>O<Tab><li></li><Esc>F<i
inoremap <buffer> <LocalLeader>dl <dl><Esc>o</dl><Esc>O
inoremap <buffer> <LocalLeader>dd <dd></dd><Esc>F<i
inoremap <buffer> <LocalLeader>dt <dt></dt><Esc>F<i
inoremap <buffer> <LocalLeader>ad <address></address><Esc>F<i
inoremap <buffer> <LocalLeader>ah <a href=""></a><Esc>F"i
inoremap <buffer> <LocalLeader>am <a href="mailto:"></a><Esc>F"i
inoremap <buffer> <LocalLeader>an <a name=""></a><Esc>F"i
inoremap <buffer> <LocalLeader>e <em></em><Esc>4hi
inoremap <buffer> <LocalLeader>s <strong></strong><Esc>8hi
inoremap <buffer> <LocalLeader>ta <table><Esc>o</table><Esc>O
inoremap <buffer> <LocalLeader>tr <tr><Esc>o</tr><Esc>O
inoremap <buffer> <LocalLeader>th <th></th><Esc>4hi
inoremap <buffer> <LocalLeader>td <td></td><Esc>4hi
inoremap <buffer> <LocalLeader>i <img src="" alt=""><Esc>8hi
inoremap <buffer> <LocalLeader>bq <blockquote><Esc>o</blokquote><Esc>O<C-T>
inoremap <buffer> <LocalLeader>C <!--  --><Esc>F<Space>i

vnoremap <buffer> <LocalLeader>1 "zdi<h1><C-R>z</h1><Esc>
vnoremap <buffer> <LocalLeader>2 "zdi<h2><C-R>z</h2><Esc>
vnoremap <buffer> <LocalLeader>3 "zdi<h3><C-R>z</h3><Esc>
vnoremap <buffer> <LocalLeader>4 "zdi<h4><C-R>z</h4><Esc>
vnoremap <buffer> <LocalLeader>5 "zdi<h5><C-R>z</h5><Esc>
vnoremap <buffer> <LocalLeader>p "zdi<p><C-R>z</p><Esc>
vnoremap <buffer> <LocalLeader>l "zdi<li><C-R>z</li><Esc>
vnoremap <buffer> <LocalLeader>dt "zdi<dt><C-R>z</dt><Esc>
vnoremap <buffer> <LocalLeader>dd "zdi<dd><C-R>z</dd><Esc>
vnoremap <buffer> <LocalLeader>ah "zdi<a href="" title="<C-R>z"><C-R>z</a><Esc>F";;i


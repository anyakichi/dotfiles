"
" filetype.vim:
" 	Vim script for filetype detection
"

au BufNewFile,BufRead ?\+.en,?\+.ja
	\ exe "doau filetypedetect BufRead " . fnameescape(expand("<afile>:r"))

au BufNewFile,BufRead dot.?\+
	\ exe "doau filetypedetect BufRead ." . fnameescape(expand("<afile>:e"))

au BufNewFile,BufRead ?\+_local
	\ exe "doau filetypedetect BufRead " .
	    \ fnameescape(substitute(expand("<afile>"), "_local$", "", ""))

au BufNewFile,BufRead *.erb				setf eruby

au BufNewFile,BufRead *.sieve				setf sieve

"
" filetype.vim:
" 	Vim script for filetype detection
"

au BufNewFile,BufRead ?\+.en,?\+.ja
	\ exe "doau filetypedetect BufRead " . expand("<afile>:r")

au BufNewFile,BufRead dot.?\+
	\ exe "doau filetypedetect BufRead " . expand("<afile>:e")

au BufNewFile,BufRead ?\+_local
	\ exe "doau filetypedetect BufRead " .
	    \ substitute(expand("<afile>"), "_local$", "", "")

au BufNewFile,BufRead *.erb				setf eruby

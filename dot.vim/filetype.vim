"	$Id$

au BufNewFile,BufRead ?\+.en,?\+.ja
	\ exe "doau filetypedetect BufRead " . expand("<afile>:r")

au BufNewFile,BufRead dot.*
	\ exe "doau filetypedetect BufRead " . expand("<afile>:e")

autocmd BufNewFile,BufRead *.erb		setfiletype eruby

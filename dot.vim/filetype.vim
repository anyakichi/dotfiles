au BufNewFile,BufRead ?\+.en,?\+.ja
	\ exe "doau filetypedetect BufRead " . expand("<afile>:r")

autocmd BufNewFile,BufRead *.erb		setfiletype eruby

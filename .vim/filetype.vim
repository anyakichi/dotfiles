"
" filetype.vim:
"       Vim script for filetype detection
"

au BufNewFile,BufRead ?\+.en,?\+.ja
\   execute "doau filetypedetect BufRead " . fnameescape(expand("<afile>:r"))

au BufNewFile,BufRead dot.?\+
\   execute "doau filetypedetect BufRead ." . fnameescape(expand("<afile>:e"))

au BufNewFile,BufRead ?\+.local
\   execute "doau filetypedetect BufRead " .
\       fnameescape(substitute(expand("<afile>"), ".local$", "", ""))

au BufNewFile,BufRead ?\+_local
\   execute "doau filetypedetect BufRead " .
\       fnameescape(substitute(expand("<afile>"), "_local$", "", ""))

au BufNewFile,BufRead *.sieve                   setf sieve
au BufNewFile,BufRead .shrc                     setf sh
au BufNewFile,BufRead */.zsh/functions/*        setf zsh

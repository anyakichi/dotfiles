" Cscope utility for vim.
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Revision: 0.1

if exists("loaded_csutil")
    finish
endif
let loaded_csutil = 1

if !has('cscope')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:csutil_map_prefix')
    let g:csutil_map_prefix = '<C-\>'
endif

augroup csutil
    au!
    au FileType asm,c,cpp,lex,yacc call csutil#init()
augroup END

let &cpo = s:save_cpo

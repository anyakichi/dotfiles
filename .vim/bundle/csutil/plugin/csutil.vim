" Cscope utility for vim.
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Revision: 0.2

if exists("loaded_csutil")
    finish
endif
let loaded_csutil = 1

if !has('cscope')
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

nnoremap <unique> <script> <Plug>(csutil-toggle-cst)
\	 :<C-u>set cst! <Bar> set cst?<CR>
nnoremap <unique> <script> <Plug>(csutil-find-s)
\	 :<C-u>cs find s <C-r>=expand('<cword>')<CR><CR>
nnoremap <unique> <script> <Plug>(csutil-find-g)
\	 :<C-u>cs find g <C-r>=expand('<cword>')<CR><CR>
nnoremap <unique> <script> <Plug>(csutil-find-d)
\	 :<C-u>cs find d <C-r>=expand('<cword>')<CR><CR>
nnoremap <unique> <script> <Plug>(csutil-find-c)
\	 :<C-u>cs find c <C-r>=expand('<cword>')<CR><CR>
nnoremap <unique> <script> <Plug>(csutil-find-t)
\	 :<C-u>cs find t <C-r>=expand('<cword>')<CR><CR>
nnoremap <unique> <script> <Plug>(csutil-find-e)
\	 :<C-u>cs find e <C-r>=expand('<cword>')<CR><CR>
nnoremap <unique> <script> <Plug>(csutil-find-f)
\	 :<C-u>cs find f <C-r>=expand('<cfile>')<CR><CR>
nnoremap <unique> <script> <Plug>(csutil-find-i)
\	 :<C-u>cs find i ^<C-r>=expand('<cfile>')<CR>$<CR>

if !exists('g:csutil_map_prefix')
    let g:csutil_map_prefix = '<C-\>'
endif

if !exists("g:csutil_no_default_mappings") || !g:csutil_no_default_mappings
    let mapping = g:csutil_map_prefix . g:csutil_map_prefix
    execute 'nmap' mapping '<Plug>(csutil-toggle-cst)'
    for type in ['s', 'g', 'd', 'c', 't', 'e', 'f', 'i']
	let mapping = g:csutil_map_prefix . type
	let target = '<Plug>(csutil-find-' . type . ')'
	execute 'nmap' mapping target
    endfor
endif

augroup csutil
    autocmd!
    autocmd BufEnter * call csutil#load()
    autocmd BufLeave * call csutil#unload()
augroup END

let &cpo = s:cpo_save

if exists('b:did_ftplugin_after')
    finish
endif
let b:did_ftplugin_after = 1

call ocpindex#init()

setlocal shiftwidth=2
setlocal comments=fb:(**,fb:(*
setlocal commentstring=(*%s*)

nmap <buffer> K         <Plug>(ocpindex-echo-type)
nmap <buffer> <C-]>     <Plug>(ocpindex-jump)
nmap <buffer> <C-t>     <Plug>(ocpindex-jump-back)

inoremap <buffer> <silent> *     <C-r>=<SID>asterisk()<CR>
inoremap <buffer> <silent> <BS>  <C-r>=<SID>backspace()<CR>
inoremap <buffer> <silent> <C-h> <C-r>=<SID>backspace()<CR>

if exists('g:did_ftplugin_ocaml_after')
    finish
endif
let g:did_ftplugin_ocaml_after = 1

function! s:asterisk()
    if strpart(getline('.'), col('.') - 2, 2) == '()'
        return "**\<Left>"
    endif
    return "*"
endfunction

function! s:backspace()
    if strpart(getline('.'), col('.') - 3, 4) == '(**)'
        return "\<BS>\<Del>"
    endif
    return autoclose#delete()
endfunction

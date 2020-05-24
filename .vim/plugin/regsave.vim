if exists("g:loaded_regsave")
    finish
endif
let g:loaded_regsave = 1

let s:cpo_save = &cpo
set cpo&vim

command! -nargs=1 RegSave call s:regsave(<q-args>)

function! s:regsave(reg)
    if a:reg ==# '&'
        call {fakeclip#_sid_prefix()}write_pastebuffer(@@)
    else
        execute 'let' '@'.a:reg '= @@'
    endif
endfunction

let &cpo = s:cpo_save

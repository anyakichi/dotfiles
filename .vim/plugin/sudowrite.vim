if exists("g:loaded_sudowrite")
    finish
endif
let g:loaded_sudowrite = 1

let s:cpo_save = &cpo
set cpo&vim

command! -nargs=* -bang W call s:sudowrite(<bang>0, <f-args>)

function! s:sudowrite(bang, ...)
    if a:0 == 0
        let file = expand("%")
    elseif a:0 == 1
        let file = a:1
    else
        echohl ErrorMsg
        echo 'Only one file name allowed'
        echohl None
        return
    endif

    if !a:bang && confirm("Write with sudo?", "&Yes\n&No") == 2
        return
    endif

    execute 'w !sudo tee "' . file . '" >/dev/null'
endfunction

let &cpo = s:cpo_save

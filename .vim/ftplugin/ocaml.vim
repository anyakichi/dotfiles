setlocal shiftwidth=2
setlocal comments=s1:(*,mb:*,ex:*)
setlocal commentstring=(*%s*)

inoremap <silent> *     <C-r>=<SID>asterisk()<CR>
inoremap <silent> <BS>  <C-r>=<SID>backspace()<CR>
inoremap <silent> <C-h> <C-r>=<SID>backspace()<CR>

function! s:asterisk()
    if strpart(getline('.'), col('.') - 3, 4) == '(**)'
        return "\<CR>\<C-w>\<C-o>:redraw\<CR>\<Esc>O"
    elseif strpart(getline('.'), col('.') - 2, 2) == '()'
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

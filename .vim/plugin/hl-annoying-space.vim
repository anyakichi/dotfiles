if exists("g:loaded_hl_annoying_space")
    finish
endif
let g:loaded_hl_annoying_space = 1

let s:cpo_save = &cpo
set cpo&vim

augroup hl-annoying-space
    autocmd!

    autocmd VimEnter,InsertLeave *
    \   call s:matchupdate('_RedundantSpace', '\(\s\+$\| \+\ze\t\)')
    autocmd InsertEnter *
    \   call s:matchupdate('_RedundantSpace', '\(\s\+$\| \+\ze\t\)\%#\@!')
    autocmd BufEnter *
    \   if &expandtab
    \|      call s:matchupdate('_TabSpace', '\t')
    \|  else
    \|      call s:matchupdate('_TabSpace', '        ')
    \|  endif
augroup END

function! s:matchdelete(group)
    for match in getmatches()
        if match['group'] ==# a:group
            call matchdelete(match['id'])
            return 1
        endif
    endfor
    return 0
endfunction

function! s:matchupdate(group, pattern)
    call s:matchdelete(a:group)
    call matchadd(a:group, a:pattern)
endfunction

function! s:enable()
    let g:hl_annoying_space_enabled = 1

    highlight link _IdeographicSpace IdeographicSpace
    highlight link _RedundantSpace RedundantSpace
    highlight link _TabSpace TabSpace
endfunction

function! s:disable()
    let g:hl_annoying_space_enabled = 0

    highlight link _IdeographicSpace Normal
    highlight link _RedundantSpace Normal
    highlight link _TabSpace Normal
endfunction

function! s:toggle()
    if g:hl_annoying_space_enabled == 1
        call s:disable()
    else
        call s:enable()
    endif
endfunction

highlight default AnnoyingSpace ctermbg=236 guibg=#303030
highlight default link IdeographicSpace AnnoyingSpace
highlight default link RedundantSpace AnnoyingSpace
highlight default link TabSpace AnnoyingSpace

call s:enable()

match _IdeographicSpace /　/

command! -nargs=0 -bar HlAnnoyingSpaceEnable call s:enable()
command! -nargs=0 -bar HlAnnoyingSpaceDisable call s:disable()
command! -nargs=0 -bar HlAnnoyingSpaceToggle call s:toggle()

let &cpo = s:cpo_save

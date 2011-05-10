" Scratch buffer

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:scratch_filetype')
    let g:scratch_filetype = 'vim'
endif

let s:scratch_bufnr = -1

function! scratch#open(mod)
    if !bufexists(s:scratch_bufnr)
	execute a:mod "split `='[Scratch]'`"
	let s:scratch_bufnr = bufnr('%')
	setlocal bufhidden=hide buftype=nofile nobuflisted noswapfile
	let &filetype = g:scratch_filetype
    else
	if scratch#is_scratch()
	    return
	endif

	if scratch#is_visible()
	    execute bufwinnr(s:scratch_bufnr) . 'wincmd w'
	    return
	endif

	for tabnr in range(1, tabpagenr('$'))
	    if index(tabpagebuflist(tabnr), s:scratch_bufnr) >= 0
		execute 'tabnext ' . tabnr
		execute bufwinnr(s:scratch_bufnr) . 'wincmd w'
		return
	    endif
	endfor

	execute a:mod 'sbuffer ' . s:scratch_bufnr
    endif
endfunction

function! scratch#close(mod)
    if scratch#is_visible()
	if a:mod == 'tab'
	    tabclose
	else
	    execute bufwinnr(s:scratch_bufnr) . 'wincmd w'
	    close
	endif
    endif
endfunction

function! scratch#toggle(mod)
    if scratch#is_scratch()
	call scratch#close(a:mod)
    else
	call scratch#open(a:mod)
    endif
endfunction

function! scratch#is_scratch()
    return bufnr('%') == s:scratch_bufnr
endfunction

function! scratch#is_visible()
    return bufwinnr(s:scratch_bufnr) != -1
endfunction

let &cpo = s:save_cpo

" Cscope utility for vim.
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Revision: 0.1

function! csutil#init()
    if exists("b:csutil_dbdir")
	return
    endif

    let cscope_db = findfile("cscope.out", ".;")
    if cscope_db == ''
	return
    endif

    let b:csutil_dbdir = fnamemodify(cscope_db, ":p:h")

    if g:csutil_map_prefix != ''
	let map = "nnoremap <unique> <buffer> " . g:csutil_map_prefix

	execute map . g:csutil_map_prefix . " :<C-u>set cst! <Bar> set cst?<CR>"
	execute map . "s :<C-u>cs find s <C-r>=expand('<cword>')<CR><CR>"
	execute map . "g :<C-u>cs find g <C-r>=expand('<cword>')<CR><CR>"
	execute map . "d :<C-u>cs find d <C-r>=expand('<cword>')<CR><CR>"
	execute map . "c :<C-u>cs find c <C-r>=expand('<cword>')<CR><CR>"
	execute map . "t :<C-u>cs find t <C-r>=expand('<cword>')<CR><CR>"
	execute map . "e :<C-u>cs find e <C-r>=expand('<cword>')<CR><CR>"
	execute map . "f :<C-u>cs find f <C-r>=expand('<cfile>')<CR><CR>"
	execute map . "i :<C-u>cs find i ^<C-r>=expand('<cfile>')<CR>$<CR>"
    endif

    augroup csutil_buffer
	au! * <buffer>
	au BufEnter <buffer> call csutil#load()
	au BufLeave <buffer> call csutil#unload()
    augroup END
endfunction

function! csutil#load()
    if cscope_connection(3, "out", b:csutil_dbdir)
	return
    endif

    let csverb_save = &csverb
    set nocsverb
    execute "cscope add " . b:csutil_dbdir . "/cscope.out " . b:csutil_dbdir
    let &csverb = csverb_save
endfunction

function! csutil#unload()
    if !cscope_connection(3, "out", b:csutil_dbdir)
	return
    endif

    let csverb_save = &csverb
    set nocsverb
    execute "cscope kill " . b:csutil_dbdir
    let &csverb = csverb_save
endfunction

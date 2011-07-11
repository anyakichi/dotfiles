" Cscope utility for vim.
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Revision: 0.2

let s:cpo_save = &cpo
set cpo&vim

function! csutil#load()
    if !exists("b:csutil_dbdir")
	let cscope_db = findfile("cscope.out", ".;")
	if cscope_db == ''
	    return
	endif
	let b:csutil_dbdir = fnamemodify(cscope_db, ":p:h")
    endif

    if cscope_connection(3, "out", b:csutil_dbdir)
	return
    endif

    let csverb_save = &csverb
    set nocsverb
    execute "cscope add " . b:csutil_dbdir . "/cscope.out " . b:csutil_dbdir
    let &csverb = csverb_save
endfunction

function! csutil#unload()
    if !exists("b:csutil_dbdir")
	return
    endif

    if !cscope_connection(3, "out", b:csutil_dbdir)
	return
    endif

    let csverb_save = &csverb
    set nocsverb
    execute "cscope kill " . b:csutil_dbdir
    let &csverb = csverb_save
endfunction

let &cpo = s:cpo_save

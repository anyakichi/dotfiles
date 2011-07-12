" Cscope utility for vim.
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Revision: 0.3

let s:cpo_save = &cpo
set cpo&vim

let s:csutil_dbdir = ""

function! csutil#setup()
    let cscope_db = findfile("cscope.out", ".;")
    let cscope_dbdir = cscope_db == '' ? '' : fnamemodify(cscope_db, ":p:h")

    if s:csutil_dbdir == cscope_dbdir
	return
    endif

    let csverb_save = &csverb
    set nocsverb

    if s:csutil_dbdir != ''
	execute 'cscope' 'kill' s:csutil_dbdir
    endif

    if cscope_dbdir != ''
	execute 'cscope' 'add' cscope_dbdir . "/cscope.out" cscope_dbdir
    endif

    let &csverb = csverb_save
    let s:csutil_dbdir = cscope_dbdir
endfunction

let &cpo = s:cpo_save

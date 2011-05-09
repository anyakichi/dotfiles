" Automatically close pairs.
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Version: 0.1

if (exists("g:loaded_autoclose"))
    finish
endif
let g:loaded_autoclose = 1

let s:cpo_save = &cpo
set cpo&vim

let s:autoclose_enabled = 0

command! -nargs=? AutoClose :call <SID>autoclose(<f-args>)

function! s:autoclose(...)
    if a:0 == 0
	let enable = !s:autoclose_enabled
    else
	let enable = !(a:1 == '0' || a:1 =~ 'off')
    endif

    if enable == s:autoclose_enabled
	return
    endif

    if enable
	for key in keys(g:autoclose_pairs)
	    let val = g:autoclose_pairs[key]

	    if key == val
		let kv = (key == '"' ? '\"' : key)
		exec 'inoremap <silent> ' . key .
		    \' <C-r>=autoclose#quote("' . kv . '")<CR>'
	    else
		if index(g:autoclose_expand_chars, key) >= 0
		    execute 'inoremap <silent> ' . key .
		    \	    ' <C-r>=autoclose#expand("' . key . '")<CR>'
		    execute 'inoremap <silent> ' . val .
		    \	    ' <C-r>=autoclose#shrink("' . val . '")<CR>'
		else
		    execute 'inoremap <silent> ' . key .
		    \	    ' <C-r>=autoclose#open("' . key . '")<CR>'
		    execute 'inoremap <silent> ' . val .
		    \	    ' <C-r>=autoclose#close("' . val . '")<CR>'
		endif
	    endif
	endfor
	for c in g:autoclose_tag_chars
	    execute 'inoremap <silent> '.c.' <C-r>=autoclose#open_tag("'.c.'")<CR>'
	endfor
	inoremap <silent> < <C-r>=autoclose#close_tag('<')<CR>
	inoremap <silent> <BS>  <C-r>=autoclose#delete()<CR>
	inoremap <silent> <C-h> <C-r>=autoclose#delete()<CR>

	let s:autoclose_enabled = 1
        echo "AutoClose ON"
    else
	for key in keys(g:autoclose_pairs)
	    let val = g:autoclose_pairs[key]

	    if key == val
		exec 'iunmap ' . key
	    else
		exec 'iunmap ' . key
		exec 'iunmap ' . val
	    endif
	endfor
	for c in g:autoclose_tag_chars
	    execute 'iunmap ' . c
	endfor
	iunmap <BS>
	iunmap <C-H>

	let s:autoclose_enabled = 0
        echo "AutoClose OFF"
    endif
endfunction

if !exists("g:autoclose_pairs")
    let g:autoclose_pairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", "`": "`"}
endif

if !exists("g:autoclose_expand_chars")
    let g:autoclose_expand_chars = ['{']
endif

if !exists("g:autoclose_tag_chars")
    let g:autoclose_tag_chars = ['>']
endif

if !exists("g:autoclose_rules")
    let g:autoclose_rules = {"_": function("autoclose#default_rule")}
endif

if !exists("g:autoclose_quoted_regions")
    let g:autoclose_quoted_regions = {}
endif
if !has_key(g:autoclose_quoted_regions, "_")
    let g:autoclose_quoted_regions['_'] = ["Character", "SpecialChar", "String"]
endif

silent call s:autoclose(1)

let &cpo = s:cpo_save

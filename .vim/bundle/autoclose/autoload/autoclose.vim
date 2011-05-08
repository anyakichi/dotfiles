" Automatically close pairs.
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Version: 0.1

let s:cpo_save = &cpo
set cpo&vim

let s:running = 0

function! s:getlc(offset)
    let i = col('.') - 1 + a:offset
    return i < 0 ? '' : getline('.')[i]
endfunction

function! s:get_syn_name(off)
    let col = col('.') + a:off
    return synIDattr(synID(line('.'), col, 1), 'name')
endfunction

function! s:get_syngr_name(off)
    let col = col('.') + a:off
    return synIDattr(synIDtrans(synID(line('.'), col, 1)), 'name')
endfunction

function! s:get_syngr_name_after(str, off)
    let line = getline('.')
    let tmp = line[:col('.')-2] . a:str . line[col('.')-1:]
    call setline('.', tmp)
    let region = s:get_syngr_name(a:off)
    call setline('.', line)
    redraw
    return region
endfunction

function! autoclose#is_empty()
    let prev = s:getlc(-1)
    let next = s:getlc(0)

    return !empty(prev) && !empty(next) &&
    \      get(g:autoclose_pairs, prev, "") == next
endfunction

function! autoclose#is_empty_ex()
    let prevline = getline(line('.') - 1)
    let nextline = getline(line('.') + 1)

    if empty(prevline) || empty(nextline)
	return 0
    endif

    let prev = prevline[len(prevline) - 1]
    let next = nextline[len(nextline) - 1]

    if empty(prev) || empty(next) || prevline !~ "^\\s*" . prev . "$"
	return 0
    endif

    let curline = getline('.')

    return curline =~ "^\\s*$" && get(g:autoclose_pairs, prev, "") == next
endfunction

function! autoclose#is_forbidden(char)
    let Func = function("autoclose#not_forbidden")
    let Func1 = get(g:autoclose_forbidden, "_", Func)
    let Func2 = get(g:autoclose_forbidden, a:char, Func)

    return call(Func1, [a:char]) || call(Func2, [a:char])
endfunction

function! autoclose#pair(char)
    if index(g:autoclose_expand_chars, a:char) >= 0
	return autoclose#expand(a:char)
    elseif has_key(g:autoclose_pairs, a:char)
	return autoclose#insert(a:char)
    endif

    for key in keys(g:autoclose_pairs)
	if g:autoclose_pairs[key] == a:char
	    if index(g:autoclose_expand_chars, key) >= 0
		return autoclose#shrink(a:char)
	    endif
	    return autoclose#close(a:char)
	endif
    endfor

    return a:char
endfunction

function! autoclose#quote(char)
    let type = has_key(g:autoclose_quoted_regions, &ft) ? &ft : "_"
    let regions = g:autoclose_quoted_regions[type]

    if index(regions, s:get_syngr_name(0)) >= 0 ||
    \  index(regions, s:get_syngr_name_after(' ', 0)) >= 0
	return autoclose#close(a:char)
    endif

    let dummy = a:char . ' ' . a:char
    if index(regions, s:get_syngr_name_after(dummy, 1)) >= 0
	return autoclose#insert(a:char)
    endif

    return a:char
endfunction

function! autoclose#tag(char)
    let region = synIDattr(synID(line("."), col(".") - 1, 1), "name")
    if match(region, "xmlProcessing") == -1 &&
		\  match(region, 'docbk\|html\|xml') == 0
	if s:getlc(-1) == '>'
	    return "\<CR>\<Esc>O"
	elseif s:getlc(-1) != '/'
	    let pos_save = getpos('.')
	    let reg_save = getreg('a')

	    call search('<', 'bW')
	    execute 'normal! l"ayiw'
	    let close_tag = '</' . getreg('a') . '>'

	    call setreg('a', reg_save)
	    call setpos('.', pos_save)

	    return '>' . close_tag . repeat("\<Left>", len(close_tag))
	endif
    endif

    return a:char
endfunction

function! autoclose#insert(char)
    if autoclose#is_forbidden(a:char)
	return a:char
    endif
    return a:char . g:autoclose_pairs[a:char] . "\<Left>"
endfunction

function! autoclose#close(char)
    if s:getlc(0) == a:char
	return "\<Right>" 
    endif
    return a:char
endfunction

function! autoclose#expand(char)
    if s:getlc(-2) == a:char && s:getlc(-1) == a:char && autoclose#is_empty()
	let indent = matchstr(getline('.'), "^\\s\\+")
	return "\<CR>0\<C-d>" . indent . "\<Esc>O"
    endif

    if s:getlc(-1) == a:char && autoclose#is_empty()
	return "\<CR>\<Esc>O"
    endif

    if autoclose#is_empty_ex()
	let cchar = g:autoclose_pairs[a:char]
	let pair = a:char . a:char . cchar . cchar
	return "\<Esc>ddkJxi" . pair . "\<Left>\<Left>"
    endif

    return autoclose#insert(a:char)
endfunction

function! autoclose#shrink(char)
    if s:getlc(-1) == a:char && getline(line('.')) == getline(line('.') + 1)
	return "\<Esc>ddA"
    endif
    return autoclose#close(a:char)
endfunction

function! autoclose#delete()
    if autoclose#is_empty()
        return "\<BS>\<Del>"
    endif    
    return "\<BS>"
endfunction

function! autoclose#not_forbidden(char)
    return 0
endfunction

function! autoclose#forbidden_default(char)
    let prev = s:getlc(-1)
    let next = s:getlc(0)

    return prev ==# '\' || (next != "" && next =~ '\w') ||
	    \s:get_syngr_name_after(a:char, 0) ==# "Character"
endfunction

function! autoclose#enable(yesno)
    if a:yesno && !s:running
	for key in keys(g:autoclose_pairs)
	    let val = g:autoclose_pairs[key]

	    if key == val
		let kv = (key == '"' ? '\"' : key)
		exec 'inoremap <silent> ' . key .
		    \' <C-R>=autoclose#quote("' . kv . '")<CR>'
	    else
		exec 'inoremap <silent> ' . key .
		    \' <C-R>=autoclose#pair("' . key . '")<CR>'
		exec 'inoremap <silent> ' . val .
		    \' <C-R>=autoclose#pair("' . val . '")<CR>'
	    endif
	endfor
	for c in g:autoclose_tag_chars
	    execute 'inoremap <silent> '.c.' <C-r>=autoclose#tag("'.c.'")<CR>'
	endfor
	inoremap <expr> <BS>  autoclose#delete()
	inoremap <expr> <C-H> autoclose#delete()

	let s:running = 1
    elseif !a:yesno && s:running
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

	let s:running = 0
    endif
endfunction

function! autoclose#toggle()
    if s:running
        echo "AutoClose OFF"
	call autoclose#enable(0)
    else
        echo "AutoClose ON"
	call autoclose#enable(1)
    endif
endfunction

function! autoclose#autoclose(...)
    if a:0 == 0
	call autoclose#toggle()
    else
	if a:1 == '0' || a:1 =~ 'off'
	    call autoclose#enable(0)
	else
	    call autoclose#enable(1)
	endif
    endif
endfunction

let &cpo = s:cpo_save

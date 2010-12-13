" AutoClose.vim - Automatically close pair of characters: ( with ), [ with ], { with }, etc.
" Version: 1.1
" Author: Thiago Alves <thiago.salves@gmail.com>
" Maintainer: Thiago Alves <thiago.salves@gmail.com>
" URL: http://thiagoalves.org
" Licence: This script is released under the Vim License.
" Last modified: 08/25/2008 

if (exists("g:loaded_autoclose"))
    finish
endif
let g:loaded_autoclose = 1

let s:cpo_save = &cpo
set cpo&vim

function s:getlc(offset)
    let l:i = col('.') - 1 + a:offset

    if l:i < 0
	return ''
    endif
    return getline('.')[l:i]
endfunction

function s:getSynName()
    return synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
endfunction

function! s:GetCurrentSyntaxRegionIf(char)
    let l:line = getline('.')
    let l:line_tmp = l:line[:col('.')-2] . a:char . l:line[col('.')-1:]
    call setline('.', l:line_tmp)
    let l:region = s:getSynName()
    call setline('.', l:line)
    return l:region
endfunction

function! s:IsEmptyPair()
    let l:prev = s:getlc(-1)
    let l:next = s:getlc(0)

    return !empty(l:prev) && !empty(l:next) &&
	    \get(g:AutoClosePairs, l:prev, "") == l:next
endfunction

function! s:IsEmptyExpandedPair()
    let prevline = getline(line('.') - 1)
    let nextline = getline(line('.') + 1)

    if empty(prevline) || empty(nextline)
	return 0
    endif

    let prev = prevline[len(prevline) - 1]
    let next = nextline[len(nextline) - 1]

    if empty(prev) || empty(next)
	return 0
    endif

    let curline = getline('.')

    return curline =~ "^\\s*$" && get(g:AutoClosePairs, prev, "") == next
endfunction

function! s:IsForbidden(char)
    let Func1 = get(g:AutoCloseForbidden, "ALL", function("s:NotForbidden"))
    let Func2 = get(g:AutoCloseForbidden, a:char, function("s:NotForbidden"))

    return call(Func1, [a:char]) || call(Func2, [a:char])
endfunction

function! s:AutoClose(char)
    if a:char == "'" || a:char == '"'
	let type = has_key(g:AutoCloseQuotedRegions, &ft) ? &ft : "default"
	let l:regions = g:AutoCloseQuotedRegions[type]

	if index(l:regions, s:getSynName()) >= 0 ||
	  \index(l:regions, s:GetCurrentSyntaxRegionIf(' ')) >= 0
	    return s:ClosePair(a:char)
	endif

	let l:dummy = a:char . ' ' . a:char
	if index(l:regions, s:GetCurrentSyntaxRegionIf(l:dummy)) >= 0
	    return s:InsertPair(a:char)
	endif

	return a:char
    endif

    if index(g:AutoExpandChars, a:char) >= 0
	return s:ExpandPair(a:char)
    elseif has_key(g:AutoClosePairs, a:char)
	return s:InsertPair(a:char)
    endif

    for key in keys(g:AutoClosePairs)
	if g:AutoClosePairs[key] == a:char
	    if index(g:AutoExpandChars, key) >= 0
		return s:ShrinkPair(a:char)
	    endif
	    return s:ClosePair(a:char)
	endif
    endfor

    return a:char
endfunction

function! s:InsertPair(char)
    if s:IsForbidden(a:char)
	return a:char
    endif
    return a:char . g:AutoClosePairs[a:char] . "\<Left>"
endfunction

function! s:ClosePair(char)
    if s:getlc(0) == a:char
	return "\<Right>" 
    endif
    return a:char
endfunction

function! s:ExpandPair(char)
    if s:getlc(-2) == a:char && s:getlc(-1) == a:char && s:IsEmptyPair()
	let indent = matchstr(getline('.'), "^\\s\\+")
	return "\<CR>0\<C-d>" . indent . "\<Esc>O"
    endif

    if s:getlc(-1) == a:char && s:IsEmptyPair()
	return "\<CR>\<Esc>O"
    endif

    if s:IsEmptyExpandedPair()
	let cchar = g:AutoClosePairs[a:char]
	let pair = a:char . a:char . cchar . cchar
	return "\<Esc>ddkJxi" . pair . "\<Left>\<Left>"
    endif

    return s:InsertPair(a:char)
endfunction

function! s:ShrinkPair(char)
    let l:line = line('.')

    if s:getlc(-1) == a:char && getline(l:line) == getline(l:line + 1)
	return "\<Esc>ddA"
    endif
    return s:ClosePair(a:char)
endfunction

function! s:DeletePair()
    if s:IsEmptyPair()
        return "\<BS>\<Del>"
    endif    
    return "\<BS>"
endfunction

function! s:NotForbidden(char)
    return 0
endfunction

function! s:forbiddenAll(char)
    let l:prev = s:getlc(-1)
    let l:next = s:getlc(0)

    return l:prev ==# '\' || (l:next != "" && l:next =~ '\w') ||
	    \s:GetCurrentSyntaxRegionIf(a:char) ==# "Character"
endfunction

function! s:AutoCloseEnable(yesno)
    if a:yesno
	for key in keys(g:AutoClosePairs)
	    let val = g:AutoClosePairs[key]

	    if key == val
		let kv = (key == '"' ? '\"' : key)
		exec 'inoremap <silent> ' . key .
		    \' <C-R>=<SID>AutoClose("' . kv . '")<CR>'
	    else
		exec 'inoremap <silent> ' . key .
		    \' <C-R>=<SID>AutoClose("' . key . '")<CR>'
		exec 'inoremap <silent> ' . val .
		    \' <C-R>=<SID>AutoClose("' . val . '")<CR>'
	    endif
	endfor
	inoremap <expr> <BS>  <SID>DeletePair()
	inoremap <expr> <C-H> <SID>DeletePair()

	let s:running = 1
    else
	for key in keys(g:AutoClosePairs)
	    let val = g:AutoClosePairs[key]

	    if key == val
		exec 'iunmap ' . key
	    else
		exec 'iunmap ' . key
		exec 'iunmap ' . val
	    endif
	endfor
	iunmap <BS>
	iunmap <C-H>

	let s:running = 0
    endif
endfunction

function! s:ToggleAutoClose()
    if s:running
        echo "AutoClose OFF"
	s:AutoCloseEnable(0)
    else
        echo "AutoClose ON"
	s:AutoCloseEnable(1)
    endif
endfunction

"
" Configuration
"
if !exists("g:AutoClosePairs") || type(g:AutoClosePairs) != type({})
    let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'"}
endif

if !exists("g:AutoExpandChars") || type(g:AutoExpandChars) != type([])
    let g:AutoExpandChars = ['{']
endif

if !exists("g:AutoCloseForbidden") || type(g:AutoCloseForbidden) != type({})
    let g:AutoCloseForbidden = { "ALL": function("s:forbiddenAll") }
endif

if !exists("g:AutoCloseQuotedRegions") ||
	\type(g:AutoCloseQuotedRegions) != type({})
    let g:AutoCloseQuotedRegions = {
	\"c": ["Character", "Constant", "Special", "SpecialChar", "String"] }
endif
if !has_key(g:AutoCloseQuotedRegions, "default")
    let g:AutoCloseQuotedRegions['default'] =
	\["Character", "SpecialChar", "String"]
endif

if exists("g:AutoCloseOn") && type(g:AutoCloseOn) == type(0)
    call s:AutoCloseEnable(g:AutoCloseOn)
    unlet g:AutoCloseOn
else
    call s:AutoCloseEnable(1)
endif

command! AutoCloseOn :call s:AutoCloseEnable(1)
command! AutoCloseOff :call s:AutoCloseEnable(0)
command! AutoCloseToggle :call s:ToggleAutoClose()

let &cpo = s:cpo_save

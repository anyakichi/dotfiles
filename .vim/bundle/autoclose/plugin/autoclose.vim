" Automatically close pairs.
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Version: 0.1

if (exists("g:loaded_autoclose"))
    finish
endif
let g:loaded_autoclose = 1

let s:cpo_save = &cpo
set cpo&vim

" set SpecialChar, String, Character highlight if they are not set.
for synpair in [["SpecialChar", "Special"], ["String", "Constant"],
	       \["Character", "Constant"]]
    if synIDtrans(hlID(synpair[0])) == hlID(synpair[1])
	let dic = {}

	let color = synIDattr(hlID(synpair[1]), "fg")
	if color != -1
	    let dic["guifg"] = color
	    let dic["ctermfg"] = color
	endif

	let color = synIDattr(hlID(synpair[1]), "bg")
	if color != -1
	    let dic["guibg"] = color
	    let dic["ctermbg"] = color
	endif

	let args = join(map(items(dic), 'join(v:val, "=")'), " ")

	execute 'highlight ' . synpair[0] . ' ' . args
    endif
endfor

if !exists("g:autoclose_pairs")
    let g:autoclose_pairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'"}
endif

if !exists("g:autoclose_expand_chars")
    let g:autoclose_expand_chars = ['{']
endif

if !exists("g:autoclose_tag_chars")
    let g:autoclose_tag_chars = ['>']
endif

if !exists("g:autoclose_forbidden")
    let g:autoclose_forbidden = {"_": function("autoclose#forbidden_default")}
endif

if !exists("g:autoclose_quoted_regions")
    let g:autoclose_quoted_regions = {}
endif
if !has_key(g:autoclose_quoted_regions, "_")
    let g:autoclose_quoted_regions['_'] = ["Character", "SpecialChar", "String"]
endif

call autoclose#enable(1)

command! -nargs=? AutoClose :call autoclose#autoclose(<f-args>)

let &cpo = s:cpo_save

" Vim plugin for text-objects of Japanese kakko
" Maintainer: INAJIMA Daisuke <inajima@sopht.jp>
" Version: 0.1

scriptencoding utf-8

call textobj#user#plugin('kakko', {
\   'kakko': {
\	'*pattern*': ['（', '）'],
\	'select-a': "a\<C-k>",
\	'select-i': "i\<C-k>",
\   },
\   'kagikakko': {
\	'*pattern*': ['「', '」'],
\	'select-a': 'ak',
\	'select-i': 'ik',
\   },
\   'kagikakko2': {
\	'*pattern*': ['『', '』'],
\	'select-a': 'aK',
\	'select-i': 'iK',
\   },
\})

let s:surround_objects = {
\   "\<C-k>": "（\r）",
\   'k': "「\r」",
\   'K': "『\r』",
\}

if !exists("g:textobj_kakko_surround") || g:textobj_kakko_surround
    if !exists("g:surround_objects")
	let g:surround_objects = {}
    endif
    call extend(g:surround_objects, s:surround_objects, "keep")
endif


function! unite#sources#outline#taskpaper#outline_info()
  return s:outline_info
endfunction

let s:outline_info = {
      \ 'heading': '^.\+:\(\s\+@[^ \t(]\+\(([^)]*)\)\?\)*$'
      \ }

function! s:outline_info.create_heading(which, heading_line, matched_line, context)
  let heading = {
	\ 'word' : a:heading_line[:-2],
	\ 'level': len(matchstr(a:heading_line, '^\t*')) + 1,
	\ 'type' : 'generic',
	\}

  return heading
endfunction

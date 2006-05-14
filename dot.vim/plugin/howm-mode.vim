"
" howm-mode.vim - vim �Ѥ� howm��
" - howm(Hitoride Otegaru Wiki Modoki)
"   http://howm.sourceforge.jp/index-j.html
"
" Last Change: 02-Jul-2005.
" Written By: Kouichi NANASHIMA <claymoremine@anet.ne.jp>

scriptencoding euc-jp

" variables {{{
if !exists('g:howm_dir')
  let g:howm_dir = "~/howm/"
endif
if !exists('g:howm_filename')
  let g:howm_filename = "%Y/%m/%d/%Y-%m-%d-%H%M%S.howm"
endif
if !exists('g:howm_fileencoding')
  " let g:howm_fileencoding = "euc-jp"
  let g:howm_fileencoding = &enc
endif
if !exists('g:howm_fileformat')
  " let g:howm_fileformat = "unix"
  let g:howm_fileformat = &ff
endif
if !exists('g:howm_keywordfile')
  let g:howm_keywordfile = '~/.howm-keys'
endif
if !exists('g:howm_mapleader')
  let g:howm_mapleader = ','
endif
if !exists('g:howm_instantpreview')
  let g:howm_instantpreview = 0
endif
if !exists('g:howm_hidefile_regexp')
  let g:howm_hidefile_regexp = '\(^\|/\)\.\|[~#]$\|\.bak$\|/CVS/'
endif
if !exists('g:howm_reminder_old_format')
  let g:howm_reminder_old_format = 0
endif
if !exists('g:howm_removeEmpty')
  let g:howm_removeEmpty = 0
endif
if !exists('g:howm_debug')
  let g:howm_debug = 0
endif

" variables-pattern {{{
" ���դΥѥ�����
" ͽ��� ToDo �ʤɤ˻��ѡ�
if !exists('g:howm_date_pattern')
  let g:howm_date_pattern='%Y-%m-%d'
endif
" TODO:match() �Ȥ��ȤäƼ�ư��
if !exists('g:howm_date_yearpos')
  let g:howm_date_yearpos=1
endif
if !exists('g:howm_date_monthpos')
  let g:howm_date_monthpos=2
endif
if !exists('g:howm_date_daypos')
  let g:howm_date_daypos=3
endif
" ��⥿���ȥ�Υѥ�����
if !exists('g:howm_title_pattern')
  let g:howm_title_pattern='='
endif
" goto ��󥯤Υѥ�����
if !exists('g:howm_glink_pattern')
  let g:howm_glink_pattern='>>>'
endif
if !exists('g:howm_clink_pattern')
  let g:howm_clink_pattern='<<<'
endif
" Preview �إå��Υѥ�����
if !exists('g:howm_previewheader_pattern')
  let g:howm_previewheader_pattern = "\<NL>==========================>>> %file%\<NL>"
endif
" variables-pattern }}}
" variables-grep {{{
if !exists('g:howm_grepprg')
  if has('win32')
    let g:howm_grepprg = ''
  else
    let g:howm_grepprg = 'grep'
  endif
endif
" Grep �¹��ѥ��ޥ�ɷ�
" #prg# �� g:howm_grepprg �ǻ��ꤷ���ץ������ִ������
" #searchWord# �ϸ�������ִ������
" #searchWordFile# �ϸ��������¸��������ѥե�����̾���ִ������
"                  �ʥ��ޥ�ɥ饤��Ǥ��ޤ��ޥ���Х���ʸ���������ʤ��Ȥ���ͭ����
" #searchPath# �ϸ����оݥѥ����ִ������
" CYGWIN GNU Grep ������
if !exists('g:howm_grepcmd_regexp')
  let g:howm_grepcmd_regexp        = '#prg# -HInrE -f #searchWordFile# #searchPath#'
endif
if !exists('g:howm_grepcmd_regexp_ignore')
  let g:howm_grepcmd_regexp_ignore = '#prg# -HInrEi -f #searchWordFile# #searchPath#'
endif
if !exists('g:howm_grepcmd_fix')
  let g:howm_grepcmd_fix           = '#prg# -HInrF -f #searchWordFile# #searchPath#'
endif
if !exists('g:howm_grepcmd_fix_ignore')
  let g:howm_grepcmd_fix_ignore    = '#prg# -HInrFi -f #searchWordFile# #searchPath#'
endif

" variables-grep }}}
" variables-find {{{
" old variables
if !exists('g:howm_findprg')
  " let g:howm_findprg = 'find'
  if has('win32')
    let g:howm_findprg = ''
  else
    let g:howm_findprg = 'find'
  endif
endif
let g:howm_findcmd   = '#prg# #searchPath# -type f -print'
" variables-find }}}
" variables-migemo {{{
if !exists('g:howm_migemoprg')
  let g:howm_migemoprg = 'migemo'
endif
if !exists('g:howm_migemoopt')
  " ruby migemo
  let g:howm_migemoopt   = '-t egrep -d /usr/share/migemo/migemo-dict'
  " cmigemo
  " let g:howm_migemoopt = '-q -d /usr/local/share/migemo/euc-jp/migemo-dict'
endif
" variables-migemo }}}

" variables }}}
" constant {{{
let s:prefix_howm               = "howm "
let s:buftitle_ftresult         = "Search result"
let s:buftitle_preview          = "View"
let s:buftitle_summary          = "View"
let s:buftitle_webimport        = "Web import"
let s:prompt_search_egrep       = "Full text search(grep): "
let s:prompt_search_fgrep       = "Full text search(fgrep): "
let s:prompt_search_migemo      = "Full text search(migemo): "
let s:prompt_input_sortkey      = "Sort by: "
let s:prompt_input_matchpattern = "Regexp: "
let s:prompt_lzchange           = "RET (done), x (canceled), symbol (type), num (laziness): "
let s:msg_ftnomatch             = "No match"
let s:msg_wait_search           = "Searching..."
let s:msg_wait_parse            = "Parsing..."
let s:msg_wait_sort             = "Sorting..."
let s:msg_wait_format           = "Formatting..."
let s:msg_done                  = "done."
let s:errmsg_inexecutable       = "'%prg%' isn't executable. Please assign valid value to the variable '%var%'."

let s:pattern_date = g:howm_date_pattern
  let s:pattern_date = substitute(s:pattern_date, '%Y', '\\(\\d\\{4}\\)', '')
  let s:pattern_date = substitute(s:pattern_date, '%m', '\\(\\d\\{2}\\)', '')
  let s:pattern_date = substitute(s:pattern_date, '%d', '\\(\\d\\{2}\\)', '')

function! s:CountLines(str)
  let i = 0
  let idx = match(a:str, "\<NL>")
  while idx != -1
    let i = i + 1
    let idx = match(a:str, "\<NL>", idx + 1)
  endwhile

  return i
endfunction
let s:num_previewheader_lines = s:CountLines(g:howm_previewheader_pattern)

" constant-actionlock {{{
let s:actionlock_pat1   = g:howm_glink_pattern.' *.*$'
let s:actionlock_func1  = 's:ActionLockGotoLink'
let s:actionlock_pat2   = g:howm_clink_pattern
let s:actionlock_func2  = 's:ActionLockComeFromLink'
let s:actionlock_pat3   = ''
let s:actionlock_func3  = 's:ActionLockKeyword'
let s:actionlock_pat4   = '{[ *-]}'
let s:actionlock_func4  = 's:ActionLockCheckOff'
let s:actionlock_pat5   = '{_}'
let s:actionlock_func5  = 's:ActionLockTimeStamp'
let s:actionlock_pat6   = "s\\?https\\?://[-_.!~*'()a-zA-Z0-9;/?:@&=+$,%#]\\+"
let s:actionlock_func6  = 's:ActionLockURL'
let s:actionlock_pat7   = '\(\['.s:pattern_date.'\]\)\@<=[-!+@]\d*'
let s:actionlock_func7  = 's:ActionLockImportantDate'
let s:actionlock_pat8   = "{s\\?https\\?://[-_.!~*'()a-zA-Z0-9;/?:@&=+$,%#]\\+}"
let s:actionlock_func8  = 's:ActionLockWebImport'
let s:actionlock_pat9   = s:pattern_date
let s:actionlock_func9  = 's:ActionLockDate'

if g:howm_reminder_old_format != 0
  " TODO:�ֹ�ľ���꤬����
  let s:actionlock_pat7   = '@\['.s:pattern_date.'\]\(-\d\+\|[\!+@]\(\d*\)\)\?'
endif

" constant-actionlock }}}
" constant-sort {{{
let s:laziness_normal    = 1
let s:laziness_todo      = 7
let s:init_todo          = -7
let s:laziness_deadline  = 7
let s:init_deadline      = -2
let s:laziness_schedule  = 1
" constant-sort }}}

" constant }}}
" keymaps {{{
if exists('g:mapleader')
  let s:leader = g:mapleader
endif
let g:mapleader = g:howm_mapleader
nmap <unique> <silent> <Leader>,a :call <SID>ShowDirectory()<CR>
nmap <unique> <silent> <Leader>,c :call <SID>OpenMemo(<SID>GetFilePath(0), 0)<CR>
nmap <unique> <silent> <Leader>,g :call <SID>FullTextSearchInput('egrep')<CR>
nmap <unique> <silent> <Leader>,m :call <SID>FullTextSearchInput('migemo')<CR>
nmap <unique> <silent> <Leader>,y :call <SID>ShowSchedule()<CR>
nmap <unique> <silent> <Leader>,t :call <SID>ShowTodo()<CR>
if exists('s:leader')
  let g:mapleader = s:leader
else
  unlet g:mapleader
endif

" keymaps }}}
" autocommands {{{
augroup howm
autocmd!
exe 'autocmd CursorHold '.escape(s:prefix_howm.s:buftitle_ftresult, ' ').' call s:ShowPreview()'
if g:howm_instantpreview == 1
  exe 'autocmd BufEnter '.escape(s:prefix_howm.s:buftitle_ftresult, ' ').' let b:updatetime=&updatetime|set updatetime=1'
  exe 'autocmd BufLeave '.escape(s:prefix_howm.s:buftitle_ftresult, ' ').' silent! exe "set updatetime=".b:updatetime'
endif
exe 'autocmd BufDelete '.escape(s:prefix_howm.s:buftitle_ftresult, ' ').' call s:EliminateWindow(escape(s:prefix_howm.s:buftitle_preview, " "))'
autocmd FileType howm_memo nmap <silent> <buffer> <CR> :call <SID>DoActionLock()<CR>
autocmd BufEnter *.howm setlocal ft=howm_memo
autocmd BufWritePost,FileWritePost *.howm call s:RemoveEmpty(expand("%:p"))
autocmd BufWritePost,FileWritePost *.howm call s:UpdateKeyword()

augroup END
" autocommands }}}
" functions {{{

" �ե�������Υ�����ɤ򸡺����������ʥ�����ɤ����ä���
" g:howm_keyword �� g:howm_keywordfile �����Ƥ򹹿���
function! s:UpdateKeyword()
	let line = line('.')
	let col = col('.')
	let winline = winline()
	let wincol = wincol()
	let start = localtime()
	let keyword = GrepBuffer(g:howm_clink_pattern, '', 0, 0)
	let end = localtime()
	" ��������ɽ��
	call HowmDebugLog('UpdateKeyword:'.(end - start).'[mSec]')

	" �����ʥ�����ɸ���� 1 �Ĥ��ĸ���
	let newKeyword = ''
	while keyword != ''
		let pos = match(keyword, "\<NL>")
		let word = strpart(keyword, 0, pos)
    let word = matchstr(word, '\('.g:howm_clink_pattern.'\s*\)\@<=\S.*\(\s*\)\@=$')
		let word = HowmEscapeVimPattern(word)
		let keyword = strpart(keyword, pos + 1)
		" g:howm_keyword �˴ޤޤ�Ƥ��ʤ���Τ�
		" �����ʥ�����ɤȤ��� g:howm_keyword ���ɲ�
		if g:howm_keyword == '' || word !~ '\v('.g:howm_keyword.')'
			let newKeyword = newKeyword.word."\<NL>"
			let g:howm_keyword = g:howm_keyword.'|'.word
		endif
	endwhile
  let s:actionlock_pat3 = '\v('.g:howm_keyword.')'
	setlocal ft=howm_memo

	call s:AddKeyword(newKeyword)

" 2005-05-28 �ڸ�����Υѥå���Ŭ�� begin
	call s:RestoreWinPos(line, col, winline, wincol)
endfunction

" ���̾��ɽ������Ƥ���ڡ������Ƥ򥹥����뤷�Ƹ��ξ��֤��᤹
function! s:RestoreWinPos(line, col, winline, wincol)
	call cursor(a:line, a:col)

	let dif = winline() - a:winline
	if dif > 0
		let cmd = "\<C-E>"
	else
		let cmd = "\<C-Y>"
	endif
	let prevdif = dif
	" wrap���줿�Ԥ������1���<C-E>/<C-Y>��ʣ���ԥ������뤹��Τǡ�
	" �Ԥ������ʤ��褦��1�Ԥ��ĥ������뤹�롣
	" �Ԥ������ĤˤʤäƼ�«���ʤ����֤ˤʤ�ΤϤޤ����Τ�
	" ���������������Ѥ�ä������Ǥ���(�����ָ�ˡ�����ιԤ�wrap���뤯�餤��
	" Ĺ���˽񤭴���������ȯ�������뤬���ޤ����ˤ��ʤ��Ƥ��ɤ������ǤϤ���)
	while dif * prevdif > 0
		exe 'normal! '.cmd
		let prevdif = dif
		let dif = winline() - a:winline
		" <C-E>/<C-Y>�ǥ���������֤���ư���ʤ��ä�?
		" ���̤�ü����scrolloff����Υ��������ΰ��ü�ˤ֤Ĥ��ä���ǽ������
		" (a:winline,a:wincol�ε�Ͽ���'scrolloff'���礭�����ꤷ�������)
		if dif == prevdif
			break
		endif
	endwhile

	if !&wrap
		let dif = wincol() - a:wincol
		if dif > 0
			let cmd = 'zl'
		else
			let cmd = 'zh'
		endif
		let prevdif = dif
		while dif * prevdif > 0
			exe 'normal! '.cmd
			let prevdif = dif
			let dif = wincol() - a:wincol
			if dif == prevdif
				break
			endif
		endwhile
	endif

	" ǰ�Τ��ᥫ��������֤κǽ������å�
	" ����Ƥ�����winline,wincol��Ĵ������ǰ���ơ�����������֤����Ǥ��碌��
	let line = line('.')
	let col = col('.')
	if line != a:line || col != a:col
		call cursor(a:line, a:col)
	endif
endfunction
" 2005-05-28 �ڸ�����Υѥå���Ŭ�� end

" g:howm_keywordfile �Υե������ newKeyword �ǻ��ꤵ�줿
" ������ɤ��ɲä��롣
"	
"	- newKeyword �ɲä���륭�����
function s:AddKeyword(newKeyword)
  call s:OpenWindow(g:howm_keywordfile, 0)
	let newKeyword = a:newKeyword
	while newKeyword != ''
		let pos = match(newKeyword, "\<NL>")
		let word = strpart(newKeyword, 0, pos)
		let newKeyword = strpart(newKeyword, pos + 1)
		call s:HowmAppend(word)
	endwhile
	silent! write
	silent! bdelete
endfunction

function! RevertKeyword()
  call s:FullTextSearch(g:howm_clink_pattern, 0)
  let lnum = b:searchResultNum
  let i = 1
  let g:howm_keyword = ''
	let newKeyword = ''
  while i <= lnum
    let word = matchstr(b:content{i}, '\('.g:howm_clink_pattern.'\s*\)\@<=\S.*\(\s*\)\@=$')
		let word = HowmEscapeVimPattern(word)
    if g:howm_keyword == '' || word !~ '\v('.g:howm_keyword.')'
      if g:howm_keyword != ''
        let g:howm_keyword = g:howm_keyword.'|'
      endif
      let g:howm_keyword = g:howm_keyword.word
			let newKeyword = newKeyword.word."\<NL>"
    endif
    let i = i + 1
  endwhile
  call s:SafeClose()

	call delete(expand(g:howm_keywordfile))
	call s:AddKeyword(newKeyword)
  
  " TODO:������ʤ���
  let s:actionlock_pat3 = '\v('.g:howm_keyword.')'
endfunction

function! s:ParseKeyword()
  call s:OpenTemporalWindow(g:howm_keywordfile, 0)
  let lnum = line('$')
  let i = 1
  let g:howm_keyword=''
  while i <= lnum
    if i != 1
      let g:howm_keyword = g:howm_keyword.'|'
    endif
    let g:howm_keyword = g:howm_keyword.getline(i)
    let i = i + 1
  endwhile
  call s:SafeClose()

  " TODO:������ʤ���
  let s:actionlock_pat3 = '\v('.g:howm_keyword.')'
endfunction

" filepath �� howm �Υ��ե�����Ȥ��Ƴ���
" linenum == 0 �λ��ˤϿ��������Υƥ�ץ졼�Ȥ��ɲä������֤ǳ���
" linenum != 0 �λ��ˤϤ��ιԤ˥����åȤ��֤������֤ǳ���
function! s:OpenMemo(filepath, linenum)
	let editing = s:HowmExpand("%:p")
  let filepath = s:HowmExpand(a:filepath)

	if editing != filepath
    let howm_dir = s:HowmExpand(g:howm_dir)
    let idx = matchend(filepath, howm_dir)
    if idx != -1
      " ¸�ߤ��ʤ��ǥ��쥯�ȥ겼�Υե��������ꤵ�줿�顤�ǥ��쥯�ȥ����
      call s:MakeDirectory(substitute(strpart(filepath, idx), '[^/]*$', '', ''))
      " TODO:���顼����
    endif
    call s:OpenWindow(a:filepath, 1)
	endif
	if a:linenum == 0
    " ���������Υƥ�ץ졼�Ȥ��ɲ�
		call s:HowmAppend(g:howm_title_pattern.' ')
		if editing != '' && editing != filepath && match(s:HowmExpand("%:p:t"), s:prefix_howm) != 0
			call s:HowmAppend(s:GetTimeStamp(0).' '.g:howm_glink_pattern.' '.editing)
		else
			call s:HowmAppend(s:GetTimeStamp(0))
		endif
		call s:HowmAppend('')
		call cursor(line('$') - 2, col('$'))
		startinsert!
	elseif a:linenum > 0
    " ����Ԥ�����
    call cursor(a:linenum, '1')
	endif
  normal! zz
endfunction

function! s:RemoveEmpty(file)
  if &ft == 'howm_memo' && g:howm_removeEmpty == 1 && getfsize(a:file) == 0
    call delete(a:file)
  endif
endfunction

" g:howm_dir.str �Υǥ��쥯�ȥ���롥
function! s:MakeDirectory(str)
  if isdirectory(s:HowmExpand(g:howm_dir).a:str) || a:str == ""
    let retval = ""
  elseif a:str !~ "/$"
    " TODO:�ѿ��ˡ�
    let retval = "howm: argument is not valid format."
  else
    let retval = s:MakeDirectory(substitute(a:str, '[^/]*/$', '', ''))
    if retval == ""
      let path = s:HowmExpand(g:howm_dir).a:str
      " TODO:�ۥ�Ȥˤ��������פʤΤ��ʤ��ġ�
      if has('win32') && system("echo $OSTYPE") !~ 'cygwin'
        let path = '"'.substitute(path, '/', '\\', 'g').'"'
      endif
      " TODO:Windows �� UNIX �ϰʳ��Ǥ⤳��Ǥ�����Τ���
      if path =~# '\\$'
        let path = strpart(path, 0, strlen(path) - 1)
      endif
      echo "mkdir ".path
      let retval = system("mkdir ".path)
    endif
  endif
  return retval
endfunction

" ���������դ��� offset ���������줿���դ��б����� howm �ե�����Υѥ�����
" ����
function! s:GetFilePath(offset)
	let time = localtime() + a:offset * 86400
  let howm_dir = s:HowmExpand(g:howm_dir)
	return s:HowmExpand(howm_dir.strftime(g:howm_filename, time))
endfunction

function! s:GetTimeStamp(bDateOnly)
  if a:bDateOnly
    return strftime("[".g:howm_date_pattern."]")
  else
    return strftime("[".g:howm_date_pattern." %H:%M]")
  endif
endfunction

" TODO: ������ͤ�ľ����������������
function! s:FullTextSearch(searchWord, bRegexp)
  if a:searchWord != ''
    call s:OpenSearchWindow(a:searchWord)
    let path = s:HowmExpand(a:searchWord)
    if !filereadable(path) || isdirectory(path)
      let path = ''
    endif
    if s:ParseSearchResult(s:GrepSearch(b:searchWord, a:bRegexp)) > 0 || path != ''
      call s:SortByMtime()
      " ������˥ޥå�����ե����뤬������
      " TODO:�����ʤ���
      if path != ''
        let i = b:searchResultNum
        while i >= 1
          let b:file{i + 1} = b:file{i}
          let b:line{i + 1} = b:line{i}
          let b:content{i + 1} = b:content{i}
          let i = i - 1
        endwhile
        let b:file1 = path
        let b:line1 = 0
        let b:content1 = ""
        let b:searchResultNum = b:searchResultNum + 1
      endif
      call s:FormatSearchResult()
      call cursor(1, 1)
      let retval = 1
    else
      redraw!
      echo s:prefix_howm.s:msg_ftnomatch
      call s:SafeClose()
      let retval = 0
    endif
  else
    let retval = 0
  endif

  return retval
endfunction

" �桼�����鸡����������ꡤ��ʸ������Ԥ���
" s:fulltext_prompt ��Ȥ��ΤǤ��������ؿ����ä���
function! s:FullTextSearchInput(searchType)
  if a:searchType == 'egrep'
    let searchWord = input(s:prefix_howm.s:prompt_search_egrep)
    call s:FullTextSearch(searchWord, 1)
  elseif a:searchType == 'fgrep'
    let searchWord = input(s:prefix_howm.s:prompt_search_fgrep)
    call s:FullTextSearch(searchWord, 0)
  elseif a:searchType == 'migemo'
    if !executable(g:howm_migemoprg)
      " TODO: ���顼��å�����
      return
    endif
    let searchWord = input(s:prefix_howm.s:prompt_search_migemo)
    let searchWord = system("echo ".searchWord." | ".g:howm_migemoprg." ".g:howm_migemoopt)
    let searchWord = substitute(searchWord, "\\(\<CR>\\|\<NL>\\)", '', 'g')
    call s:FullTextSearch(searchWord, 1)
  else
    " TODO: ���顼��å�����
    return
  endif
endfunction

function! s:ShowSchedule()
  if g:howm_reminder_old_format != 0
    return s:ShowScheduleOld()
  endif
  " grep �����ѤΥѥ����������
  let pattern_date      = g:howm_date_pattern
  let pattern_date      = substitute(pattern_date, '%Y', '[0-9]{4}', '')
  let pattern_date      = substitute(pattern_date, '%m', '[0-9]{2}', '')
  let pattern_date      = substitute(pattern_date, '%d', '[0-9]{2}', '')
  call s:OpenSearchWindow('')
  if s:ParseSearchResult(s:GrepSearch('\['.pattern_date.'\][!@.][0-9]*', 1)) != 0
    setlocal filetype=howm_importantdate
    let i = 1
    while i <= b:searchResultNum
      let b:content{i} = strpart(b:content{i}, match(b:content{i}, '\['.s:pattern_date.'\][!@.]'))
      let i = i + 1
    endwhile
    call s:SortByContent()
    call s:FormatSearchResult()
    let today = HowmDate2Int(strftime(g:howm_date_pattern), g:howm_date_pattern)
    let lnum = 1
    let day = s:GetDaysFromContent(b:content{lnum})
    while today > day && lnum < b:searchResultNum
      let lnum = lnum + 1
      let day = s:GetDaysFromContent(b:content{lnum})
    endwhile
    call cursor(lnum, 1)
    normal! zz
    let retval = 1
  else
    redraw!
    echo s:prefix_howm.s:msg_ftnomatch
    call s:SafeClose()
    let retval = 0
  endif

  return retval
endfunction

function! s:ShowTodo()
  if g:howm_reminder_old_format != 0
    return s:ShowTodoOld()
  endif
  " grep �����ѤΥѥ����������
  let pattern_date      = g:howm_date_pattern
  let pattern_date      = substitute(pattern_date, '%Y', '[0-9]{4}', '')
  let pattern_date      = substitute(pattern_date, '%m', '[0-9]{2}', '')
  let pattern_date      = substitute(pattern_date, '%d', '[0-9]{2}', '')
  call s:OpenSearchWindow('')
  if s:ParseSearchResult(s:GrepSearch('\['.pattern_date.'\][-!+.][0-9]*', 1)) != 0
    setlocal filetype=howm_importantdate
    let i = 1
    while i <= b:searchResultNum
      let b:content{i} = strpart(b:content{i}, match(b:content{i}, '\['.s:pattern_date.'\]'))
      let i = i + 1
    endwhile
    call s:SortByPriority()
    call s:FormatSearchResult()
    call cursor(1, 1)
    let retval = 1
  else
    redraw!
    echo s:prefix_howm.s:msg_ftnomatch
    call s:SafeClose()
    let retval = 0
  endif

  return retval
endfunction

" �̾復����ɥ��򳫤�
" TODO:�̾復����ɥ��Ȥϡ�����ѥ�����ɥ��Ȥϡ�
function! s:OpenWindow(filepath, bEliminateDup)
	if &encoding != g:howm_fileencoding && !has('iconv')
    " TODO:���顼��å�����
    return 0
	endif
  if a:bEliminateDup
    call s:EliminateWindow(a:filepath)
  endif
  if s:HowmExpand("%:p") == "" && &modified == 0 && !has("vim_starting")
    let cmd = "edit"
  else
    let cmd = "new"
  endif
  " TODO:ʸ�������ɸ���ǳ������ɤ����ե饰��Ƚ�ꤹ��
" 2005-05-28 �ڸ�����Υѥå���Ŭ�� begin
	silent exe cmd.' ++enc='.g:howm_fileencoding.' ++ff='.g:howm_fileformat.' '.a:filepath
" 2005-05-28 �ڸ�����Υѥå���Ŭ�� end
endfunction

" ���ꤷ���Хåե�̾�Υ�����ɥ��������Ĥ��롥
function! s:EliminateWindow(name)
	let nr = bufwinnr(a:name)
	while nr != -1
		exe nr.'wincmd w'
    if s:SafeClose() == 0
      break
    endif
		let nr = bufwinnr(a:name)
	endwhile
endfunction

function! s:SafeClose()
  let retval = 0
  if &modified != 1
    silent! enew
    if s:GetWinNum() > 1
			bdelete
    endif
    let retval = 1
  endif
  return retval
endfunction

function! s:GetWinNum()
  let winnum = 1
  let nr = winnr()
  silent! exe "wincmd \<C-w>"
  while nr != winnr()
    let winnum = winnum + 1
    silent! exe "wincmd \<C-w>"
  endwhile
  return winnum
endfunction

" ����ѥ�����ɥ��򳫤�
function! s:OpenTemporalWindow(filepath, bEliminateDup)
  call s:OpenWindow(a:filepath, a:bEliminateDup)
	setlocal bt=nofile bh=delete noswf
endfunction

" �������ɽ���ѥ�����ɥ��򳫤�
" searchWord �����Ǥʤ���� searchWord ��ϥ��饤�ȡ�
function! s:OpenSearchWindow(searchWord)
  call s:OpenTemporalWindow(escape(s:prefix_howm.s:buftitle_ftresult, ' '), 1)
  setlocal nowrap
  let b:searchWord = a:searchWord
  if b:searchWord != ""
    exe 'syntax match howmSearchWord display "\c\v'.escape(b:searchWord, '=~@%').'"'
    hi howmSearchWord ctermfg=Red ctermbg=Grey guifg=Red guibg=bg
  endif
  nnoremap <silent> <buffer> <CR> :call <SID>OpenSearchLine()<CR>
  if g:howm_instantpreview == 0
    nnoremap <silent> <buffer> p :call <SID>ShowPreview()<CR>
  endif
  nnoremap <silent> <buffer> @ :call <SID>ShowSummary()<CR>
  nnoremap <silent> <buffer> <S-s> :call <SID>SortKeyInput()<CR>
  nnoremap <silent> <buffer> <S-r> :call <SID>Reverse()<CR>:call <SID>FormatSearchResult()<CR>
endfunction

" GrepSearch() �� FindSearch() �θ�����̤���Ϥ��ơ�
" b:file{i}, b:line{i}, b:content{i} �˳�Ǽ��
" ��Ǽ�Ǥ��������֤���
function! s:ParseSearchResult(searchResult)
  redraw!
  echo s:prefix_howm.s:msg_wait_parse
  let searchResult = a:searchResult

  let i = 1
  let idx = match(searchResult, "\<NL>")
  if idx != -1
    let buf = strpart(searchResult, 0, idx)
    let searchResult = strpart(searchResult, idx + 1)
  else
    let buf = searchResult
    let searchResult = ""
  endif
  while buf != "" || searchResult != ""
    let bufidx = matchend(buf, '^\([a-zA-Z]:/\|/\)\?\([^:/]\+/\)*[^:/]\+:')
    let b:file{i} = strpart(buf, 0, bufidx - 1)
    let buf = strpart(buf, bufidx)
    let bufidx = matchend(buf, '^\d\+:')
    let b:line{i} = strpart(buf, 0, bufidx - 1)
    let buf = strpart(buf, bufidx)
    let b:content{i} = strpart(buf, match(buf, '\S'))
    let b:content{i} = substitute(b:content{i}, "\\(\<CR>\\|\<NL>\\)", '', 'g')
    if b:file{i} != '' && b:line{i} =~ '^\d\+$' && b:file{i} !~ g:howm_hidefile_regexp
      let b:line{i} = b:line{i} + 0
      let i = i + 1
    else
      " �Ԥ�������̤Υե����ޥåȤ˹�äƤ��ʤ��Ȥ���
      unlet b:file{i}
      unlet b:line{i}
      unlet b:content{i}
    endif
    let idx = match(searchResult, "\<NL>")
    if idx != -1
      let buf = strpart(searchResult, 0, idx)
      let searchResult = strpart(searchResult, idx + 1)
    else
      let buf = searchResult
      let searchResult = ""
    endif
  endwhile
  let b:searchResultNum = i - 1

  redraw!
  echo s:prefix_howm.s:msg_wait_parse.s:msg_done
  return i - 1
endfunction

" grep �ˤ�ä���ʸ����������̤��������롥
function! s:FormatSearchResult()
  redraw!
  echo s:prefix_howm.s:msg_wait_format
  let lineFormat = "%filename% | %content%"
  setlocal modifiable
  silent! exe 'g/^/d_'
  let i = 1
  while i <= b:searchResultNum
    let filename = strpart(b:file{i}, match(b:file{i}, '[^/]*$'))
    let buf = lineFormat
    let buf = substitute(buf, '%filename%', escape(filename, '\~&'), 'g')
    let buf = substitute(buf, '%file%', escape(b:file{i}, '\~&'), 'g')
    let buf = substitute(buf, '%line%', b:line{i}, 'g')
    let buf = substitute(buf, '%content%', escape(b:content{i}, '\~&'), 'g')
    call s:HowmAppend(buf)
    let i = i + 1
  endwhile
	setlocal nomodifiable
  redraw!
  echo s:prefix_howm.s:msg_wait_format.s:msg_done
endfunction

function! s:DoActionLock()
  let str = getline('.')
  let cur = col('.') - 1
  let func = ''
  let matched = ''
  let i = 1
  while exists('s:actionlock_pat'.i) && exists('s:actionlock_func'.i) && func == ''
		let j = 0
		let head = match(str, s:actionlock_pat{i})
		let tail = matchend(str, s:actionlock_pat{i})
		while head != -1 && cur >= j && func == ''
			if head <= cur && cur < tail
				let func = s:actionlock_func{i}
				let matched = matchstr(str, s:actionlock_pat{i}, j)
			elseif j != tail
				let j = tail
				let head = match(str, s:actionlock_pat{i}, j)
				let tail = matchend(str, s:actionlock_pat{i}, j)
			else
				break
			endif
		endwhile
    let i = i + 1
  endwhile

  if func != ''
    " �ޥå�����ʸ����ȥ���������֤��Ϥ���
    call {func}(matched, head + 1)
  else
    exe "normal! \<CR>"
  endif
endfunction

function! s:ActionLockGotoLink(str, head)
  let str = substitute(a:str, '^'.g:howm_glink_pattern.' *', '', '')
  call s:FullTextSearch(str, 0)
endfunction

function! s:ActionLockComeFromLink(str, head)
  let str = strpart(getline('.'), a:head - 1)
  let str = substitute(str, '^'.g:howm_clink_pattern.'\s*', '', '')
  call s:FullTextSearch(str, 0)
  call s:SortByContentMatch(g:howm_clink_pattern)
  call s:FormatSearchResult()
endfunction

function! s:ActionLockKeyword(str, head)
  call s:FullTextSearch(a:str, 0)
  call s:SortByContentMatch(g:howm_clink_pattern)
  call s:FormatSearchResult()
endfunction

function! s:ActionLockCheckOff(str, head)
  let mark = substitute(a:str, '{\(.*\)}', '\1', '')
  " TODO:��äȥ��ޡ��Ȥˡ�
  if mark == ' '
    let newmark = '*'
  elseif mark == '*'
    let newmark = '-'
  elseif mark == '-'
    let newmark = ' '
  else
    let newmark = ''
  endif

  if newmark != ''
    call cursor(line('.'), a:head)
    silent! exe "normal! c".strlen(a:str)."l{".newmark."}\<ESC>"
    call cursor(line('.'), a:head)
  endif
endfunction

function! s:ActionLockTimeStamp(str, head)
  call cursor(line('.'), a:head)
  silent! exe "normal! c".strlen(a:str)."l".s:GetTimeStamp(0)."\<ESC>"
  call cursor(line('.'), a:head)
endfunction

function! s:ActionLockURL(str, head)
  let cmd = ""
  if exists('g:howm_openurlcmd')
    let cmd = g:howm_openurlcmd
  endif
  if exists('*AL_open_url')
    call AL_open_url(a:str, cmd)
  else
    " MODIFIED:�⻳����
		" AL_open_url ���ʤ��Ȥ���ľ�ܥ��ޥ�ɥ饤��إ��ޥ�ɤ��Ϥ�
    let cmd = substitute(cmd, '%s', a:str, '')
    let cmd = escape(cmd, '%#')
    exe '!'.cmd
  endif
endfunction

function! s:ActionLockImportantDate(str, head)
  if g:howm_reminder_old_format != 0
    call s:ActionLockImportantDateOld(a:str, a:head)
    return
  endif
  let input = input(s:prefix_howm.s:prompt_lzchange)
  call cursor(line('.'), a:head)
  if input == ''
    silent! exe 'normal! i:'
    call search('\['.s:pattern_date.'\]', 'bW')
    silent! exe 'normal! i'.s:GetTimeStamp(1).'. '
  elseif input == 'x'
    silent! exe 'normal! i:'
    call search('\['.s:pattern_date.'\]', 'bW')
    silent! exe 'normal! i'.s:GetTimeStamp(1).'. cancel '
  elseif input =~ '^[-!+@.]$'
    silent! exe 'normal! r'.input
  elseif input =~ '^\d\+$'
    if strlen(a:str) > 1
      let len = strlen(a:str) - 1
      let cmd = 'l"_c'.len.'l'
    else
      let cmd = 'a'
    endif
    let newlazy = input + 0
    silent! exe 'normal! '.cmd.newlazy
  else
    redraw!
    echo "Can't understand ".input
  endif
  call cursor(line('.'), a:head)
endfunction

" TODO:Ŭ�������鿧���Х�������Ϥ���
function! s:ActionLockWebImport(str, head)
  if !exists('g:howm_html2txtcmd')
    " TODO:���顼��å�����
    return 0
  endif
  let buf  = bufname("%")
  let line = line(".")
  let col  = a:head
  let url  = substitute(a:str, "{\\([^}]*\\)}", "\\1", "")
  call s:OpenTemporalWindow(escape(s:prefix_howm.s:buftitle_webimport, ' '), 1)
  let b:buf  = buf
  let b:line = line
  let b:col  = col
  let b:url  = url
	"	MODIFIED:�⻳����
	"	���ޤ�ư���ʤ��餷�� 'y \|' �� '"zy' ���֤�����
  " vnoremap <silent> <buffer> <CR> y \| :call <SID>WebImport()<CR>
  vnoremap <silent> <buffer> <CR> "zy :call <SID>WebImport()<CR>
  let url = escape(url, '~&')
  let cmd = substitute(g:howm_html2txtcmd, '%s', url, "g")
  silent! exe "0r!".cmd
  setlocal nomodifiable
  call cursor(1, 1)
endfunction

" TODO:�̥ե�����ˤ��������ɤ����⡥
function! s:WebImport()
  let buf  = b:buf
  let line = b:line
  let col  = b:col
  let url  = b:url
  call s:SafeClose()
  silent! exe bufwinnr(buf)."wincmd w"
  call cursor(line, col)
  let sol = matchstr(getline("."), "^\\s*")
  if exists('g:howm_quotemark')
    let sol = sol.g:howm_quotemark
  endif
  silent! exe "normal! o".url
  let @z = substitute(@z, "^", "".sol, "g")
  let @z = substitute(@z, "\\(\n\\|\r\n\\?\\)\\($\\)\\@!", "\\1".sol, "g")
  let @z = substitute(@z, "\\s*\\(\n\\|\r\n\\?\\|$\\)", "\\1", "g")
  silent! put! z
  call cursor(line, col)
  normal! df}
  if getline(".") =~ "^\\s*$"
    silent! normal! dd
  endif
endfunction

function! s:ActionLockDate(str, head)
  call s:FullTextSearch(a:str, 0)
endfunction

function! s:OpenSearchLine()
  let file = b:file{line('.')}
  let line = b:line{line('.')}
  call s:EliminateWindow(bufname("%"))
  " TODO:�ƥ��ȡ����Х����ꤽ����
  if line == 0
    let ft = substitute(file, '.*\.\(.\{-}\)', '\1', '')
    if exists('g:howm_opencmd_'.ft)
      let file = escape(file, '~&')
      let cmd = substitute(g:howm_opencmd_{ft}, '%s', file, 'g')
    else
      " ��������������������֤�ͭ���ˤ���
      let cmd = "call s:OpenMemo(file, -1)"
    endif
  else
    let cmd = "call s:OpenMemo(file, line)"
  endif
  exe cmd
endfunction

" TODO:howm_dir �ʲ��Υե������ howm_fileencoding �ǥץ�ӥ塼���ơ������
" ����Ƚ�̤� Vim ��Ǥ���롩
function! s:ShowPreview()
  let previewList = b:file{line('.')}.':'.b:line{line('.')}."\<NL>"
  let searchWord = b:searchWord
  let buf = bufname('%')
  call s:OpenTemporalWindow(escape(s:prefix_howm.s:buftitle_preview, ' '), 1)
  call s:HighlightPreview(searchWord)
  call s:ParsePreviewList(previewList)
  call s:FormatPreviewList()
  let head = strpart(b:region1, 0, matchend(b:region1, '\d*')) + 0
  call cursor(b:line1 - head + s:num_previewheader_lines + 1, 1)
  silent! normal! zz
  silent! exe bufwinnr(buf).'wincmd w'
endfunction

function! s:ShowDirectory()
  call s:OpenSearchWindow('')
  if s:ParseSearchResult(s:FindSearch()) != 0
    call s:SortByMtime()
    call s:FormatSearchResult()
    call cursor(1, 1)
    let retval = 1
  else
    redraw!
    echo s:prefix_howm.s:msg_ftnomatch
    call s:SafeClose()
    let retval = 0
  endif
endfunction

function! s:ShowSummary()
  let i = 1
  let previewList = ''
  while i <= b:searchResultNum
    let previewList = previewList.b:file{i}.':'.b:line{i}."\<NL>"
    let i = i + 1
  endwhile
  let searchWord = b:searchWord
  let buf = bufname("%")
  call s:OpenTemporalWindow(escape(s:prefix_howm.s:buftitle_summary, ' '), 1)
  call s:HighlightPreview(searchWord)
  call s:ParsePreviewList(previewList)
  call s:FormatPreviewList()
  call cursor(1, 1)
  "silent! exe bufwinnr(buf).'wincmd w'
endfunction

" TODO:OpenPreviewWindow() �ˤ��롥
function! s:HighlightPreview(searchWord)
  let hlpattern = substitute(g:howm_previewheader_pattern, '%file%', '.*', 'g')
	exe 'syntax match howmPreviewHeader display '.hlpattern
	hi howmPreviewHeader ctermfg=Red ctermbg=Grey guifg=Red guibg=bg
  if a:searchWord != ""
    exe 'syntax match howmSearchWord display "'.'\c\v'.escape(a:searchWord, '=~@%').'"'
    hi howmSearchWord ctermfg=Red ctermbg=Grey guifg=Red guibg=bg
  endif
endfunction

function! s:ParsePreviewList(previewList)
  let previewList = a:previewList

  let i = 1
  let idx = match(previewList, "\<NL>")
  if idx != -1
    let buf = strpart(previewList, 0, idx)
    let previewList = strpart(previewList, idx + 1)
  else
    let buf = previewList
    let previewList = ""
  endif
  let oldBeginLine = -1
  let oldEndLine = -1
  let oldFile = ''
  while buf != "" || previewList != ""
    let bufidx = matchend(buf, '^\([a-zA-Z]:/\|/\)\?\([^:/]\+/\)*[^:/]\+:')
    let file = strpart(buf, 0, bufidx - 1)
    let buf = strpart(buf, bufidx)
    let bufidx = matchend(buf, '^\d\+')
    let line = strpart(buf, 0, bufidx)
    " TODO:�ץ�ӥ塼���ʤ��ե�����ν���
    if file != '' && line =~ '^\d\+$'
      let line = line + 0
      if file != oldFile || line < oldBeginLine || line > oldEndLine
        let clip = s:ClipMemo(file, line)
        let idx = match(clip, "\<NL>")
        let b:region{i} = strpart(clip, 0, idx)
        let b:memo{i} = strpart(clip, idx + 1)
        let b:file{i} = file
        let b:line{i} = line
        let oldBeginLine = substitute(b:region{i}, '^\(\d\+\),\(\d\+\)$', '\1', '') + 0
        let oldEndLine   = substitute(b:region{i}, '^\(\d\+\),\(\d\+\)$', '\2', '') + 0
        let oldFile = file
        let i = i + 1
      endif
    endif
    let idx = match(previewList, "\<NL>")
    if idx != -1
      let buf = strpart(previewList, 0, idx)
      let previewList = strpart(previewList, idx + 1)
    else
      let buf = previewList
      let previewList = ""
    endif
  endwhile
  let b:previewListNum = i - 1

  return i - 1
endfunction

function! s:ClipMemo(filepath, linenum)
  setlocal modifiable
  silent! exe 'g/^/d_'
  let readcmd = '$r'
  let readcmd = readcmd.' ++enc='.g:howm_fileencoding
  let readcmd = readcmd.' ++ff='.g:howm_fileformat
  silent! exe readcmd.' '.a:filepath
  silent! 1delete _
  if a:linenum == 0
    let head = 1
    let tail = line("$")
  else
    call cursor(a:linenum, 1)
    if getline(a:linenum) =~ '^'.g:howm_title_pattern.'\( .*\)\?$'
      let head = a:linenum
    else
      let head = search('^'.g:howm_title_pattern.'\( .*\)\?$', 'bW')
      if head == 0
        let head = 1
      endif
    endif
    call cursor(a:linenum, 1)
    let tail = search('^'.g:howm_title_pattern.'\( .*\)\?$', 'W')
    if tail == 0
      let tail = line('$')
    else
      let tail = tail - 1
    endif
  endif
  let i = head
  let retval = head.','.tail."\<NL>"
  while i <= tail
    let retval = retval.getline(i)."\<NL>"
    let i = i + 1
  endwhile

  return retval
endfunction!

function! s:FormatPreviewList()
  setlocal modifiable
  silent! exe 'g/^/d_'
  let i = 1
  while i <= b:previewListNum
    " �إå��񤭽Ф�
    " TODO:�إå��ΤȤ���������� ID �ֹ���դ��Ƥ����ơ�
    " �إå��ιԿ��ʿ�����롼�����񤯡ˤ� beginline ����������Ԥ�׻����롥
    let header = substitute(g:howm_previewheader_pattern, '%file%', b:file{i}, 'g')

    " ���񤭽Ф�
    let regbak = @z
    let @z = header.b:memo{i}
    silent! $put z
    let @z = regbak
    if i == 1
      silent! 1delete _
    endif
    "let idx = match(memo, "\<NL>")
    "if idx != -1
    "  let buf = strpart(memo, 0, idx + 1)
    "  let memo = strpart(memo, idx + 1)
    "else
    "  let buf = memo
    "  let memo = ""
    "endif
    "while buf != "" || memo != ""
    "  let buf = substitute(buf, "\<NL>$", '', '')
    "  call s:HowmAppend(buf)
    "  let idx = match(memo, "\<NL>")
    "  if idx != -1
    "    let buf = strpart(memo, 0, idx + 1)
    "    let memo = strpart(memo, idx + 1)
    "  else
    "    let buf = memo
    "    let memo = ""
    "  endif
    "endwhile
    let i = i + 1
  endwhile
	setlocal nomodifiable
endfunction

" �������ե�������ä����ˤ� 1 ���ܤ�ʸ�����񤤤ơ�����ʳ��λ��Ϲ�����
" ʸ������ɲä��롥
function! s:HowmAppend(str)
	if line('$') != 1 || getline('1') != ''
		call append('$', a:str)
	else
		call setline('1', a:str)
	endif
endfunction

" expand() �ν�����¾�ˡ�'\\ ' �� ' ' �ˤ��롥
" �ե�����ѥ��ζ��ڤ�� '/' �����졥
" str ��¸�ߤ���ѥ��ǥǥ��쥯�ȥ�ʤ��ɬ���Ǹ�� '/' ��Ĥ��롥
function! s:HowmExpand(str)
  let retval = expand(a:str)
  let retval = substitute(retval, '\\ ', ' ', 'g')
  let retval = substitute(retval, '\\', '/', 'g')
  if isdirectory(retval) && retval !~ "/$"
    let retval = retval."/"
  endif
  return retval
endfunction

" functions - grep/find search {{{
" GNU grep��windows �Ǥ� cygwin �� GNU grep�ˤ�Ȥäƥ��ե��������ʸ����
" ���롥
function! s:GrepSearch(searchWord, bRegexp)
  redraw!
  echo s:prefix_howm.s:msg_wait_search
	let searchWord = a:searchWord
  let retval = ""
	let searchPath = s:HowmExpand(g:howm_dir)
  " ������������ʸ�������äƤ��ʤ��ä�����ʸ����ʸ������̤��ʤ���
  let bIgnore = searchWord !~ '\C[A-Z]'

  if g:howm_grepprg == ""
    if &encoding != g:howm_fileencoding
      let searchWord = iconv(searchWord, &encoding, g:howm_fileencoding)
    endif
    let grepopt = ''
    if a:bRegexp
      let grepopt = grepopt.'E'
    else
      let grepopt = grepopt.'F'
    endif
    if bIgnore
      let grepopt = grepopt.'i'
    endif
    let retval = retval.GrepSearch(searchWord, searchPath, grepopt)
    let retval = iconv(retval, g:howm_fileencoding, &encoding)
  elseif !executable(g:howm_grepprg)
    call HowmDebugLog('GrepSearch:Can^t Execute g:howm_grepprg='.g:howm_grepprg)
    let errmsg = s:errmsg_inexecutable
    let errmsg = substitute(errmsg, '%prg%', g:howm_grepprg, 'g')
    let errmsg = substitute(errmsg, '%var%', 'howm_grepprg', 'g')
    redraw!
    echomsg s:prefix_howm.errmsg
    return ''
  else
    if has("win32")
      let searchPath = '"'.searchPath.'"'
    endif
    let grepcmd = 'g:howm_grepcmd'
    if a:bRegexp
      let grepcmd = grepcmd.'_regexp'
    else
      let grepcmd = grepcmd.'_fix'
    endif
    if bIgnore
      let grepcmd = grepcmd.'_ignore'
    endif
    call HowmDebugLog('GrepSearch:GrepCmd'.grepcmd)
    let retval = retval.HowmExecuteSearchPrg({grepcmd}, g:howm_grepprg, searchPath, searchWord, &encoding, g:howm_fileencoding)
  endif
  redraw!
  echo s:prefix_howm.s:msg_wait_search.s:msg_done
  call HowmDebugLog('FindSearch:Retval='.retval)
  return retval
endfunction

function! s:FindSearch()
  redraw!
  echo s:prefix_howm.s:msg_wait_search
  let retval = ""
	let searchPath = s:HowmExpand(g:howm_dir)
  if g:howm_findprg == ''
    let howm_dir = s:HowmExpand(g:howm_dir)
    let pathList = strpart(howm_dir, match(howm_dir, "\\S"))
    let idx = match(pathList, "\\s")
    if idx != -1
      let file = strpart(pathList, 0, idx)
      let pathList = strpart(pathList, idx)
    else
      let file = pathList
      let pathList = ""
    endif
    while file != ""
      let file = s:HowmExpand(file)
      if isdirectory(file)
        if file !~ "[\\/]$"
          let file = file."/"
        endif
        let file = file."*"
        let file = substitute(s:HowmExpand(file), "\<NL>", " ", "g")
        let pathList = file.pathList
      elseif filereadable(file)
        if has('win32') && substitute(file, '.*\.\(.\{-}\)', '\1', '') == 'lnk'
          " Win32 �Υ��硼�ȥ��åȤ��ɤ�����ν���
          silent! exe "new ".file
          let linkto = s:HowmExpand("%:p")
          silent! close
          if file != linkto
            let file = linkto
            continue
          endif
        endif
        let retval = retval.file.":0:\<NL>"
      endif
      let pathList = strpart(pathList, match(pathList, "\\S"))
      let idx = match(pathList, "\\s")
      if idx != -1
        let file = strpart(pathList, 0, idx)
        let pathList = strpart(pathList, idx)
      else
        let file = pathList
        let pathList = ""
      endif
    endwhile
  elseif !executable(g:howm_findprg)
    let errmsg = s:errmsg_inexecutable
    let errmsg = substitute(errmsg, '%prg%', g:howm_findprg, 'g')
    let errmsg = substitute(errmsg, '%var%', 'howm_findprg', 'g')
    redraw!
    echomsg s:prefix_howm.errmsg
  else
    if has("win32")
      let searchPath = '"'.searchPath.'"'
    endif
    call HowmDebugLog('FindSearch:FindCmd='.g:howm_findprg)
    let retval = retval.HowmExecuteSearchPrg(g:howm_findcmd, g:howm_findprg, searchPath, '', &encoding, &encoding)
    let retval = substitute(retval, '\n', ':0:\n', 'g')
  endif

  redraw!
  echo s:prefix_howm.s:msg_wait_search.s:msg_done
  call HowmDebugLog('FindSearch:Retval='.retval)
  return retval
endfunction

" functions - grep/find search }}}
" functions - sort {{{
" eval() ��ɾ���ͤ� compare() ����Ӥ�����̤ˤ������äƥ����Ȥ��롥
" compare(eval(a), eval(b)) �� a ����̤����٤������ֹ�ʤ���� 0��b ����
" �̤����٤������ֹ�ʤ�� 0 ���֤���
" compare(x, y): x, y �������ֹ桥
" eval(x): x �������ֹ桥
" swap(x, y): x, y �������ֹ桥
function! s:Sort(beginNum, endNum, compare, eval, pick, back)
  " merge sort
  call s:SortIter(a:beginNum, a:endNum, a:compare, a:eval, 'b:howm_SortBuf')
  let i = 1
  let len = a:endNum - a:beginNum + 1
  while i <= len
    call {a:pick}(b:howm_SortBuf{i}, i)
    unlet b:howm_SortBuf{i}
    let i = i + 1
  endwhile
  let i = 1
  while i <= len
    call {a:back}(i, i)
    let i = i + 1
  endwhile
endfunction

function! s:SortIter(beginNum, endNum, compare, eval, buffer)
  let len = a:endNum - a:beginNum + 1
  if len < 1
    return
  elseif len == 1
    let {a:buffer}1 = a:beginNum
    return
  else
    let mid = (a:beginNum + a:endNum) / 2
    call s:SortIter(a:beginNum, mid, a:compare, a:eval, a:buffer.'L')
    call s:SortIter(mid + 1, a:endNum, a:compare, a:eval, a:buffer.'R')
    let i = 1
    let j = 1
    let k = 1
    while  exists(a:buffer.'L'.i) && exists(a:buffer.'R'.j)
      if {a:compare}({a:eval}({a:buffer}R{j}), {a:eval}({a:buffer}L{i}))
        let {a:buffer}{k} = {a:buffer}R{j}
        unlet {a:buffer}R{j}
        let j = j + 1
      else
        let {a:buffer}{k} = {a:buffer}L{i}
        unlet {a:buffer}L{i}
        let i = i + 1
      endif
      let k = k + 1
    endwhile
    while exists(a:buffer.'L'.i)
      let {a:buffer}{k} = {a:buffer}L{i}
      unlet {a:buffer}L{i}
      let i = i + 1
      let k = k + 1
    endwhile
    while exists(a:buffer.'R'.j)
      let {a:buffer}{k} = {a:buffer}R{j}
      unlet {a:buffer}R{j}
      let j = j + 1
      let k = k + 1
    endwhile
  endif
endfunction
" function! s:Sort(beginNum, endNum, compare, eval, swap)
  " insert sort
  " let i = a:beginNum + 1
  " while i <= a:endNum
    " let j = i
    " while j > a:beginNum
      " if {a:compare}({a:eval}(j), {a:eval}(j - 1))
        " call {a:swap}(j, j - 1)
      " endif
      " let j = j - 1
    " endwhile
    " let i = i + 1
  " endwhile
  " quick sort
  " TODO:��������󤹤뤿��� merge sort �� insert sort �ˤ�������������
  " N^2 �� N logN �κ��������ۤɸ�����̤ο��������ʤ�����ġ�
  " ���米�����ʤ�㤦��
  " if a:beginNum < a:endNum
    " let mid = (a:beginNum + a:endNum) / 2
    " call {a:swap}(a:beginNum, mid)
    " let p = a:beginNum
    " let i = a:beginNum + 1
    " while i <= a:endNum
      " if {a:compare}({a:eval}(i), {a:eval}(a:beginNum))
        " let p = p + 1
        " call {a:swap}(i, p)
      " endif
      " let i = i + 1
    " endwhile
    " call {a:swap}(a:beginNum, p)
    " call s:Sort(a:beginNum, p - 1, a:compare, a:eval, a:swap)
    " call s:Sort(p + 1, a:endNum, a:compare, a:eval, a:swap)
  " endif
" endfunction

function! s:SortKeyInput()
  let key = input(s:prefix_howm.s:prompt_input_sortkey)
  if key == 'name'
    call s:SortByName()
  elseif key == 'name-match'
    call s:SortByNameMatch(input(s:prefix_howm.s:prompt_input_matchpattern))
  elseif key == 'mtime'
    call s:SortByMtime()
  elseif key == 'content'
    call s:SortByContent()
  elseif key == 'content-match'
    call s:SortByContentMatch(input(s:prefix_howm.s:prompt_input_matchpattern))
  elseif key == 'reverse'
    call s:Reverse()
  else
    " TODO:���顼��å�����
    return
  endif
  call s:FormatSearchResult()
endfunction

" ���ߤȵս�ˤ��롥
function! s:Reverse()
  let i = 1
  let endval = b:searchResultNum / 2
  while i <= endval
    call s:SwapSearchResult(i, b:searchResultNum - i + 1)
    let i = i + 1
  endwhile
endfunction

" �ե�����̾�򸵤˥����ȡ�
function! s:SortByName()
  call s:SortSearchResult('s:LessThan', 's:LoadFileName', 's:PickSearchResultEval', 's:BackSearchResultEval')
endfunction

" ���ꤷ���ե�����̾���̤˰ܤ���
function! s:SortByNameMatch(matchPattern)
  let b:matchPattern = a:matchPattern
  call s:SortSearchResult('s:GreaterThan', 's:MatchFileName', 's:PickSearchResultEval', 's:BackSearchResultEval')
  unlet b:matchPattern
endfunction

" �ե�����ι����������Ȥ˥����ȡ�
function! s:SortByMtime()
  call s:SortSearchResult('s:GreaterThan', 's:LoadMtime', 's:PickSearchResultEval', 's:BackSearchResultEval')
endfunction

" ������̤����Ƥ��Ȥ˥����ȡ�
function! s:SortByContent()
  call s:SortSearchResult('s:LessThan', 's:LoadContent', 's:PickSearchResultEval', 's:BackSearchResultEval')
endfunction

" ���ꤷ��������̤����Ƥ��̤˰ܤ���
function! s:SortByContentMatch(matchPattern)
  let b:matchPattern = a:matchPattern
  call s:SortSearchResult('s:GreaterThan', 's:MatchContent', 's:PickSearchResultEval', 's:BackSearchResultEval')
  unlet b:matchPattern
endfunction

" Todo ��ͥ���٤��Ȥ˥����ȡ�
function! s:SortByPriority()
  call s:SortSearchResult('s:CompareFraction', 's:Priority', 's:PickSearchResultEval', 's:BackSearchResultEval')
endfunction

" s:ParseSearchResult() �ǲ��Ϥ��줿������̤򥽡��ȡ�
function! s:SortSearchResult(compare, eval, pick, back)
  " let bt = localtime()
  redraw!
  echo s:prefix_howm.s:msg_wait_sort
  let i = 1
  while i <= b:searchResultNum
    let b:eval{i} = {a:eval}(i)
    let i = i + 1
  endwhile
  call s:Sort(1, b:searchResultNum, a:compare, 's:LoadSearchResultEval', a:pick, a:back)
  let i = 1
  while i <= b:searchResultNum
    unlet b:eval{i}
    let i = i + 1
  endwhile
  redraw!
  echo s:prefix_howm.s:msg_wait_sort.s:msg_done
  " echo localtime() - bt
endfunction

function! s:LoadSearchResultEval(x)
  return b:eval{a:x}
endfunction

function! s:LoadFileName(x)
  return strpart(b:file{a:x}, match(b:file{a:x}, '[^/]*$'))
endfunction

function! s:MatchFileName(x)
  return s:LoadFileName(a:x) =~ b:matchPattern
endfunction

function! s:LoadMtime(x)
  return getftime(b:file{a:x})
endfunction

function! s:LoadContent(x)
  return b:content{a:x}
endfunction

function! s:MatchContent(x)
  return s:LoadContent(a:x) =~ b:matchPattern
endfunction

function! s:PickSearchResult(x, y)
  let b:file_tmp{a:y} = b:file{a:x}
  let b:line_tmp{a:y} = b:line{a:x}
  let b:content_tmp{a:y} = b:content{a:x}
endfunction

function! s:PickSearchResultEval(x, y)
  call s:PickSearchResult(a:x, a:y)
  let b:eval_tmp{a:y} = b:eval{a:x}
endfunction

function! s:BackSearchResult(x, y)
  let b:file{a:x} = b:file_tmp{a:y}
  let b:line{a:x} = b:line_tmp{a:y}
  let b:content{a:x} = b:content_tmp{a:y}
  unlet b:file_tmp{a:y}
  unlet b:line_tmp{a:y}
  unlet b:content_tmp{a:y}
endfunction

function! s:BackSearchResultEval(x, y)
  call s:BackSearchResult(a:x, a:y)
  let b:eval{a:x} = b:eval_tmp{a:y}
  unlet b:eval_tmp{a:y}
endfunction

function! s:SwapSearchResult(x, y)
  let tmp = b:file{a:x}
  let b:file{a:x} = b:file{a:y}
  let b:file{a:y} = tmp
  let tmp = b:line{a:x}
  let b:line{a:x} = b:line{a:y}
  let b:line{a:y} = tmp
  let tmp = b:content{a:x}
  let b:content{a:x} = b:content{a:y}
  let b:content{a:y} = tmp
endfunction

function! s:SwapSearchResultEval(x, y)
  call s:SwapSearchResult(a:x, a:y)
  let tmp = b:eval{a:x}
  let b:eval{a:x} = b:eval{a:y}
  let b:eval{a:y} = tmp
endfunction

function! s:LessThan(x, y)
  return a:x < a:y
endfunction

function! s:GreaterThan(x, y)
  return a:x > a:y
endfunction

function! s:CompareFraction(x, y)
  let numer_x = substitute(a:x, '\(.*\)/\(.*\)', '\1', '') + 0
  let denomi_x = substitute(a:x, '\(.*\)/\(.*\)', '\2', '') + 0
  if denomi_x < 0
    let numer_x = numer_x * -1
    let denomi_x = denomi_x * -1
  endif
  let numer_y = substitute(a:y, '\(.*\)/\(.*\)', '\1', '') + 0
  let denomi_y = substitute(a:y, '\(.*\)/\(.*\)', '\2', '') + 0
  if denomi_y < 0
    let numer_y = numer_y * -1
    let denomi_y = denomi_y * -1
  endif
  return numer_x * denomi_y > numer_y * denomi_x
endfunction

function! s:Priority(x)
  if g:howm_reminder_old_format != 0
    return s:PriorityOld(a:x)
  endif
  let content = b:content{a:x}
  let content = strpart(content, match(content, '\['.s:pattern_date.'\]'))
  let date = matchstr(content, s:pattern_date)
  let day = HowmDate2Int(date, g:howm_date_pattern)
  let today = HowmDate2Int(strftime(g:howm_date_pattern), g:howm_date_pattern)
  let late = today - day
  let type = substitute(content, '\['.s:pattern_date.'\]\(.\)\(\d*\).*$', '\4', '')
  let lazy = substitute(content, '\['.s:pattern_date.'\]\(.\)\(\d*\).*$', '\5', '') + 0

  if type == '-'
    let func = 's:PriorityNormal'
  elseif type == '+'
    let func = 's:PriorityTodo'
  elseif type == '!'
    let func = 's:PriorityDeadline'
  elseif type == '@'
    let func = 's:PrioritySchedule'
  elseif type == '.'
    let func = 's:PriorityDone'
  else
    let func = 's:PriorityNormal'
    let lazy = 0
  endif

  if func != ''
    return {func}(late, lazy)
  else
    " TODO:���顼��å�����
    return 0
  endif
endfunction

" TODO:�����Ȥ��ʤ�������̯�˥����ȶ�礬�ۤʤ뤫�⡩
function! s:PriorityNormal(late, lazy)
  if a:lazy == 0
    let lz = s:laziness_normal
  else
    let lz = a:lazy
  endif
  if a:late < 0
    return (a:late - 77777 * lz).'/'.lz
  else
    return (a:late * -1).'/'.lz
  endif
endfunction

function! s:PriorityTodo(late, lazy)
  if a:lazy == 0
    let lz = s:laziness_todo
  else
    let lz = a:lazy
  endif
  if a:late < 0
    return (a:late - 77777 * lz).'/'.lz
  else
    return (-1 * s:init_todo * (a:late - lz)).'/'.lz
  endif
endfunction

function! s:PriorityDeadline(late, lazy)
  if a:lazy == 0
    let lz = s:laziness_deadline
  else
    let lz = a:lazy
  endif
  " TODO:�ۥ�ȤϤ���äȰ㤦����̩�ˤ� late �η׻���ˡ���Ѥ���٤���
  "      �ܲȤ� late �׻��� today �˻���ޤǻȤäƤ롥
  if a:late >= 0
    return (a:late + 77777 * lz).'/'.lz
  elseif a:late < (-1 * lz)
    return (a:late - 77777 * lz).'/'.lz
  else
    return (-1 * s:init_deadline * a:late).'/'.lz
  endif
endfunction

function! s:PrioritySchedule(late, lazy)
  if a:lazy == 0
    let lz = s:laziness_schedule
  else
    let lz = a:lazy
  endif
  if a:late > 0
    return (a:late - 77777 * lz).'/'.lz
  else
    return a:late.'/'.lz
  endif
endfunction

function! s:PriorityDone(late, lazy)
  return (a:late - 88888).'/1'
endfunction

" functions - sort }}}

function! s:GetDaysFromContent(content)
  if g:howm_reminder_old_format != 0
    return s:GetDaysFromContentOld(a:content)
  endif
  let content = strpart(a:content, match(a:content, '\['.s:pattern_date.'\]'))
  let date = matchstr(content, s:pattern_date)
  return HowmDate2Int(date, g:howm_date_pattern)
endfunction

" functions - debug {{{
function! HowmDebugLog(msg)
  if !g:howm_debug
    return
  endif
  if !exists('g:howm_debug_log')
    let g:howm_debug_log = ''
  endif
  let g:howm_debug_log = g:howm_debug_log.s:prefix_howm.a:msg."\<NL>"
endfunction

function! HowmOutputLog()
	if !g:howm_debug || !exists('g:howm_debug_log')
		return
	endif
	call s:OpenTemporalWindow(s:prefix_howm.'Debug Log', 1)
  let regbak = @z
  let @z = g:howm_debug_log
	silent! $put z
  let @z = regbak
	unlet g:howm_debug_log
endfunction
" functions - debug }}}

" functions }}}

call s:ParseKeyword()

" vim:set ts=2 sts=2 sw=2 tw=0 fdm=marker:

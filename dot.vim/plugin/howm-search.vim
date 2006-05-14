"
" howm-search.vim - howm-mode.vim �Ѥθ��������饤�֥��
"
" Last Change: 29-May-2005.
" Written By: Kouichi NANASHIMA <claymoremine@anet.ne.jp>

scriptencoding euc-jp

let s:errmsg_noiconv = 'iconv ���Ȥ��ʤ��Τ�ʸ�������ɤ��Ѵ��Ǥ��ޤ���'

function! HowmExecuteSearchPrg(cmd, prg, searchPath, searchWord, from_encoding, to_encoding)
  " iconv ���Ȥ��ʤ��Ȥ��ν���
  if a:from_encoding != a:to_encoding && !has('iconv')
    echoe s:errmsg_noiconv
    return
  endif

  let cmd = a:cmd

  " �ץ��������
  let cmd = substitute(cmd, '#prg#', escape(a:prg, '\\'), 'g')

  " �����ѥ�����
  let cmd = substitute(cmd, '#searchPath#', escape(a:searchPath, '\\'), 'g')

  " ����������
  let searchWord = a:searchWord
  if a:from_encoding != a:to_encoding
    let searchWord = iconv(searchWord, a:from_encoding, a:to_encoding)
  endif
  let cmd = substitute(cmd, '#searchWord#', searchWord, 'g')

  " ������ե��������
  if match(cmd, '#searchWordFile#') != -1
    let tempname = tempname()
    let opencmd = 'split'
    if a:from_encoding != a:to_encoding
      let opencmd = opencmd.' ++enc='.a:to_encoding
    endif
    let opencmd = opencmd.' '.tempname
    silent! exe opencmd
    unlet opencmd
    call setline(1, a:searchWord)
    silent! setlocal binary noendofline
    silent! w
    silent! bdelete
    let cmd = substitute(cmd, '#searchWordFile#', HowmEscapeVimPattern(tempname), 'g')
  endif

  " �������ޥ�ɼ¹�
  call HowmDebugLog('HowmExecuteSearchPrg:Cmd='.cmd)
  let retval = system(cmd)

  " ������ե�����õ�
  if exists('tempname')
    call delete(tempname)
  endif

  " ������̥��󥳡����Ѵ�
  if a:from_encoding != a:to_encoding
    let retval = iconv(retval, a:to_encoding, a:from_encoding)
  endif
  " ������̲��ԥ������Ѵ�
  let retval = substitute(retval, '\(\r\n\?\)', '\n', 'g')
  call HowmDebugLog('HowmExecuteSearchPrg:Retval='.retval)

  return retval
endfunction

"
" howm-pattern.vim - howm-mode.vim �Ѥ�ʸ����ѥ���������饤�֥��
"
" Last Change: 04-Jun-2006.
" Written By: Kouichi NANASHIMA <claymoremine@anet.ne.jp>

scriptencoding euc-jp

function! HowmEscapeVimPattern(pattern)
  let retval = escape(a:pattern, '\\.*+@{}<>~^$()|?[]%=&')
  let retval = retval
  return retval
endfunction

" ñ�Υƥ����Ѵؿ� {{{
if exists('g:howm_debug') && g:howm_debug
function! TestHowmPattern()
	call TestHowmEscapeVimPattern()
endfunction

function! TestHowmEscapeVimPattern()
	call VUAssertEquals(0, match('!', '\v'.HowmEscapeVimPattern('!')), '��!�פΥ���������')
  call VUAssertEquals(0, match('@', '\v'.HowmEscapeVimPattern('@')), '��@�פΥ���������')
  call VUAssertEquals(0, match('#', '\v'.HowmEscapeVimPattern('#')), '��#�פΥ���������')
  call VUAssertEquals(0, match('$', '\v'.HowmEscapeVimPattern('$')), '��$�פΥ���������')
  call VUAssertEquals(0, match('%', '\v'.HowmEscapeVimPattern('%')), '��%�פΥ���������')
  call VUAssertEquals(0, match('^', '\v'.HowmEscapeVimPattern('^')), '��^�פΥ���������')
  call VUAssertEquals(0, match('&', '\v'.HowmEscapeVimPattern('&')), '��&�פΥ���������')
  call VUAssertEquals(0, match('*', '\v'.HowmEscapeVimPattern('*')), '��*�פΥ���������')
  call VUAssertEquals(0, match('()', '\v'.HowmEscapeVimPattern('()')), '��()�פΥ���������')
  call VUAssertEquals(0, match('_', '\v'.HowmEscapeVimPattern('_')), '��_�פΥ���������')
  call VUAssertEquals(0, match('+', '\v'.HowmEscapeVimPattern('+')), '��+�פΥ���������')
  call VUAssertEquals(0, match('|', '\v'.HowmEscapeVimPattern('|')), '��|�פΥ���������')
  call VUAssertEquals(0, match('-', '\v'.HowmEscapeVimPattern('-')), '��-�פΥ���������')
  call VUAssertEquals(0, match('=', '\v'.HowmEscapeVimPattern('=')), '��=�פΥ���������')
  call VUAssertEquals(0, match('{}', '\v'.HowmEscapeVimPattern('{}')), '��{}�פΥ���������')
  call VUAssertEquals(0, match(':', '\v'.HowmEscapeVimPattern(':')), '��:�פΥ���������')
  call VUAssertEquals(0, match('"', '\v'.HowmEscapeVimPattern('"')), '��"�פΥ���������')
  call VUAssertEquals(0, match('<>', '\v'.HowmEscapeVimPattern('<>')), '��<>�פΥ���������')
  call VUAssertEquals(0, match('?', '\v'.HowmEscapeVimPattern('?')), '��?�פΥ���������')
  call VUAssertEquals(0, match('[]', '\v'.HowmEscapeVimPattern('[]')), '��[]�פΥ���������')
  call VUAssertEquals(0, match(';', '\v'.HowmEscapeVimPattern(';')), '��;�פΥ���������')
  call VUAssertEquals(0, match('\', '\v'.HowmEscapeVimPattern('\')), '��\�פΥ���������')
  call VUAssertEquals(0, match(',', '\v'.HowmEscapeVimPattern(',')), '��,�פΥ���������')
  call VUAssertEquals(0, match('.', '\v'.HowmEscapeVimPattern('.')), '��.�פΥ���������')
  call VUAssertEquals(0, match('/', '\v'.HowmEscapeVimPattern('/')), '��/�פΥ���������')
  call VUAssertEquals(0, match('~', '\v'.HowmEscapeVimPattern('~')), '��~�פΥ���������')
  call VUAssertEquals(0, match('!@#$%^&*()_+|-={}:"<>?[];\,./~', '\v'.HowmEscapeVimPattern('!@#$%^&*()_+|-={}:"<>?[];\,./~')), '��������פΥ���������')
endfunction

endif
" ñ�Υƥ����Ѵؿ� }}}

" vim:set ts=2 sts=2 sw=2 tw=0 fdm=marker:

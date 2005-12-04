" Vim color file

set bg=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "anyakichi"

" hi Cursor
" hi CursorIM
" hi Directory
" hi DiffAdd
" hi DiffChange
" hi DiffDelete
" hi DiffText
" hi ErrorMsg
" hi VertSplit
" hi Folded
" hi FoldColumn
" hi SignColumn
" hi IncSearch
hi LineNr	ctermfg=DarkRed
" hi ModeMsg
" hi MoreMsg
" hi NonText
" hi Normal
" hi Question
" hi Search
" hi SpecialKey
" hi StatusLine
" hi StatusLineNC
" hi Title
" hi Visual
" hi VisualNOS
" hi WarningMsg
" hi WildMenu


hi Comment	ctermfg=White

hi Constant	ctermfg=DarkYellow
hi String	ctermfg=White
" hi Character
" hi Number
" hi Boolean
" hi Float

hi Identifier	ctermfg=LightGray
" hi Function

hi Statement	ctermfg=Green
" hi Conditional
" hi Repeat
" hi Label
" hi Operator
" hi Keyword
" hi Exception

hi PreProc	ctermfg=Yellow
" hi Include
" hi Define
" hi Macro
" hi PreCondit

hi Type		ctermfg=Green
" hi StorageClass
" hi Structure
" hi Typedef

hi Special	ctermfg=Yellow
" hi SpecialChar
" hi Tag
" hi Delimiter
" hi SpecialComment
" hi Debug

" hi Underlined

" hi Ignore

" hi Error

" hi Todo

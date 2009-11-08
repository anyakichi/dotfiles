"
" anyakichi.vim:
" 	Anyakichi color scheme
"

set bg=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "anyakichi"

" hi Cursor
" hi CursorIM
" hi CursorColumn
hi CursorLine	cterm=none ctermbg=DarkGray
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
" hi MatchParen
" hi ModeMsg
" hi MoreMsg
" hi NonText
" hi Normal	cterm=bold	ctermfg=7
hi Pmenu	ctermfg=Black ctermbg=Gray
hi PmenuSel	ctermfg=Black ctermbg=DarkYellow
hi PmenuSbar	ctermbg=Black
hi PmenuThumb	ctermfg=DarkCyan
" hi Question
" hi Search
" hi SpecialKey
" hi SpellBad
" hi SpellCap
" hi SpellLocal
" hi SpellRare
" hi StatusLine
" hi StatusLineNC
" hi TabLine
" hi TabLineFill
" hi TabLineSel
" hi Title
" hi Visual
" hi VisualNOS
" hi WarningMsg
" hi WildMenu


hi Comment	ctermfg=DarkCyan

hi Constant	ctermfg=DarkYellow
hi String	ctermfg=Gray
" hi Character
" hi Number
" hi Boolean
" hi Float

hi Identifier	ctermfg=LightGray
" hi Function

hi Statement	ctermfg=DarkGreen
" hi Conditional
" hi Repeat
" hi Label
" hi Operator
" hi Keyword
" hi Exception

hi PreProc	ctermfg=DarkRed
" hi Include
" hi Define
" hi Macro
" hi PreCondit

hi Type		ctermfg=DarkGreen
" hi StorageClass
" hi Structure
" hi Typedef

hi Special	ctermfg=DarkYellow
" hi SpecialChar
" hi Tag
" hi Delimiter
" hi SpecialComment
" hi Debug

" hi Underlined

" hi Ignore

" hi Error

" hi Todo

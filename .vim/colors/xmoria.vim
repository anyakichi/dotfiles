" xmoria.vim
if !has("gui_running") && &t_Co < 256
  finish
endif

if exists("g:xmoria_style")
    let s:xmoria_style = g:xmoria_style
else
    let s:xmoria_style = &background
endif

if exists("g:xmoria_monochrome")
    let s:xmoria_monochrome = g:xmoria_monochrome
else
    let s:xmoria_monochrome = 0
endif

if exists("g:xmoria_fontface")
    let s:xmoria_fontface = g:xmoria_fontface
else
    let s:xmoria_fontface = "plain"
endif

execute "command! -nargs=1 Colo let g:xmoria_style = \"<args>\" | colo xmoria"

if s:xmoria_style == "black" || s:xmoria_style == "dark"
    set background=dark
elseif s:xmoria_style == "light" || s:xmoria_style == "white"
    set background=light
else
    let s:xmoria_style = &background
endif

if s:xmoria_style ==# "black"
    let s:fgbg_map = {'fg': '#d0d0d0', 'bg': '#000000'}
elseif s:xmoria_style ==# "dark"
    let s:fgbg_map = {'fg': '#d0d0d0', 'bg': '#202020'}
elseif s:xmoria_style ==# "light"
    let s:fgbg_map = {'fg': '#000000', 'bg': '#f0f0f0'}
else " white
    let s:fgbg_map = {'fg': '#000000', 'bg': '#ffffff'}
endif

let s:color_map = map({
\   'NONE': 'NONE',
\   '#000000':  16,
\   '#00008b':  18,
\   '#0000cd':  20,
\   '#0000f0':  21,
\   '#007080':  24,
\   '#008000':  28,
\   '#008b00':  28,
\   '#008b8b':  30,
\   '#00a0ff':  39,
\   '#00e700':  40,
\   '#00ffff':  51,
\   '#077807':  28,
\   '#1e90ff':  33,
\   '#1f3f81':  24,
\   '#202020': 234,
\   '#25365a':  23,
\   '#262626': 235,
\   '#2c2cee':  21,
\   '#2ceeee':  51,
\   '#2f4471':  23,
\   '#334b7d':  60,
\   '#375288': 231,
\   '#3a3a3a': 237,
\   '#404040': 238,
\   '#41609e':  61,
\   '#444444': 238,
\   '#494949': 238,
\   '#4a6db5':  61,
\   '#4c4c4c': 239,
\   '#4e4e4e': 239,
\   '#505050': 239,
\   '#606060':  59,
\   '#6381be':  67,
\   '#6e6e6e': 242,
\   '#707070': 242,
\   '#708bc5':  68,
\   '#786000':  94,
\   '#7a7a7a': 243,
\   '#7ec0ee': 111,
\   '#7ee0ce': 116,
\   '#800090':  90,
\   '#808080': 244,
\   '#813f11':  94,
\   '#87df71': 113,
\   '#883400':  94,
\   '#8b0000':  88,
\   '#8fa5d1': 110,
\   '#909090': 246,
\   '#90e090': 114,
\   '#912f11':  88,
\   '#97abd5': 110,
\   '#9a9a9a': 247,
\   '#a0a0a0': 247,
\   '#a0f0a0': 157,
\   '#a6b7db': 146,
\   '#b0b0b0': 145,
\   '#b6b6b6': 249,
\   '#b8c6e2': 152,
\   '#bdcae3': 152,
\   '#c0c0c0': 250,
\   '#c4c4c4': 251,
\   '#cdcdcd': 252,
\   '#cfcfcf': 252,
\   '#d0d0a0': 187,
\   '#d0d0d0': 252,
\   '#d3d3d3': 252,
\   '#d7a0d7': 182,
\   '#d7d7d7': 188,
\   '#d8d8d8': 188,
\   '#dfdfdf': 253,
\   '#e0cd78': 186,
\   '#e0e000': 184,
\   '#e8b87e': 180,
\   '#ee2c2c': 196,
\   '#ee2cee': 201,
\   '#f09479': 210,
\   '#f0f0f0': 255,
\   '#ffa500': 214,
\   '#ffcd78': 222,
\   '#ffff00': 226,
\   '#ffffff': 231,
\}, '[v:val, v:val]')

if !exists('g:xmoria_terminal_foreground')
    let g:xmoria_terminal_foreground = ''
endif
if !exists('g:xmoria_terminal_background')
    let g:xmoria_terminal_background = ''
endif
if exists("g:xmoria_terminal_colors")
    let s:i = 0
    while s:i < len(g:xmoria_terminal_colors)
        let s:color = tolower(g:xmoria_terminal_colors[s:i])
        if has_key(s:color_map, s:color) && s:i < 8
            let s:color_map[s:color][0] = s:i
        else
            let s:color_map[s:color] = [s:i, s:i]
        endif
        let s:i += 1
    endwhile
    unlet s:i s:color
endif

function! s:highlight(name, ...)
    let hi = {'cterm': 'NONE', 'ctermfg': 'NONE', 'ctermbg': 'NONE'}
    for i in filter(copy(a:000), 'v:val !~ "^cterm"')
        let [k, v] = split(i, '=')
        let hi[k] = v
    endfor

    let hi['cterm'] = get(hi, 'gui', 'NONE')

    let bg = get(hi, 'guibg', 'NONE')
    let bg = get(s:fgbg_map, bg, bg)
    if bg ==? g:xmoria_terminal_background
        let bg = 'NONE'
    endif
    let hi['ctermbg'] = s:color_map[bg][0]

    let fg = get(hi, 'guifg', 'NONE')
    let fg = get(s:fgbg_map, fg, fg)
    if fg ==? g:xmoria_terminal_foreground && a:name !~# '^Diff.*'
        " Don't transparent Diff syntax that is apparently layered
        let fg = 'NONE'
    endif
    let hi['ctermfg'] = s:color_map[fg][hi['cterm'] =~ 'bold']

    execute 'hi' a:name join(map(items(hi), 'join(v:val, "=")') , ' ')
endfunction

command! -nargs=+ Hi call s:highlight(<f-args>)

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "xmoria"

if &background == "dark"
    if s:xmoria_style == "dark"
        Hi Normal guibg=#202020 guifg=#d0d0d0 gui=none

        Hi ColorColumn guibg=#262626 gui=none
        Hi CursorColumn guibg=#404040 gui=none
        Hi CursorLine guibg=#404040 gui=none
    elseif s:xmoria_style == "black"
        Hi Normal guibg=#000000 guifg=#d0d0d0 gui=none

        Hi ColorColumn guibg=#202020 gui=none
        Hi CursorColumn guibg=#3a3a3a gui=none
        Hi CursorLine guibg=#3a3a3a gui=none
    endif
    if s:xmoria_monochrome == 1
        Hi FoldColumn guibg=bg guifg=#a0a0a0 gui=none
        Hi CursorLineNr guifg=#a0a0a0 gui=bold
        Hi LineNr guifg=#a0a0a0 gui=none
        Hi MoreMsg guibg=bg guifg=#b6b6b6 gui=bold
        Hi NonText guibg=bg guifg=#a0a0a0 gui=bold
        Hi Pmenu guibg=#909090 guifg=#000000 gui=none
        Hi PmenuSbar guibg=#707070 guifg=fg gui=none
        Hi PmenuThumb guibg=#d0d0d0 guifg=bg gui=none
        Hi SignColumn guibg=bg guifg=#a0a0a0 gui=none
        Hi StatusLine guibg=#4c4c4c guifg=fg gui=bold
        Hi StatusLineNC guibg=#404040 guifg=fg gui=none
        Hi TabLine guibg=#6e6e6e guifg=fg gui=none
        Hi TabLineFill guibg=#6e6e6e guifg=fg gui=none
        Hi VertSplit guibg=#404040 guifg=fg gui=none
        if s:xmoria_fontface == "mixed"
            Hi Folded guibg=#4e4e4e guifg=#c0c0c0 gui=bold
        else
            Hi Folded guibg=#4e4e4e guifg=#c0c0c0 gui=none
        endif
    else
        Hi FoldColumn guibg=bg guifg=#8fa5d1 gui=none
        Hi CursorLineNr guifg=#8fa5d1 gui=bold
        Hi LineNr guifg=#8fa5d1 gui=none
        Hi MoreMsg guibg=bg guifg=#97abd5 gui=bold
        Hi NonText guibg=bg guifg=#8fa5d1 gui=bold
        Hi Pmenu guibg=#6381be guifg=#000000 gui=none
        Hi PmenuSbar guibg=#41609e guifg=fg gui=none
        Hi PmenuThumb guibg=#bdcae3 guifg=bg gui=none
        Hi SignColumn guibg=bg guifg=#8fa5d1 gui=none
        Hi StatusLine guibg=#334b7d guifg=fg gui=bold
        Hi StatusLineNC guibg=#25365a guifg=fg gui=none
        Hi TabLine guibg=#334b7d guifg=fg gui=none
        Hi TabLineFill guibg=#334b7d guifg=fg gui=none
        Hi VertSplit guibg=#25365a guifg=fg gui=none
        if s:xmoria_fontface == "mixed"
            Hi Folded guibg=#4e4e4e guifg=#bdcae3 gui=bold
        else
            Hi Folded guibg=#4e4e4e guifg=#bdcae3 gui=none
        endif
    endif
    Hi Cursor guibg=#ffa500 guifg=bg gui=none
    Hi DiffAdd guibg=#008b00 guifg=fg gui=none
    Hi DiffChange guibg=#00008b guifg=fg gui=none
    Hi DiffDelete guibg=#8b0000 guifg=fg gui=none
    Hi DiffText guibg=#0000cd guifg=fg gui=bold
    Hi Directory guibg=bg guifg=#1e90ff gui=none
    Hi ErrorMsg guibg=#ee2c2c guifg=#ffffff gui=bold
    Hi IncSearch guibg=#e0cd78 guifg=#000000 gui=none
    Hi ModeMsg guibg=bg guifg=fg gui=bold
    Hi PmenuSel guibg=#e0e000 guifg=#000000 gui=none
    Hi Question guibg=bg guifg=#e8b87e gui=bold
    Hi Search guibg=#90e090 guifg=#000000 gui=none
    Hi SpecialKey guibg=bg guifg=#e8b87e gui=none
    if has("spell")
        Hi SpellBad guisp=#ee2c2c gui=undercurl
        Hi SpellCap guisp=#2c2cee gui=undercurl
        Hi SpellLocal guisp=#2ceeee gui=undercurl
        Hi SpellRare guisp=#ee2cee gui=undercurl
    endif
    Hi TabLineSel guibg=bg guifg=fg gui=bold
    Hi Title guifg=fg gui=bold
    if version >= 700
        Hi Visual guibg=#606060 gui=none
    else
        Hi Visual guibg=#606060 guifg=fg gui=none
    endif
    Hi VisualNOS guibg=bg guifg=#a0a0a0 gui=bold,underline
    Hi WarningMsg guibg=bg guifg=#ee2c2c gui=bold
    Hi WildMenu guibg=#e0e000 guifg=#000000 gui=bold

    Hi Comment guibg=bg guifg=#d0d0a0 gui=none
    Hi Constant guibg=bg guifg=#87df71 gui=none
    Hi Error guibg=bg guifg=#ee2c2c gui=none
    Hi Identifier guibg=bg guifg=#7ee0ce gui=none
    Hi Ignore guibg=bg guifg=bg gui=none
    Hi lCursor guibg=#00e700 guifg=#000000 gui=none
    Hi MatchParen guibg=#008b8b gui=none
    Hi PreProc guibg=bg guifg=#d7a0d7 gui=none
    Hi Special guibg=bg guifg=#e8b87e gui=none
    Hi Todo guibg=#e0e000 guifg=#000000 gui=none
    Hi Underlined guibg=bg guifg=#00a0ff gui=underline

    if s:xmoria_fontface == "mixed"
        Hi Statement guibg=bg guifg=#7ec0ee gui=bold
        Hi Type guibg=bg guifg=#f09479 gui=bold
    else
        Hi Statement guibg=bg guifg=#7ec0ee gui=none
        Hi Type guibg=bg guifg=#f09479 gui=none
    endif
elseif &background == "light"
    if s:xmoria_style == "light"
        Hi Normal guibg=#f0f0f0 guifg=#000000 gui=none

        Hi ColorColumn guibg=#d3d3d3 gui=none
        Hi CursorColumn guibg=#d8d8d8 gui=none
        Hi CursorLine guibg=#d8d8d8 gui=none
    elseif s:xmoria_style == "white"
        Hi Normal guibg=#ffffff guifg=#000000 gui=none

        Hi ColorColumn guibg=#d7d7d7 gui=none
        Hi CursorColumn guibg=#dfdfdf gui=none
        Hi CursorLine guibg=#dfdfdf gui=none
    endif
    if s:xmoria_monochrome == 1
        Hi FoldColumn guibg=bg guifg=#7a7a7a gui=none
        Hi Folded guibg=#cfcfcf guifg=#404040 gui=bold
        Hi CursorLineNr guifg=#7a7a7a gui=bold
        Hi LineNr guifg=#7a7a7a gui=none
        Hi MoreMsg guibg=bg guifg=#505050 gui=bold
        Hi NonText guibg=bg guifg=#7a7a7a gui=bold
        Hi Pmenu guibg=#9a9a9a guifg=#000000 gui=none
        Hi PmenuSbar guibg=#808080 guifg=fg gui=none
        Hi PmenuThumb guibg=#c0c0c0 guifg=fg gui=none
        Hi SignColumn guibg=bg guifg=#7a7a7a gui=none
        Hi StatusLine guibg=#a0a0a0 guifg=fg gui=bold
        Hi StatusLineNC guibg=#b0b0b0 guifg=fg gui=none
        Hi TabLine guibg=#cdcdcd guifg=fg gui=none
        Hi TabLineFill guibg=#cdcdcd guifg=fg gui=none
        Hi VertSplit guibg=#b0b0b0 guifg=fg gui=none
    else
        Hi FoldColumn guibg=bg guifg=#375288 gui=none
        Hi Folded guibg=#cfcfcf guifg=#25365a gui=bold
        Hi CursorLineNr guifg=#375288 gui=bold
        Hi LineNr guifg=#375288 gui=none
        Hi MoreMsg guibg=bg guifg=#2f4471 gui=bold
        Hi NonText guibg=bg guifg=#375288 gui=bold
        Hi Pmenu guibg=#708bc5 guifg=#000000 gui=none
        Hi PmenuSbar guibg=#4a6db5 guifg=fg gui=none
        Hi PmenuThumb guibg=#a6b7db guifg=fg gui=none
        Hi SignColumn guibg=bg guifg=#375288 gui=none
        Hi StatusLine guibg=#8fa5d1 guifg=fg gui=bold
        Hi StatusLineNC guibg=#a6b7db guifg=fg gui=none
        Hi TabLine guibg=#b8c6e2 guifg=fg gui=none
        Hi TabLineFill guibg=#b8c6e2 guifg=fg gui=none
        Hi VertSplit guibg=#a6b7db guifg=fg gui=none
    endif
    Hi Cursor guibg=#883400 guifg=bg gui=none
    Hi DiffAdd guibg=#008b00 guifg=#ffffff gui=none
    Hi DiffChange guibg=#00008b guifg=#ffffff gui=none
    Hi DiffDelete guibg=#8b0000 guifg=#ffffff gui=none
    Hi DiffText guibg=#0000cd guifg=#ffffff gui=bold
    Hi Directory guibg=bg guifg=#0000f0 gui=none
    Hi ErrorMsg guibg=#ee2c2c guifg=#ffffff gui=bold
    Hi IncSearch guibg=#ffcd78 gui=none
    Hi ModeMsg guibg=bg guifg=fg gui=bold
    Hi PmenuSel guibg=#ffff00 guifg=#000000 gui=none
    Hi Question guibg=bg guifg=#813f11 gui=bold
    Hi Search guibg=#a0f0a0 gui=none
    Hi SpecialKey guibg=bg guifg=#912f11 gui=none
    if has("spell")
        Hi SpellBad guisp=#ee2c2c gui=undercurl
        Hi SpellCap guisp=#2c2cee gui=undercurl
        Hi SpellLocal guisp=#008b8b gui=undercurl
        Hi SpellRare guisp=#ee2cee gui=undercurl
    endif
    Hi TabLineSel guibg=bg guifg=fg gui=bold
    Hi Title guifg=fg gui=bold
    if version >= 700
        Hi Visual guibg=#c4c4c4 gui=none
    else
        Hi Visual guibg=#c4c4c4 guifg=fg gui=none
    endif
    Hi VisualNOS guibg=bg guifg=#a0a0a0 gui=bold,underline
    Hi WarningMsg guibg=bg guifg=#ee2c2c gui=bold
    Hi WildMenu guibg=#ffff00 guifg=fg gui=bold

    Hi Comment guibg=bg guifg=#786000 gui=none
    Hi Constant guibg=bg guifg=#077807 gui=none
    Hi Error guibg=bg guifg=#ee2c2c gui=none
    Hi Identifier guibg=bg guifg=#007080 gui=none
    Hi Ignore guibg=bg guifg=bg gui=none
    Hi lCursor guibg=#008000 guifg=#ffffff gui=none
    Hi MatchParen guibg=#00ffff gui=none
    Hi PreProc guibg=bg guifg=#800090 gui=none
    Hi Special guibg=bg guifg=#912f11 gui=none
    Hi Statement guibg=bg guifg=#1f3f81 gui=bold
    Hi Todo guibg=#ffff00 guifg=fg gui=none
    Hi Type guibg=bg guifg=#912f11 gui=bold
    Hi Underlined guibg=bg guifg=#0000cd gui=underline
endif

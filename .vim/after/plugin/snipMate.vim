"
" after/plugin/snipMate.vim
"	Fixup snipMate.vim mappings
"

iunmap <Tab>
sunmap <Tab>
iunmap <S-Tab>
sunmap <S-Tab>

inoremap <silent> <C-]> <C-r>=TriggerSnippet("\<C-]>", 1)<CR>
inoremap <silent> <Tab> <C-r>=TriggerSnippet("\<Tab>", 0)<CR>
snoremap <silent> <C-]> <Esc>i<Right><C-r>=TriggerSnippet("\<C-]>", 1)<CR>
snoremap <silent> <Tab> <Esc>i<Right><C-r>=TriggerSnippet("\<Tab>", 0)<CR>
inoremap <silent> <S-Tab> <c-r>=BackwardsSnippet("\<S-Tab>")<CR>
snoremap <silent> <S-Tab> <Esc>i<Right><C-r>=BackwardsSnippet("\<S-Tab>")<CR>

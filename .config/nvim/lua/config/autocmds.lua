local augroup = vim.api.nvim_create_augroup("Config", {})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  pattern = "OceanicNext",
  callback = function(_)
    vim.cmd("highlight! Normal guifg=#c0c5ce guibg=#1b2b34")
    vim.cmd("highlight! Statement gui=NONE")
    vim.cmd("highlight! link Conditional Statement")
    vim.cmd("highlight! link Repeat Statement")
    vim.cmd("highlight! link Label Statement")
    vim.cmd("highlight! link Keyword Statement")
    vim.cmd("highlight! link Exception Statement")
    vim.cmd("highlight! PreProc guifg=#c594c5")
    vim.cmd("highlight! link Include PreProc")
    vim.cmd("highlight! link Define PreProc")
    vim.cmd("highlight! link Macro PreProc")
    vim.cmd("highlight! link PreCondit PreProc")
    vim.cmd("highlight! Error guifg=bg guibg=#ec5f67")
    vim.cmd("highlight! Todo guifg=bg guibg=#fac863")
    vim.cmd("highlight! LspInformationText gui=inverse")
    vim.cmd("highlight! SpellBad guisp=#ec5f67")
    vim.cmd("highlight! Spelllocal guisp=#5fb3b3")
    vim.cmd("highlight! SpellCap guisp=#6699cc")
    vim.cmd("highlight! SpellRare guisp=#c594c5")
    vim.cmd("highlight! link mailHeaderKey Constant")
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  pattern = "base16-*",
  callback = function(_)
    vim.cmd("highlight! Statement gui=NONE")
    vim.cmd("highlight! link Conditional Statement")
    vim.cmd("highlight! link Repeat Statement")
    vim.cmd("highlight! link Label Statement")
    vim.cmd("highlight! link Keyword Statement")
    vim.cmd("highlight! link Exception Statement")
    vim.cmd("highlight! Folded gui=italic")
    vim.cmd("highlight! Comment gui=italic")
    vim.cmd("execute 'highlight! Identifier guifg=#' . g:base16_gui0C")
    vim.cmd("execute 'highlight! PreProc guifg=#' . g:base16_gui0E")
    vim.cmd("highlight! link Include PreProc")
    vim.cmd("highlight! link Macro PreProc")
    vim.cmd("highlight! link Structure Type")
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  group = augroup,
  callback = function(_)
    vim.opt_local.cursorline = false
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufRead" }, {
  group = augroup,
  callback = function(_)
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function(_)
    vim.cmd("wincmd =")
  end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = augroup,
  pattern = "[^l]*",
  callback = function(_)
    vim.cmd("cwindow")
    vim.g.qfutil_mode = "c"
  end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = augroup,
  pattern = "l*",
  callback = function(_)
    vim.cmd("lwindow")
    vim.g.qfutil_mode = "l"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "c", "go", "help" },
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = {
    "css",
    "docbk",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "lua",
    "markdown",
    "ocaml",
    "reason",
    "rescript",
    "rst",
    "ruby",
    "scheme",
    "scss",
    "tex",
    "typescript",
    "typescriptreact",
    "xhtml",
    "xml",
    "yaml",
  },
  callback = function()
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = {
    "asciidoc",
    "gitcommit",
    "mail",
    "markdown",
    "rst",
    "tex",
    "text",
  },
  callback = function()
    vim.opt_local.textwidth = 72
    vim.b.spell = -1
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "python",
  callback = function()
    vim.opt_local.softtabstop = 0
    vim.opt_local.formatoptions:remove("t")
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = augroup,
  callback = function()
    vim.cmd("let &l:spell = !!get(b:, 'spell', 0)")
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup,
  callback = function()
    vim.cmd("let &l:spell = !(get(b:, 'spell', 0) - 1)")
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  pattern = "*.pdf",
  callback = function()
    vim.cmd("silent %!pdftotext -nopgbrk -layout '%' -")
  end,
})

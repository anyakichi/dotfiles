local augroup = vim.api.nvim_create_augroup("Config", {})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup,
  pattern = { "OceanicNext", "OceanicNextLight" },
  callback = function(args)
    vim.api.nvim_set_hl(0, "@text", {})
    vim.api.nvim_set_hl(0, "@text.literal", { link = "Comment" })
    vim.api.nvim_set_hl(0, "@text.reference", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@text.title", { link = "Title" })
    vim.api.nvim_set_hl(0, "@text.uri", { link = "Underlined" })
    vim.api.nvim_set_hl(0, "@text.underline", { link = "Underlined" })
    vim.api.nvim_set_hl(0, "@text.todo", { link = "Todo" })
    vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
    vim.api.nvim_set_hl(0, "@punctuation", { link = "Delimiter" })
    vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
    vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Special" })
    vim.api.nvim_set_hl(0, "@constant.macro", { link = "Define" })
    vim.api.nvim_set_hl(0, "@define", { link = "Define" })
    vim.api.nvim_set_hl(0, "@macro", { link = "Macro" })
    vim.api.nvim_set_hl(0, "@string", { link = "String" })
    vim.api.nvim_set_hl(0, "@string.escape", { link = "SpecialChar" })
    vim.api.nvim_set_hl(0, "@string.special", { link = "SpecialChar" })
    vim.api.nvim_set_hl(0, "@character", { link = "Character" })
    vim.api.nvim_set_hl(0, "@character.special", { link = "SpecialChar" })
    vim.api.nvim_set_hl(0, "@number", { link = "Number" })
    vim.api.nvim_set_hl(0, "@boolean", { link = "Boolean" })
    vim.api.nvim_set_hl(0, "@float", { link = "Float" })
    vim.api.nvim_set_hl(0, "@function", { link = "Function" })
    vim.api.nvim_set_hl(0, "@function.builtin", { link = "Special" })
    vim.api.nvim_set_hl(0, "@function.macro", { link = "Macro" })
    vim.api.nvim_set_hl(0, "@parameter", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@method", { link = "Function" })
    vim.api.nvim_set_hl(0, "@field", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@property", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@constructor", { link = "Special" })
    vim.api.nvim_set_hl(0, "@conditional", { link = "Conditional" })
    vim.api.nvim_set_hl(0, "@repeat", { link = "Repeat" })
    vim.api.nvim_set_hl(0, "@label", { link = "Label" })
    vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
    vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "@exception", { link = "Exception" })
    vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@type", { link = "Type" })
    vim.api.nvim_set_hl(0, "@type.definition", { link = "Typedef" })
    vim.api.nvim_set_hl(0, "@storageclass", { link = "StorageClass" })
    vim.api.nvim_set_hl(0, "@structure", { link = "Structure" })
    vim.api.nvim_set_hl(0, "@namespace", { link = "Identifier" })
    vim.api.nvim_set_hl(0, "@include", { link = "Include" })
    vim.api.nvim_set_hl(0, "@preproc", { link = "PreProc" })
    vim.api.nvim_set_hl(0, "@debug", { link = "Debug" })
    vim.api.nvim_set_hl(0, "@tag", { link = "Tag" })

    vim.api.nvim_set_hl(0, "@lsp", {})
    vim.api.nvim_set_hl(0, "@lsp.type.class", { link = "@structure" })
    vim.api.nvim_set_hl(0, "@lsp.type.comment", { link = "@comment" })
    vim.api.nvim_set_hl(0, "@lsp.type.decorator", { link = "@function.macro" })
    vim.api.nvim_set_hl(0, "@lsp.type.enum", { link = "@type" })
    vim.api.nvim_set_hl(0, "@lsp.type.enumMember", { link = "@constant" })
    vim.api.nvim_set_hl(0, "@lsp.type.function", { link = "@function" })
    vim.api.nvim_set_hl(0, "@lsp.type.interface", { link = "@constructor" })
    vim.api.nvim_set_hl(0, "@lsp.type.macro", { link = "@macro" })
    vim.api.nvim_set_hl(0, "@lsp.type.method", { link = "@method" })
    vim.api.nvim_set_hl(0, "@lsp.type.namespace", { link = "@namespace" })
    vim.api.nvim_set_hl(0, "@lsp.type.parameter", { link = "@parameter" })
    vim.api.nvim_set_hl(0, "@lsp.type.property", { link = "@property" })
    vim.api.nvim_set_hl(0, "@lsp.type.struct", { link = "@structure" })
    vim.api.nvim_set_hl(0, "@lsp.type.type", { link = "@type" })
    vim.api.nvim_set_hl(0, "@lsp.type.typeParameter", { link = "@type.definition" })
    vim.api.nvim_set_hl(0, "@lsp.type.variable", { link = "@variable" })

    vim.api.nvim_set_hl(0, "@field", {})
    vim.api.nvim_set_hl(0, "@keyword.operator", { link = "Statement" })
    vim.api.nvim_set_hl(0, "@namespace", {})
    vim.api.nvim_set_hl(0, "@operator", {})
    vim.api.nvim_set_hl(0, "@property", {})
    vim.api.nvim_set_hl(0, "@punctuation", {})
    vim.api.nvim_set_hl(0, "@punctuation.bracket", {})
    vim.api.nvim_set_hl(0, "@punctuation.delimiter", {})
    vim.api.nvim_set_hl(0, "@punctuation.special", {})
    vim.api.nvim_set_hl(0, "@variable", {})
    vim.api.nvim_set_hl(0, "@variable.builtin", { link = "Special" })

    vim.api.nvim_set_hl(0, "Define", { link = "PreProc" })
    vim.api.nvim_set_hl(0, "Include", { link = "PreProc" })
    vim.api.nvim_set_hl(0, "Macro", { link = "PreProc" })
    vim.api.nvim_set_hl(0, "Conditional", { link = "Statement" })
    vim.api.nvim_set_hl(0, "Repeat", { link = "Statement" })
    vim.api.nvim_set_hl(0, "Label", { link = "Statement" })
    vim.api.nvim_set_hl(0, "Keyword", { link = "Statement" })
    vim.api.nvim_set_hl(0, "Exception", { link = "Statement" })

    if args.match == "OceanicNext" then
      vim.api.nvim_set_hl(0, "Normal", { fg = "#c0c5ce", bg = "#1b2b34" })
      vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#2a4727" })
      vim.api.nvim_set_hl(0, "DiffChange", { bg = "#3e5270" })
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#472727" })
      vim.api.nvim_set_hl(0, "DiffText", { fg = "#cdd3de", bg = "#4d688c" })
    else
      vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#c3e6be" })
      vim.api.nvim_set_hl(0, "DiffChange", { bg = "#dde6ee" })
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#f9d8d6" })
      vim.api.nvim_set_hl(0, "DiffText", { bg = "#b6cbde" })
    end
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Pmenu" })
    vim.api.nvim_set_hl(0, "Statement", { fg = "#ec5f67" })
    vim.api.nvim_set_hl(0, "PreProc", { fg = "#c594c5" })
    vim.api.nvim_set_hl(0, "Structure", { fg = "#62b3b2", bold = true })
    vim.api.nvim_set_hl(0, "Special", { fg = "#ab7967" })
    vim.api.nvim_set_hl(0, "Error", { fg = "#1b2b34", bg = "#ec5f67" })
    vim.api.nvim_set_hl(0, "Todo", { fg = "#1b2b34", bg = "#fac863" })
    vim.api.nvim_set_hl(0, "SpellBad", { sp = "#ec5f67", undercurl = true })
    vim.api.nvim_set_hl(0, "SpellLocal", { sp = "#5fb3b3", undercurl = true })
    vim.api.nvim_set_hl(0, "SpellCap", { sp = "#6699cc", undercurl = true })
    vim.api.nvim_set_hl(0, "SpellRare", { sp = "#c594c5", undercurl = true })
    vim.api.nvim_set_hl(0, "LspInformationText", { reverse = true })

    vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { fg = "#4f5b66", nocombine = true })

    vim.api.nvim_set_hl(0, "mailHeaderKey", { link = "Constant" })
    vim.api.nvim_set_hl(0, "mailQuoted1", { fg = "#62b3b2" })
    vim.api.nvim_set_hl(0, "mailQuoted2", { fg = "#99c794" })
    vim.api.nvim_set_hl(0, "mailQuoted3", { fg = "#c594c5" })
    vim.api.nvim_set_hl(0, "mailQuoted4", { link = "mailQuoted1" })
    vim.api.nvim_set_hl(0, "mailQuoted5", { link = "mailQuoted2" })
    vim.api.nvim_set_hl(0, "mailQuoted6", { link = "mailQuoted3" })
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
  pattern = { "c", "cpp" },
  callback = function()
    if vim.fn.executable("clang-format") == 1 then
      local indent_width =
        tonumber(vim.fn.system("clang-format -dump-config | awk '/^IndentWidth:/ {print $NF}'"))
      vim.opt_local.shiftwidth = indent_width
      if indent_width == 8 then
        vim.opt_local.expandtab = false
      end
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "go", "help" },
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
  pattern = {
    "asciidoc",
    "gitcommit",
    "mail",
    "markdown",
    "rst",
    "text",
  },
  callback = function()
    vim.opt_local.comments:prepend({
      "b:- [ ]",
      "b:- [x]",
      "b:-",
      "b:* [ ]",
      "b:* [x]",
      "b:*",
      "b:1.",
      "nb:>",
    })
    vim.opt_local.formatoptions:append("ro")
    vim.opt_local.formatoptions:remove("c")
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
  pattern = "markdown",
  callback = function()
    vim.keymap.set("i", "<C-g>D", function()
      return os.date("## %Y-%m-%d\n\n")
    end, { expr = true })
    vim.keymap.set("i", "<C-g><C-d>", function()
      return os.date("## [[%Y-%m-%d]]\n\n")
    end, { expr = true })
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

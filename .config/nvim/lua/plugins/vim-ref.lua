return {
  "thinca/vim-ref",
  cmd = "Ref",
  init = function()
    vim.g.ref_man_cmd = "man"
    vim.g.ref_man_lang = "C"
    vim.g.ref_detect_filetype = { _ = "man" }
    vim.g.ref_no_default_key_mappings = 1

    vim.cmd(
      'cabbrev <expr> R   (getcmdline() =~# "^R" && getcmdpos() == 2) ? "Ref " . ref#detect() : "R"'
    )
    vim.cmd('cabbrev <expr> Man (getcmdline() =~# "^Man" && getcmdpos() == 4) ? "Ref man" : "Man"')
  end,
}

return {
  "michaelb/sniprun",
  cmd = "SnipRun",
  keys = {
    { "<Leader>r", "<Plug>SnipRunOperator", silent = true },
    { "<Leader>r", "<Plug>SnipRun", mode = "x", silent = true },
    { "<Leader>rr", "<Cmd>SnipRun<CR>", silent = true },
    { "<Leader>rR", "<Cmd>%SnipRun<CR>", silent = true },
    { "<Leader>r<C-r>", "<Cmd>SnipReset<CR>", silent = true },
    { "<Leader>R", "<Cmd>%SnipRun<CR>", silent = true },
  },
  build = "bash install.sh",
  opts = {
    display = {
      "TempFloatingWindow",
    },
    snipruncolors = {
      SniprunFloatingWinOk = { ctermfg = 10, fg = "#cdd3de" },
      SniprunFloatingWinErr = { ctermfg = 1, fg = "#ec5f67" },
    },
  },
}

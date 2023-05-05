return {
  "t9md/vim-quickhl",
  event = "VeryLazy",
  init = function()
    vim.keymap.set({ "n", "x" }, "<Space>m", "<Plug>(quickhl-manual-this)")
    vim.keymap.set("n", "<Space>M", ":<C-u>QuickhlManualAdd!<Space>")
    vim.keymap.set("n", "<Space>n", "<Plug>(quickhl-manual-toggle)")
    vim.keymap.set("n", "<Space>N", "<Plug>(quickhl-manual-reset)")
    vim.keymap.set(
      "n",
      "<Esc><Esc>",
      "<Plug>(quickhl-manual-reset)<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>"
    )
  end,
}

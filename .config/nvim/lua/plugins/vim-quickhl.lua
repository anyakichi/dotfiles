return {
  "t9md/vim-quickhl",
  event = "VeryLazy",
  init = function()
    vim.keymap.set({ "n", "x" }, "<Space>m", "<Plug>(quickhl-manual-this)")
    vim.keymap.set("n", "<Space>M", "<Plug>(quickhl-manual-reset)")
    vim.keymap.set("n", "<Space><C-m>", "<Plug>(quickhl-manual-toggle)")

    local augroup = vim.api.nvim_create_augroup("PluginsQuickhl", {})
    vim.api.nvim_create_autocmd("OptionSet", {
      group = augroup,
      pattern = "hlsearch",
      callback = function()
        if not vim.opt.hlsearch:get() then
          vim.cmd("QuickhlManualReset")
        end
      end,
    })
  end,
}

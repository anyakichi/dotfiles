return {
  "stevearc/aerial.nvim",
  cmd = { "AerialToggle", "AerialNavToggle" },
  init = function()
    vim.keymap.set("n", "<Leader>a", "<cmd>AerialToggle!<CR>")
    vim.keymap.set("n", "<Leader>A", "<cmd>AerialNavToggle<CR>")
  end,
  opts = {
    layout = {
      min_width = 20,
      default_direction = "float",
    },
    float = {
      relative = "win",
      override = function(conf, source_winid)
        conf.col = vim.fn.winwidth(source_winid)
        conf.row = 0
      end,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

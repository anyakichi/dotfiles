local function star(char)
  return function()
    vim.opt.hlsearch = true
    require("hlslens").start()
    return char
  end
end

return {
  "petertriho/nvim-scrollbar",
  event = "VeryLazy",
  opts = {
    handle = {
      highlight = "Visual",
    },
    marks = {
      Search = { color = "#fac863" },
    },
    handlers = {
      cursor = false,
    },
  },
  dependencies = {
    "kevinhwang91/nvim-hlslens",
    keys = {
      { "*", star("*"), expr = true },
      { "#", star("#"), expr = true },
      { "g*", star("g*"), expr = true },
      { "g#", star("g#"), expr = true },
      { "*", star('y/\\V<C-R>"<CR>'), mode = "x", expr = true },
      { "#", star('y?\\V<C-R>"<CR>'), mode = "x", expr = true },
    },
    config = function()
      require("scrollbar.handlers.search").setup({
        override_lens = function() end,
      })
    end,
  },
}

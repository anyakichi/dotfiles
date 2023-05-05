return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_b = { { "filename", path = 1 } },
        lualine_c = {
          "branch",
          "diff",
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "💡",
            },
          },
        },
        lualine_x = {
          {
            "encoding",
            cond = function()
              return vim.o.encoding ~= "utf-8"
            end,
          },
          {
            "fileformat",
            cond = function()
              return vim.o.fileformat ~= "unix"
            end,
          },
          { "filetype", icons_enabled = false },
        },
      },
    })
  end,
}

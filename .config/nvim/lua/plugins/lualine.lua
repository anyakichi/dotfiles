return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    return {
      options = {
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_b = { { "filename", path = 1 } },
        lualine_c = {
          "branch",
          { "diff", symbols = require("config").icons.git },
          {
            "diagnostics",
            symbols = {
              error = require("config").icons.diagnostics.Error,
              warn = require("config").icons.diagnostics.Warn,
              info = require("config").icons.diagnostics.Info,
              hint = require("config").icons.diagnostics.Hint,
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
    }
  end,
}

return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  keys = {
    { "S", "<Plug>(nvim-surround-normal)$", mode = "n" },
    { "S", "<Plug>(nvim-surround-visual-line)", mode = "x" },
    { "s", "<Plug>(nvim-surround-normal)", mode = "n" },
    { "s", "<Plug>(nvim-surround-visual)", mode = "x" },
    { "ss", "<Plug>(nvim-surround-normal-cur)", mode = "n" },
    {
      "<C-s>",
      function()
        require("nvim-surround").buffer_setup({ move_cursor = false })
        local textobj = vim.fn.getcharstr()
        local surround = vim.fn.getcharstr()
        vim.cmd("normal sa" .. textobj .. surround)
        require("nvim-surround").buffer_setup({ move_cursor = "begin" })
      end,
      mode = "i",
    },
  },
  opts = function()
    local config = require("nvim-surround.config")

    return {
      surrounds = {
        b = { add = { "(", ")" } },
        ["k"] = {
          add = { "「", "」" },
          find = function()
            return config.get_selection({ pattern = "「.-」" })
          end,
          delete = "^(「)().-(」)()$",
        },
        ["K"] = {
          add = { "『", "』" },
          find = function()
            return config.get_selection({ pattern = "『.-』" })
          end,
          delete = "^(『)().-(』)()$",
        },
        ["<C-k>"] = {
          add = { "（", "）" },
          find = function()
            return config.get_selection({ pattern = "（.-）" })
          end,
          delete = "^(（)().-(）)()$",
        },
        [","] = { add = { "", "," } },
        [";"] = { add = { "", ";" } },
      },
      aliases = {
        b = { ")", "}", "]" },
      },
    }
  end,
}

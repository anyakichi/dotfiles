return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  init = function()
    vim.keymap.set("n", "S", "<Plug>(nvim-surround-normal)$", { silent = true })
    vim.keymap.set("i", "<C-s>", function()
      require("nvim-surround").buffer_setup({ move_cursor = false })
      local textobj = vim.fn.getcharstr()
      local surround = vim.fn.getcharstr()
      vim.cmd("normal sa" .. textobj .. surround)
      require("nvim-surround").buffer_setup({ move_cursor = "begin" })
    end)
  end,
  opts = function()
    local config = require("nvim-surround.config")

    return {
      keymaps = {
        normal = "s",
        normal_cur = "ss",
        normal_line = false,
        normal_cur_line = false,
        visual = "s",
        visual_line = "S",
      },
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

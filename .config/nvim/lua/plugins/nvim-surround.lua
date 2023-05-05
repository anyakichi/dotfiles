return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  init = function()
    vim.keymap.set("n", "S", "<Plug>(nvim-surround-normal)$", { silent = true })
  end,
  opts = function()
    local config = require("nvim-surround.config")

    return {
      keymaps = {
        normal = "s",
        normal_cur = "ss",
        normal_line = nil,
        normal_cur_line = nil,
        visual = "s",
        visual_line = "S",
      },
      surrounds = {
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
      },
    }
  end,
}

return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = "nvim-treesitter-textobjects",
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        search_method = "cover",
        custom_textobjects = {
          M = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          m = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          f = ai.gen_spec.treesitter({ a = "@call.outer", i = "@call.inner" }, {}),
          a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }, {}),
          l = ai.gen_spec.treesitter({ a = "@return.outer", i = "@return.inner" }, {}),
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          [";"] = ai.gen_spec.treesitter({ a = "@statement.outer", i = "@statement.inner" }, {}),

          k = { "「().-()」" },
          K = { "『().-()』" },
          [""] = { "（().-()）" },
        },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    event = "VeryLazy",
    main = "mini.indentscope",
    opts = {
      options = { try_as_border = true },
      symbol = "▎",
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#65737e" })
    end,
  },
  {
    "echasnovski/mini.surround",
    enabled = false,
    event = "VeryLazy",
    keys = {
      { "S", "s$", remap = true },
      { "ss", "s_", remap = true },
    },
    config = function()
      vim.keymap.set("i", "<C-s>", function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local textobj = vim.fn.getcharstr()
        local surround = vim.fn.getcharstr()
        vim.cmd("normal sa" .. textobj .. surround)
        vim.api.nvim_win_set_cursor(0, cursor)
      end)

      require("mini.surround").setup({
        mappings = {
          add = "s",
          delete = "ds",
          replace = "cs",
        },
        custom_surroundings = {
          B = {
            input = { "%b{}", "^.().*().$" },
            output = { left = "{", right = "}" },
          },
          k = {
            input = { "「().-()」" },
            output = { left = "「", right = "」" },
          },
          K = {
            input = { "『().-()』" },
            output = { left = "『", right = "』" },
          },
          [""] = {
            input = { "（().-()）" },
            output = { left = "（", right = "）" },
          },
          [","] = { output = { left = "", right = "," } },
          [";"] = { output = { left = "", right = ";" } },
        },
      })
    end,
  },
}

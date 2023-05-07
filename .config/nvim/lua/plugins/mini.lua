return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = "nvim-treesitter-textobjects",
    config = function()
      local ai = require("mini.ai")
      ai.setup({
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
    opts = {},
    init = function()
      vim.g.miniindentscope_disable = true
    end,
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    keys = {
      { "S", "s$", remap = true },
      { "ss", "s_", remap = true },
    },
    config = function()
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
        },
      })
    end,
  },
}

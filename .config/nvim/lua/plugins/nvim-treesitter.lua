return {
  "RRethy/nvim-treesitter-endwise",
  "nvim-treesitter/nvim-treesitter-context",
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    keys = {
      {
        "gl",
        function()
          require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
        end,
        desc = "Swap next parameter",
      },
      {
        "gh",
        function()
          require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer")
        end,
        desc = "Swap previous parameter",
      },
    },
    config = function()
      local ts_tobj_move = require("nvim-treesitter-textobjects.move")
      local next_move = require("nvim-next.move")
      local map_pair = function(prev_key, next_key, edge, tobj, desc)
        local prev, next = next_move.make_repeatable_pair(function(_)
          ts_tobj_move["goto_previous_" .. edge](tobj, "textobjects")
        end, function(_)
          ts_tobj_move["goto_next_" .. edge](tobj, "textobjects")
        end)
        vim.keymap.set("n", next_key, next, { desc = "Next " .. desc })
        vim.keymap.set("n", prev_key, prev, { desc = "Previous " .. desc })
      end

      map_pair("[[", "]]", "start", "@class.outer", "class start")
      map_pair("[]", "][", "end", "@class.outer", "class end")

      map_pair("[a", "]a", "start", "@parameter.outer", "parameter start")
      map_pair("[A", "]A", "end", "@parameter.outer", "parameter end")

      map_pair("[m", "]m", "start", "@function.outer", "function start")
      map_pair("[M", "]M", "end", "@function.outer", "function end")

      map_pair("[r", "]r", "start", "@return.outer", "return start")
      map_pair("[R", "]R", "end", "@return.outer", "return end")
    end,
  },
  "windwp/nvim-ts-autotag",
}

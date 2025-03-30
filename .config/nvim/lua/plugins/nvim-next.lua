return {
  "ghostbuster91/nvim-next",
  event = "VeryLazy",
  config = function()
    require("nvim-next").setup({
      default_mappings = {
        repeat_style = "directional",
      },
    })

    local next_move = require("nvim-next.move")

    local function define_move(pkey, pcmd, nkey, ncmd)
      local prev, next = next_move.make_repeatable_pair(function(_)
        local status, err = pcall(vim.cmd, pcmd)
        if not status then
          vim.notify("No more items", vim.log.levels.INFO)
        end
      end, function(_)
        local status, err = pcall(vim.cmd, ncmd)
        if not status then
          vim.notify("No more items", vim.log.levels.INFO)
        end
      end)

      vim.keymap.set("n", pkey, prev)
      vim.keymap.set("n", nkey, next)
    end

    local function define_move_from_keys(pkey, nkey)
      define_move(pkey, "normal! " .. pkey, nkey, "normal! " .. nkey)
    end

    for _, v in ipairs({ "#", "*", "/", "'", "`", "S", "c", "s", "z" }) do
      define_move_from_keys("[" .. v, "]" .. v)
    end

    define_move_from_keys("(", ")")
    define_move_from_keys("[(", "])")
    define_move_from_keys("[{", "]}")
    define_move_from_keys("zk", "zj")
    define_move_from_keys("{", "}")

    define_move("[b", "bprevious", "]b", "bnext")
    define_move("[l", "lprevious", "]l", "lnext")
    define_move("[q", "cprevious", "]q", "cnext")
    define_move("[t", "tprevious", "]t", "tnext")
  end,
}

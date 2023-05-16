return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    signs = {
      untracked = { text = "" },
    },
    yadm = {
      enable = true,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local prev_hunk, next_hunk = require("nvim-next.move").make_repeatable_pair(function(_)
        if vim.wo.diff then
          vim.cmd("normal! [c")
        else
          vim.schedule(function()
            gs.prev_hunk()
          end)
        end
      end, function(_)
        if vim.wo.diff then
          vim.cmd("normal! ]c")
        else
          vim.schedule(function()
            gs.next_hunk()
          end)
        end
      end)

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "[c", prev_hunk)
      map("n", "]c", next_hunk)

      -- Actions
      map("n", "<leader>gs", gs.stage_hunk)
      map("n", "<leader>gr", gs.reset_hunk)
      map("v", "<leader>gs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end)
      map("v", "<leader>gr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end)
      map("n", "<leader>gS", gs.stage_buffer)
      map("n", "<leader>gu", gs.undo_stage_hunk)
      map("n", "<leader>gR", gs.reset_buffer)
      map("n", "<leader>gp", gs.preview_hunk)
      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end)
      map("n", "<leader>gB", gs.toggle_current_line_blame)
      map("n", "<leader>gd", gs.diffthis)
      map("n", "<leader>gD", function()
        gs.diffthis("~")
      end)
      map("n", "<leader>g<C-d>", gs.toggle_deleted)

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
  },
}

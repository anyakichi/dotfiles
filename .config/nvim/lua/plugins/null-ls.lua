return {
  "nvimtools/none-ls.nvim",
  event = "VeryLazy",
  opts = function()
    local null_ls = require("null-ls")
    return {
      sources = {
        null_ls.builtins.diagnostics.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),
        null_ls.builtins.formatting.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.shfmt.with({
          extra_args = { "-i", "4", "-s" },
        }),
        null_ls.builtins.formatting.stylua,
      },
    }
  end,
}

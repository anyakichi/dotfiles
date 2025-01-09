return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = ":TSUpdate",
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    "andymass/vim-matchup",
    "ghostbuster91/nvim-next",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-next.integrations").treesitter_textobjects()
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",

      endwise = { enable = true },
      highlight = { enable = true },
      matchup = { enable = true },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- Markdown code block
            ["i~"] = {
              query = "@content",
              query_group = "injections",
            },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["gl"] = "@parameter.inner",
          },
          swap_previous = {
            ["gh"] = "@parameter.inner",
          },
        },
        lsp_interop = {
          enable = true,
          border = "none",
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },

      nvim_next = {
        enable = true,
        textobjects = {
          move = {
            goto_next_start = {
              ["]]"] = "@class.outer",
              ["]a"] = "@parameter.outer",
              ["]m"] = "@function.outer",
              ["]r"] = "@return.outer",
            },
            goto_next_end = {
              ["]["] = "@class.outer",
              ["]M"] = "@function.outer",
              ["]A"] = "@parameter.outer",
              ["]R"] = "@return.outer",
            },
            goto_previous_start = {
              ["[["] = "@class.outer",
              ["[a"] = "@parapeter.outer",
              ["[m"] = "@function.outer",
              ["[r"] = "@return.outer",
            },
            goto_previous_end = {
              ["[]"] = "@class.outer",
              ["[A"] = "@parameter.outer",
              ["[M"] = "@function.outer",
              ["[R"] = "@return.outer",
            },
          },
        },
      },
    })
  end,
}

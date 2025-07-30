return {
  {
    "mhartington/oceanic-next",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.oceanic_next_terminal_bold = 1
      vim.cmd([[colorscheme OceanicNext]])
    end,
  },

  { "AndrewRadev/linediff.vim", cmd = "Linediff" },
  { "FabijanZulj/blame.nvim", event = "VeryLazy", opts = { date_format = "%Y-%m-%d" } },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = "markdown",
    keys = {
      { "<Space>h", "<Cmd>RenderMarkdown toggle<CR>" },
    },
    opts = {
      enabled = false,
      pipe_table = {
        style = "normal",
      },
    },
  },
  { "NvChad/nvim-colorizer.lua", keys = { { "<Space>C", "<Cmd>ColorizerToggle<CR>" } }, opts = {} },
  {
    "abecodes/tabout.nvim",
    keys = {
      { "<C-l>", "<Plug>(TaboutMulti)", mode = "i", silent = true },
    },
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      tabkey = "",
      backwards_tabkey = "",
      act_as_tab = false,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = { open_mapping = [[<C-\>]] },
  },
  {
    "andymass/vim-matchup",
    event = { "BufNewFile", "BufReadPre" },
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },
  {
    "anyakichi/vim-qfutil",
    event = "VeryLazy",
    init = function()
      vim.g.qfutil_mode = "c"
    end,
  },
  { "anyakichi/vim-tabutil", event = "VeryLazy" },
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    opts = {
      hide = { cursorline = true, only_win = true },
      render = function(props)
        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local res = bufname ~= "" and vim.fn.fnamemodify(bufname, ":~:.") or "[No Name]"
        if vim.api.nvim_buf_get_option(props.buf, "modified") then
          res = res .. " [+]"
        end
        return res
      end,
    },
  },
  { "chentoast/marks.nvim", event = "VeryLazy", opts = {} },
  { "folke/todo-comments.nvim", event = "VeryLazy", opts = {} },
  { "folke/ts-comments.nvim", event = "VeryLazy", opts = {} },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  {
    "ggandor/leap.nvim",
    keys = {
      { "f", "<Plug>(leap-forward-to)", mode = { "n", "o", "x" }, desc = "Leap forward to" },
      { "F", "<Plug>(leap-backward-to)", mode = { "n", "o", "x" }, desc = "Leap backward to" },
    },
  },
  {
    "hat0uma/csvview.nvim",
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    keys = {
      { "<Space>h", "<Cmd>CsvViewToggle<CR>" },
    },
    opts = {
      keymaps = {
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
  },
  {
    "haya14busa/vim-edgemotion",
    keys = {
      { "<C-j>", "<Plug>(edgemotion-j)" },
      { "<C-k>", "<Plug>(edgemotion-k)" },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  },
  { "j-hui/fidget.nvim", event = "LspAttach", opts = {} },
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTRun" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = { api_key_cmd = "pass chatgpt" },
  },
  { "jamessan/vim-gnupg", lazy = false },
  {
    "junegunn/vim-easy-align",
    keys = { { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" } } },
  },
  { "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {
      indent = {
        char = "▏",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
      },
    },
  },
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  { "mrcjkb/rustaceanvim", version = "*", lazy = false },
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    -- stylua: ignore
    keys = { { "<Leader>'", function() require("notify").dismiss({}) end } },
    config = function()
      vim.notify = require("notify")
    end,
  },
  { "rescript-lang/vim-rescript", ft = "rescript" },
  { "rust-lang/rust.vim", ft = "rust" },
  { "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<Space>f",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_organize_imports", "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,
        rust = { "rustfmt", lsp_format = "fallback" },
        sh = { "shfmt" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters = {
        shfmt = {
          prepend_args = { "-s" },
        },
      },
    },
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    init = function()
      local group = vim.api.nvim_create_augroup("MyFugitive", {})
      vim.api.nvim_create_autocmd("BufEnter", {
        group = group,
        callback = function()
          vim.env.GIT_DIR = vim.b.git_dir
        end,
      })
      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = group,
        callback = function()
          local path = vim.fn.expand("%:p")
          if vim.fn.executable("yadm") == 1 and vim.fn.filereadable(path) == 1 then
            vim.fn.jobstart({ "yadm", "ls-files", "--error-unmatch", path }, {
              on_exit = function(_, data, _)
                if data == 0 then
                  vim.fn.FugitiveDetect("~/.local/share/yadm/repo.git")
                  vim.env.GIT_DIR = vim.b.git_dir
                end
              end,
            })
          end
        end,
      })
    end,
  },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "tyru/capture.vim", cmd = "Capture" },
  {
    "vim-jp/autofmt",
    event = "VeryLazy",
    init = function()
      vim.opt.formatexpr = "autofmt#japanese#formatexpr()"
      vim.g.autofmt_allow_over_tw = 2
    end,
  },
  { "will133/vim-dirdiff", lazy = false },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = { check_ts = true, map_c_h = true },
    config = function(_, opts)
      local Rule = require("nvim-autopairs.rule")
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)
      npairs.add_rules({
        Rule("{,", "}"):replace_endpair(function()
          return "<BS><Right>,<Left><Left>"
        end, true):set_end_pair_length(0),
        Rule("{;", "}"):replace_endpair(function()
          return "<BS><Right>;<Left><Left>"
        end, true):set_end_pair_length(0),
        Rule("[,", "]"):replace_endpair(function()
          return "<BS><Right>,<Left><Left>"
        end, true):set_end_pair_length(0),
        Rule("[;", "]"):replace_endpair(function()
          return "<BS><Right>;<Left><Left>"
        end, true):set_end_pair_length(0),
      })
    end,
  },

  -- textobj-user
  {
    "anyakichi/vim-textobj-ifdef",
    event = "VeryLazy",
    dependencies = "kana/vim-textobj-user",
  },
  {
    "anyakichi/vim-textobj-subword",
    event = "VeryLazy",
    dependencies = "kana/vim-textobj-user",
  },
  {
    "glts/vim-textobj-comment",
    event = "VeryLazy",
    dependencies = "kana/vim-textobj-user",
  },
  {
    "kana/vim-textobj-fold",
    event = "VeryLazy",
    dependencies = "kana/vim-textobj-user",
  },
}

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
    opts = {
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
  { "chrisbra/csv.vim", ft = "csv" },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/.obsidian-vault/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/.obsidian-vault/*.md",
    },
    cmd = {
      "ObsidianDailies",
      "ObsidianNew",
      "ObsidianQuickSwitch",
      "ObsidianSearch",
      "ObsidianToday",
    },
    keys = {
      { "<Leader>oT", "<cmd>ObsidianToday<CR>", desc = "Today's note" },
      { "<Leader>oa", "<cmd>ObsidianTemplate<CR>", desc = "Add template" },
      { "<Leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Back links" },
      { "<Leader>od", "<cmd>ObsidianDailies<CR>", desc = "Daily notes" },
      { "<Leader>ol", "<cmd>ObsidianLinks<CR>", desc = "Links" },
      { "<Leader>on", "<cmd>ObsidianNew<CR>", desc = "New note" },
      { "<Leader>oo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Open a note" },
      { "<Leader>or", "<cmd>ObsidianRename<CR>", desc = "Rename a note" },
      { "<Leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search notes" },
      { "<Leader>ot", "<cmd>ObsidianTags<CR>", desc = "Search tags" },
    },
    enabled = vim.fn.isdirectory(vim.fn.expand("~/.obsidian-vault")) == 1,
    opts = {
      daily_notes = {
        template = "daily.md",
      },
      disable_frontmatter = true,
      picker = {
        name = "fzf-lua",
      },
      templates = {
        folder = "/Templates",
      },
      ui = { enable = false },
      workspaces = {
        {
          name = "default",
          path = "~/.obsidian-vault",
        },
      },
    },
  },
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
  { "j-hui/fidget.nvim", branch = "legacy", event = "LspAttach", opts = {} },
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
  {
    "purarue/yadm-git.vim",
    event = "BufReadPre",
    dependencies = "tpope/vim-fugitive",
    config = function()
      vim.g.yadm_git_gitgutter_enabled = 0
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    init = function()
      vim.api.nvim_set_hl(0, "RustToolsInlayHints", { fg = "#65737e", italic = true })
    end,
    opts = {
      tools = {
        inlay_hints = {
          highlight = "RustToolsInlayHints",
        },
      },
    },
    config = function(_, opts)
      local path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
      local codelldb_path = path .. "adapter/codelldb"
      local liblldb_path = path .. "lldb/lib/liblldb.so"
      if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
        opts.dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        }
      end
      require("rust-tools").setup(opts)
    end,
  },
  { "sindrets/diffview.nvim", cmd = "DiffviewOpen" },
  { "tpope/vim-fugitive", event = "VeryLazy" },
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
}

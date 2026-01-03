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
      window = {
        padding = 0,
      },
      render = function(props)
        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local filename = bufname ~= "" and vim.fn.fnamemodify(bufname, ":~:.") or "[No Name]"
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)

        local function get_diagnostic_label()
          local icons = {
            error = require("config").icons.diagnostics.Error,
            warn = require("config").icons.diagnostics.Warn,
            info = require("config").icons.diagnostics.Info,
            hint = require("config").icons.diagnostics.Hint,
          }
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(
              props.buf,
              { severity = vim.diagnostic.severity[string.upper(severity)] }
            )
            if n > 0 then
              table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          if #label > 0 then
            table.insert(label, { "┊ " })
          end
          return label
        end

        local function get_file_info()
          local info = {}
          if vim.o.fileformat == "dos" then
            table.insert(info, "  ")
          elseif vim.o.fileformat == "mac" then
            table.insert(info, "  ")
          end
          if vim.o.fileencoding ~= "" and vim.o.fileencoding ~= "utf-8" then
            table.insert(info, vim.o.fileencoding .. " ")
          end
          if #info > 0 then
            table.insert(info, { "┊ " })
          end
          return info
        end

        local fg =
          string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg)
        local bg =
          string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Pmenu", link = false }).bg)

        return {
          { "█▏", guifg = fg, guibg = bg, blend = 0 },
          { get_diagnostic_label() },
          { get_file_info() },
          { ft_icon and ft_icon .. " " or "", guifg = ft_color, guibg = "none" },
          { filename, gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
          { "▕█", guifg = fg, guibg = bg, blend = 0 },
        }
      end,
    },
  },
  { "chentoast/marks.nvim", event = "VeryLazy", opts = {} },
  {
    "coder/claudecode.nvim",
    opts = {
      diff_opts = {
        open_in_current_tab = false,
      },
    },
    keys = {
      { "<Space>a", nil, desc = "AI/Claude Code" },
      { "<C-,>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude", mode = { "n", "t" } },
      { "<Space>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<Space>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<Space>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<Space>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<Space>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<Space>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<Space>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<Space>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<Space>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<Space>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = 4,
            col = "50%",
          },
          size = {
            min_width = 78,
            width = "auto",
            height = "auto",
          },
        },
        cmdline_popupmenu = {
          relative = "editor",
          position = {
            row = 7,
            col = "50%",
          },
          size = {
            width = 78,
            height = "auto",
            max_height = 15,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
          },
        },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      messages = {
        view_search = false,
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true },
      notifier = { enabled = true, width = { min = 40, max = 0.95 } },
      scope = { enabled = true },
      words = { enabled = true },
      zen = {
        toggles = {
          dim = false,
        },
        win = {
          width = 80,
          backdrop = { transparent = false, blend = 99 },
          wo = {
            winblend = 0,
          },
        },
      },
    },
    keys = {
      {
        [[<C-\>]],
        function()
          Snacks.terminal(nil, { win = { height = 0.25 } })
        end,
        desc = "Toggle Terminal",
        mode = { "n", "t" },
      },
      {
        "<Space>n",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<Space>'",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<Leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
    },
    init = function()
      local prev_diag, next_diag = require("nvim-next.move").make_repeatable_pair(function(_)
        Snacks.words.jump(-vim.v.count1)
      end, function(_)
        Snacks.words.jump(vim.v.count1)
      end)
      vim.keymap.set("n", "[w", prev_diag)
      vim.keymap.set("n", "]w", next_diag)
    end,
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
    "hat0uma/csvview.nvim",
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    ft = "csv",
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
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  { "mrcjkb/rustaceanvim", version = "*", lazy = false },
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
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
        terraform = { "tofu_fmt" },
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

return {
  {
    "mhartington/oceanic-next",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.oceanic_next_terminal_bold = 1
      vim.g.oceanic_next_terminal_italic = 1
      vim.cmd([[colorscheme OceanicNext]])
    end,
  },

  { "AndrewRadev/linediff.vim", cmd = "Linediff" },
  { "NvChad/nvim-colorizer.lua", event = { "BufNewFile", "BufReadPre" }, opts = {} },
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
  { "folke/todo-comments.nvim", event = "VeryLazy", opts = {} },
  {
    "ggandor/leap.nvim",
    keys = {
      { "f", "<Plug>(leap-forward-to)", mode = { "n", "o", "x" } },
      { "F", "<Plug>(leap-backward-to)", mode = { "n", "o", "x" } },
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
    cmd = "MarkdownPreview",
  },
  { "j-hui/fidget.nvim", event = "VeryLazy", opts = {} },
  { "jamessan/vim-gnupg", lazy = false },
  {
    "junegunn/vim-easy-align",
    keys = { { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" } } },
  },
  { "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
  { "lukas-reineke/indent-blankline.nvim", event = "VeryLazy", opts = {} },
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      vim.notify = require("notify")
    end,
  },
  { "rescript-lang/vim-rescript", ft = "rescript" },
  { "rust-lang/rust.vim", ft = "rust" },
  { "simrat39/rust-tools.nvim", ft = "rust", opts = {} },
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

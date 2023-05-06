return {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    {
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      init = function()
        vim.keymap.set("s", "<Tab>", "<Cmd>lua require('luasnip').jump(1)<CR>", { silent = true })
        vim.keymap.set(
          "s",
          "<S-Tab>",
          "<Cmd>lua require('luasnip').jump(-1)<CR>",
          { silent = true }
        )
      end,
      config = function()
        require("luasnip.loaders.from_lua").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end,
    },
    "petertriho/cmp-git",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4, { "i", "c" }),
        ["<C-f>"] = cmp.mapping.scroll_docs(4, { "i", "c" }),
        ["<C-j>"] = cmp.mapping.select_next_item({
          behavior = cmp.SelectBehavior.Select,
        }),
        ["<C-k>"] = cmp.mapping.select_prev_item({
          behavior = cmp.SelectBehavior.Select,
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp_signature_help" },
      }, {
        { name = "path" },
      }, {
        { name = "nvim_lsp" },
      }, {
        { name = "luasnip" },
      }, {
        { name = "emoji" },
      }, {
        { name = "calc" },
        { name = "buffer" },
      }),
    })

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
      }, {
        { name = "buffer" },
      }),
    })
    require("cmp_git").setup()

    local cmdline_mapping = {
      ["<C-z>"] = {
        c = cmp.config.disable,
      },
      ["<Tab>"] = {
        c = cmp.config.disable,
      },
      ["<S-Tab>"] = {
        c = cmp.config.disable,
      },
      ["<C-n>"] = {
        c = cmp.config.disable,
      },
      ["<C-p>"] = {
        c = cmp.config.disable,
      },
      ["<C-j>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_next_item({
              behavior = cmp.SelectBehavior.Select,
            })
          else
            fallback()
          end
        end,
      },
      ["<C-k>"] = {
        c = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({
              behavior = cmp.SelectBehavior.Select,
            })
          else
            fallback()
          end
        end,
      },
      ["<CR>"] = {
        c = function(fallback)
          if not cmp.confirm({ select = false }) then
            if vim.fn.getcmdtype() == "/" then
              vim.opt.hlsearch = true
            end
            fallback()
          end
        end,
      },
    }

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
      sources = {
        { name = "nvim_lsp_document_symbol" },
        { name = "buffer" },
      },
    })
  end,
}

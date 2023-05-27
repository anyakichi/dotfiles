return {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "petertriho/cmp-git",
    {
      "saadparwaiz1/cmp_luasnip",
      dependencies = {
        {
          "L3MON4D3/LuaSnip",
          dependencies = "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_lua").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
          end,
        },
      },
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(_, item)
          local icons = require("config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind]
          end
          if #item.abbr > 20 then
            item.abbr = item.abbr:sub(1, 17) .. "…" .. item.abbr:sub(-2)
          end
          return item
        end,
      },
      window = {
        documentation = vim.tbl_deep_extend(
          "force",
          cmp.config.window.bordered(),
          { max_width = 80 }
        ),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "emoji" },
        { name = "path" },
        { name = "buffer" },
        { name = "calc" },
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
    }

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
      sources = {
        { name = "buffer" },
      },
    })
  end,
}

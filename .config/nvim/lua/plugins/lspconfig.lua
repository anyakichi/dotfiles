return {
  { "mason-org/mason-lspconfig.nvim", event = { "BufNewFile", "BufReadPre" }, opts = {} },
  {
    "neovim/nvim-lspconfig",
    event = { "BufNewFile", "BufReadPre" },
    dependencies = {
      "b0o/SchemaStore.nvim",
      { "folke/neoconf.nvim", opts = {} },
      { "folke/lazydev.nvim", ft = "lua", opts = {} },
      { "mason-org/mason.nvim", opts = {} },
      {
        "nvimdev/lspsaga.nvim",
        opts = {
          code_action = { keys = { quit = "<C-c>" } },
          definition = { keys = { edit = "e" }, width = 0.9 },
          lightbulb = {
            virtual_text = false,
          },
          rename = {
            in_select = false,
            keys = {
              quit = "<C-c>",
            },
          },
          symbol_in_winbar = {
            enable = false,
          },
        },
      },
    },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.lsp.enable("ansiblels")
      vim.lsp.enable("bashls")
      vim.lsp.enable("bitbake_ls")
      vim.lsp.enable("clangd")
      vim.lsp.enable("cssls")
      vim.lsp.enable("dockerls")
      vim.lsp.enable("esbonio")
      vim.lsp.enable("eslint")
      vim.lsp.enable("gopls")
      vim.lsp.enable("hls")
      vim.lsp.enable("html")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("mesonlsp")
      vim.lsp.enable("ocamllsp")
      vim.lsp.enable("pyright")
      vim.lsp.enable("rescriptls")
      vim.lsp.enable("tailwindcss")
      vim.lsp.enable("taplo")
      vim.lsp.enable("texlab")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("vimls")
      vim.lsp.enable("yamlls")

      for type, text in pairs(require("config").icons.diagnostics) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = text, texthl = hl })
      end

      local opts = { noremap = true, silent = true }

      local prev_diag, next_diag = require("nvim-next.move").make_repeatable_pair(function(_)
        require("lspsaga.diagnostic"):goto_prev()
      end, function(_)
        require("lspsaga.diagnostic"):goto_next()
      end)
      vim.keymap.set("n", "<Space>q", vim.diagnostic.setloclist, opts)
      vim.keymap.set("n", "[d", prev_diag, opts)
      vim.keymap.set("n", "]d", next_diag, opts)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          opts = { buffer = ev.buf }
          vim.keymap.set("n", "grn", "<Cmd>Lspsaga rename<CR>A", opts)
          vim.keymap.set({ "n", "v" }, "gra", "<Cmd>Lspsaga code_action<CR>", opts)
          vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
          vim.keymap.set(
            "n",
            "g<C-d>",
            "<Cmd>FzfLua lsp_typedefs jump1=false unique_line_items=true ignore_current_line=true<CR>",
            opts
          )
          vim.keymap.set(
            "n",
            "gD",
            "<Cmd>FzfLua lsp_declarations jump1=false unique_line_items=true ignore_current_line=true<CR>",
            opts
          )
          vim.keymap.set(
            "n",
            "gd",
            "<Cmd>FzfLua lsp_definitions jump1=false unique_line_items=true ignore_current_line=true<CR>",
            opts
          )
          vim.keymap.set("n", "<Space>K", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<Space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          if client and client.server_capabilities.inlayHintProvider then
            vim.keymap.set("n", "<Space>h", function()
              local current_setting = vim.lsp.inlay_hint.is_enabled(opts)
              vim.lsp.inlay_hint.enable(not current_setting, opts)
            end, opts)
          end
        end,
      })
    end,
  },
}

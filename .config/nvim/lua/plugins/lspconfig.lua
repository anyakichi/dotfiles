return {
  "neovim/nvim-lspconfig",
  event = { "BufNewFile", "BufReadPre" },
  dependencies = {
    "b0o/SchemaStore.nvim",
    { "folke/neoconf.nvim", opts = {} },
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
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
    { "williamboman/mason-lspconfig.nvim", opts = {} },
    { "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local lspconfig = require("lspconfig")
    lspconfig.ansiblels.setup({ capabilities = capabilities })
    lspconfig.bashls.setup({ capabilities = capabilities })
    lspconfig.clangd.setup({ capabilities = capabilities })
    lspconfig.cssls.setup({ capabilities = capabilities })
    lspconfig.dockerls.setup({ capabilities = capabilities })
    lspconfig.esbonio.setup({ capabilities = capabilities })
    lspconfig.eslint.setup({ capabilities = capabilities })
    lspconfig.gopls.setup({ capabilities = capabilities })
    lspconfig.hls.setup({ capabilities = capabilities })
    lspconfig.html.setup({ capabilities = capabilities })
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })
    lspconfig.lua_ls.setup({ capabilities = capabilities })
    lspconfig.mesonlsp.setup({ capabilities = capabilities })
    lspconfig.ocamllsp.setup({ capabilities = capabilities })
    lspconfig.pyright.setup({ capabilities = capabilities })
    lspconfig.rescriptls.setup({
      capabilities = capabilities,
      cmd = {
        "node",
        require("lazy.core.config").options.root .. "/vim-rescript/server/out/server.js",
        "--stdio",
      },
    })
    lspconfig.tailwindcss.setup({ capabilities = capabilities })
    lspconfig.taplo.setup({ capabilities = capabilities })
    lspconfig.texlab.setup({ capabilities = capabilities })
    lspconfig.ts_ls.setup({ capabilities = capabilities })
    lspconfig.vimls.setup({ capabilities = capabilities })
    lspconfig.yamlls.setup({
      capabilities = capabilities,
      settings = {
        yaml = {
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    })

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
    vim.keymap.set("n", "<Space>e", vim.diagnostic.open_float, opts)
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
        vim.keymap.set("n", "g<C-d>", "<Cmd>Lspsaga peek_type_definition<CR>", opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", "<Cmd>Lspsaga peek_definition<CR>", opts)
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
          end)
        end
      end,
    })
  end,
}

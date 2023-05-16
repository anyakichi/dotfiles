return {
  "neovim/nvim-lspconfig",
  event = { "BufNewFile", "BufReadPre" },
  dependencies = {
    "b0o/SchemaStore.nvim",
    { "folke/neoconf.nvim", opts = {} },
    { "folke/neodev.nvim", opts = {} },
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
    lspconfig.rust_analyzer.setup({ capabilities = capabilities })
    lspconfig.tailwindcss.setup({ capabilities = capabilities })
    lspconfig.taplo.setup({ capabilities = capabilities })
    lspconfig.texlab.setup({ capabilities = capabilities })
    lspconfig.tsserver.setup({ capabilities = capabilities })
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

    local nndiag = require("nvim-next.integrations").diagnostic()
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<Space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<Space>q", vim.diagnostic.setloclist, opts)
    vim.keymap.set(
      "n",
      "[d",
      nndiag.goto_prev({
        severity = { min = vim.diagnostic.severity.WARN },
      }),
      opts
    )
    vim.keymap.set(
      "n",
      "]d",
      nndiag.goto_next({
        severity = { min = vim.diagnostic.severity.WARN },
      }),
      opts
    )

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<Space>K", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<Space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<Space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set({ "n", "v" }, "<Space>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })
  end,
}

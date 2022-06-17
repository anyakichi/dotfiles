---@diagnostic disable-next-line: undefined-global
local vim = vim

local M = {}

local lspconfig = require("lspconfig")

local cmp = require("cmp")

local lsp_status = require("lsp-status")
lsp_status.register_progress()

local capabilities = require("cmp_nvim_lsp").update_capabilities(
    lsp_status.capabilities
)
local flags = { debounce_text_changes = 150 }

local function t(s)
    return vim.api.nvim_replace_termcodes(s, true, true, true)
end

function M.i_ctrl_k()
    return vim.fn.pumvisible() == 1 and t("<Up>")
        or t("<C-o><cmd>lua vim.lsp.buf.signature_help()<CR>")
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "[Space]e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[Space]q", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

local on_attach = function(client, bufnr)
    vim.api.nvim_win_set_option(0, "signcolumn", "yes")
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "[Space]k", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "[Space]wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set(
        "n",
        "[space]wr",
        vim.lsp.buf.remove_workspace_folder,
        bufopts
    )
    vim.keymap.set("n", "[Space]wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "[Space]D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "[Space]rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "[Space]ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "[Space]f", vim.lsp.buf.formatting, bufopts)

    vim.keymap.set(
        "i",
        "<C-k>",
        require("init.lsp").i_ctrl_k,
        { expr = true, noremap = true, buffer = bufnr }
    )

    lsp_status.on_attach(client, bufnr)
end

local servers = {
    "bashls",
    "clangd",
    "dockerls",
    "gopls",
    "hls",
    "ocamllsp",
    "pyright",
    "rust_analyzer",
    "sqls",
    "sumneko_lua",
    "tsserver",
    "vimls",
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = flags,
    })
end

lspconfig.jsonls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    },
})

lspconfig.rescriptls.setup({
    cmd = {
        "node",
        vim.g.plug_home .. "/vim-rescript/server/out/server.js",
        "--stdio",
    },
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
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
        { name = "vsnip" },
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

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "nvim_lsp_document_symbol" },
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.prettier,
        require("null-ls").builtins.formatting.stylua,
    },
})

return M

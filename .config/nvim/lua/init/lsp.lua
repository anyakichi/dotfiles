---@diagnostic disable-next-line: undefined-global
local vim = vim

local M = {}

local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")

local lsp_status = require("lsp-status")
lsp_status.register_progress()

local capabilities = lsp_status.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}
local flags = { debounce_text_changes = 150 }

local function t(s)
    return vim.api.nvim_replace_termcodes(s, true, true, true)
end

function M.i_ctrl_k()
    return vim.fn.pumvisible() == 1 and t("<Up>")
        or t("<C-o><cmd>lua vim.lsp.buf.signature_help()<CR>")
end

local on_attach = function(client, bufnr)
    local map = vim.api.nvim_buf_set_keymap
    local nmap = function(lhs, rhs)
        map(bufnr, "n", lhs, rhs, { noremap = true, silent = true })
    end
    vim.api.nvim_win_set_option(0, "signcolumn", "yes")
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    nmap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")

    nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    nmap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")

    nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    nmap("[Space]k", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    nmap("[Space]D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")

    nmap("[Space]wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
    nmap("[Space]wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
    nmap(
        "[Space]wl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>"
    )

    nmap("[Space]rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    nmap("[Space]ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

    nmap("[Space]e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    nmap("[Space]q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
    nmap("[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    nmap("]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")

    nmap("[Space]f", "<cmd>lua vim.lsp.buf.formatting()<CR>")

    map(
        bufnr,
        "i",
        "<C-k>",
        [[luaeval('require("init.lsp").i_ctrl_k()')]],
        { expr = true, noremap = true }
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

require("compe").setup({
    source = {
        buffer = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        spell = true,
    },
})

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.prettier,
        require("null-ls").builtins.formatting.stylua,
    },
})

return M

local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")

local lsp_status = require("lsp-status")
lsp_status.register_progress()

local flags = { debounce_text_changes = 150 }

local on_attach = function(client, bufnr)
    local nmap = function(lhs, rhs)
        vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            lhs,
            rhs,
            { noremap = true, silent = true }
        )
    end
    vim.api.nvim_win_set_option(0, "signcolumn", "yes")
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")

    lsp_status.on_attach(client, bufnr)
end

if not lspconfig.reason_language_server then
    configs.reason_language_server = {
        default_config = {
            cmd = { "reason-language-server" },
            filetypes = { "ocaml", "reason" },
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
                    or vim.loop.os_homedir()
            end,
            root_files = { "package.json" },
            settings = {},
        },
    }
end

local servers = {
    "bashls",
    "clangd",
    "pyright",
    "reason_language_server",
    "rust_analyzer",
    "tsserver",
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = lsp_status.capabilities,
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
    capabilities = lsp_status.capabilities,
    flags = flags,
})

lspconfig.sumneko_lua.setup({
    cmd = {
        "lua-language-server",
        "-E",
        "/usr/share/lua-language-server/main.lua",
    },
    root_dir = function(fname)
        local git_base = lspconfig.util.find_git_ancestor(fname)
        local home = vim.loop.os_homedir()
        if git_base ~= home then
            return git_base
        else
            return lspconfig.util.path.dirname(fname)
        end
    end,
    settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    on_attach = on_attach,
    capabilities = lsp_status.capabilities,
    flags = flags,
    commands = {
        Format = {
            function()
                require("stylua-nvim").format_file()
            end,
        },
    },
})

require("compe").setup({
    source = {
        nvim_lsp = true,
        buffer = true,
    },
})

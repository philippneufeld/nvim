local status_ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_ok_lspconfig then
    return
end

local status_ok_mason, mason = pcall(require, "mason")
if not status_ok_mason then
    return
end
mason.setup({
    log_level = vim.log.levels.DEBUG,
})

local status_ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_mason_lspconfig then
    return
end

mason_lspconfig.setup({
    ensure_installed = {
        -- lsps
        "lua_ls",
        "pyright",
        "clangd",
        "ltex",
        "julials",
    },
})

local status_ok, null_ls = pcall(require, "none-ls")
if not status_ok then
    return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    -- linters and formatters
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.ruff,
        null_ls.builtins.formatting.clangd_format,
        null_ls.builtins.formatting.prettier,
    },

    -- autosave (https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save)
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
})
mason_lspconfig.setup_handlers({
    function(server_name)
        local server = lspconfig[server_name]
        local opts = {
            on_attach = require("user.lsp.handlers").on_attach,
            capabilities = require("user.lsp.handlers").capabilities,
        }

        if server.name == "lua_ls" then
            local sumneko_opts = require("user.lsp.settings.lua_ls")
            opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
        end

        if server.name == "ltexls" then
            local ltex_opts = require("user.lsp.settings.ltexls")
            opts = vim.tbl_deep_extend("force", ltex_opts, opts)
        end

        -- don't use ruff LSP for python (use pyright instead)
        -- if server.name == "ruff" then
        --     return
        -- end

        server.setup(opts)
    end,
})

require("user.lsp.handlers").setup()

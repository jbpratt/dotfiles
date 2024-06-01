return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
    },
    config = function()
        local lsp = require('lsp-zero')
        local lspconfig = require('lspconfig')

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        lsp.preset('recommended')

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { 'gopls' },
            handlers = {
                lsp.default_setup,
                lua_ls = function()
                    local lua_opts = lsp.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
                gopls = function()
                    lspconfig.gopls.setup {
                        settings = {
                            gopls = {
                                staticcheck = true,
                                gofumpt = true,
                            },
                        },
                    }
                end,
            },
        })

        cmp.setup({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = {
                { name = 'nvim_lsp' },
            }
        })

        lsp.on_attach(function(_, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function()
                    vim.lsp.buf.format()
                end
            })

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.go" },
                callback = function()
                    local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(bufnr))
                    params.context = { only = { "source.organizeImports" } }

                    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
                    for _, res in pairs(result or {}) do
                        for _, r in pairs(res.result or {}) do
                            if r.edit then
                                vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding(bufnr))
                            else
                                vim.lsp.buf.execute_command(r.command)
                            end
                        end
                    end
                end,
            })
        end)

        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true
        })
    end
}

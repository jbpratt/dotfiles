return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
        ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'go', 'python', 'bash', 'zig' },
        additional_vim_regex_highlighting = false,
        highlight = { enable = true },
        sync_install = false,
    }
}

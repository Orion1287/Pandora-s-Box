local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- Enable LuaSnip
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(), -- Trigger autocomplete
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm completion
        ["<Tab>"] = cmp.mapping.select_next_item(), -- Navigate autocomplete options
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP completions
        { name = "luasnip" },  -- Snippet completions
        { name = "buffer" },   -- Buffer completions
        { name = "path" },     -- Path completions
    }),
})


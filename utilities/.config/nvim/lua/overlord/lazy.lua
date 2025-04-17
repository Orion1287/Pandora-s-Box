---- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys before Lazy loads
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup Lazy and load plugins
require("lazy").setup({
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end,
  },

  -- Rose Pine Colorscheme
-- lua/plugins/rose-pine.lua
--{
--	"rose-pine/neovim",
--	name = "rose-pine",
--	config = function()
--		vim.cmd("colorscheme rose-pine")
--	end
--},

 --  Treesitter
 {
   "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
    require("nvim-treesitter.configs").setup({
          ensure_installed = { "lua", "python", "javascript", "c", "cpp", "html", "css" },
          highlight = { enable = false, additional_vim_regex_highlighting = false },
          indent = { enable = false },
    })
 end,
  },

  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
    config = function()
      require("harpoon").setup({})
    end,
  },

  -- Tokyo Night Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = true,

  },

  -- Gruvbox Colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
  },

   {
        'zaldih/themery.nvim',
        lazy = false,
        config = function()
            require('themery').setup({
                themes = {
                    { name = 'Catppuccin Mocha', colorscheme = 'catppuccin-mocha' },
                    { name = 'Everforest', colorscheme = 'everforest' },
                    { name = 'Github Dimmed', colorscheme = 'github_dark_dimmed' },
                    { name = 'Kanagawa Dragon', colorscheme = 'kanagawa-dragon' },
                    { name = 'Kanagawa Wave', colorscheme = 'kanagawa-wave' },
                    { name = 'Neofusion', colorscheme = 'neofusion' },
                    { name = 'Rose pine', colorscheme = 'rose-pine' },
                    { name = 'Tokyonight-night', colorscheme = 'tokyonight-night' },
                    { name = 'Tokyonight-moon', colorscheme = 'tokyonight-moon' },
                },
                livePreview = true,
                makePersist = true,
            })
        end,
        keys = {
            { '<space>ut', '<cmd>Themery<cr>', mode = 'n', desc = 'Colorschemes' },
        },
    },
    {
        'asilvam133/rose-pine.nvim',
        name = 'rose-pine',
        lazy = false,
        opts = {
            styles = {
                bold = true,
                italic = false,
                transparency = true,
            },
            highlight_groups = {
                ['@function.builtin.lua'] = { italic = false },
                ['@lsp.type.comment'] = { italic = true },
                ['@lsp.typemod.function.defaultLibrary.lua'] = { italic = false },
                Comment = { italic = true },
                DiagnosticUnnecessary = { italic = false },
                TabLine = { bg = 'none' },
                TabLineSel = { bg = 'none' },
                TabLineFill = { bg = 'none' },
                ZenBg = { bg = 'none' },
            },
        },
        config = function(_, opts)
            require('rose-pine').setup(opts)
        end,
    },

  -- Lazy
{
  "vague2k/vague.nvim",
  config = function()
    -- NOTE: you do not need to call setup if you don't want to.
    require("vague").setup({
      -- optional configuration here
    })
  end
},
{
    {"ThePrimeagen/vim-be-good"}

},
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
},
{ "github/copilot.vim" },
-- Mason (LSP Manager)
    { "williamboman/mason.nvim", config = true },
    { "williamboman/mason-lspconfig.nvim", config = true },

    -- LSP Configuration
    { "neovim/nvim-lspconfig" },

    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "L3MON4D3/LuaSnip" }, -- Snippets engine
    { "saadparwaiz1/cmp_luasnip" } -- Snippet completion
}, {
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})


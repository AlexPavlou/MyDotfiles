-------------------------------
-- Built-in Plugins
-------------------------------
local disabled_builtins = {
  'netrw', 'netrwPlugin', 'matchparen', 'loaded_remote_plugins', 'tutor_mode_plugin',
  'netrwSettings', 'netrwFileHandlers', 'gzip', 'zip', 'spec', 'zipPlugin', 'tar', 
  'tarPlugin', 'getscript', 'getscriptPlugin', 'vimball', 'vimballPlugin', '2html_plugin',
  'logipat', 'rrhelper', 'spellfile_plugin', 'matchit'
}

for _, plugin in ipairs(disabled_builtins) do
  vim.g['loaded_' .. plugin] = 1
end
vim.g['omni_sql_no_default_maps'] = 1  -- Disable default mappings for omni SQL

-------------------
-- General settings
-------------------
vim.g.mapleader = ','

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 99  -- Start with all folds open
vim.o.foldenable = true    -- Enable folding by default
vim.o.foldlevel = 99       -- Keep folds open initially
vim.o.linebreak = true
vim.wo.relativenumber = true
vim.o.mouse = 'a'
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.opt.wildignore:append({ "*.o", "*.a", "*.out", "*.exe", "*.dll", "*.so", "*.dylib", "*.pyc" })
vim.opt.shortmess:append('c')
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.ttyfast = true
vim.o.showbreak = "↪"
vim.o.breakindent = true
vim.o.updatetime = 250
vim.o.scrolloff = 10
vim.o.swapfile = false
vim.o.clipboard = 'unnamedplus'

-----------------
-- Commands
-----------------

-- Disable auto-commenting in new lines
--local general = vim.api.nvim_create_augroup("general", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  group = general,
  desc = "Disable New Line Comment",
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

------------
-- Mappings
------------

-- general

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set({'n'}, ';', ':', {noremap = true})

vim.keymap.set({'n'}, '<leader>c', ':w! | !compile "%:p"<CR>', {noremap = true})

vim.keymap.set({'n'}, '<Tab>', ':bnext<CR>', {noremap = true})

vim.keymap.set({'n'}, '<S-Tab>', ':bprevious<CR>', {noremap = true})

vim.keymap.set({'n'}, '<S-Enter>', 'O', {noremap = true})

vim.keymap.set('n', '<leader>f', ':FzfLua files<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-------------------------------
-- Plugins
-------------------------------

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- ==========================
  -- UI / Appearance Plugins
  -- ==========================

  -- Catppuccin Colorscheme (loaded immediately)
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Lualine (loaded on 'VeryLazy')
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require('lualine').setup() end,
  },

  -- Colorizer (loaded on 'VeryLazy')
  { 'NvChad/nvim-colorizer.lua', config = function() require'colorizer'.setup() end },

  -- ==========================
  -- Editing Enhancements
  -- ==========================

  -- Nvim Surround (loaded on 'VeryLazy')
  { "kylechui/nvim-surround", event = "VeryLazy", config = function() require("nvim-surround").setup() end },

  -- Indent Blankline (loaded on 'VeryLazy')
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    opts = { enabled = true, indent = { char = '|' }, scope = { enabled = false } },
  },

  -- Guess indent plugin (loaded for all files)
  { 'nmac427/guess-indent.nvim' },

  -- ==========================
  -- File Navigation & Search
  -- ==========================

  -- FZF Lua (loaded on CmdLineEnter)
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'CmdLineEnter',
    config = function()
      require('fzf-lua').setup({
        winopts = {
          height = 0.50,   -- 50% of screen height
          width = 0.85,    -- 85% of screen width
          preview = {
            vertical = 'down:50%',
            hidden = 'nohidden',
          },
        },
      })
      -- Keybindings for fzf-lua
      vim.keymap.set('n', '<leader>f', require('fzf-lua').files, { noremap = true, silent = true })
    end,
  },

  -- ==========================
  -- Utility Plugins
  -- ==========================

  -- Autopairs (loaded on InsertEnter)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- Enable for Treesitter-based pairing
        disable_filetype = { "TelescopePrompt", "vim" },
        enable_check_bracket_line = false,
      })
    end,
  },

  -- Modicator (VeryLazy, global)
  { 'mawkler/modicator.nvim', event = "VeryLazy", config = function() require('modicator').setup() end },

  -- ==========================
  -- Syntax & Treesitter Plugins
  -- ==========================

  -- Treesitter (loaded for specific filetypes)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ft = { "c", "lua", "markdown", "cpp", "python", "json", "javascript", "html", "css", "bash" },
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "c", "lua", "markdown", "cpp", "python", "json", "javascript", "html", "css", "bash" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = false },
      })
    end,
  },

  -- ==========================
  -- Other Plugins
  -- ==========================

  -- Todo Comments (VeryLazy)
  { 'folke/todo-comments.nvim', event = 'VeryLazy', config = function() require('todo-comments').setup() end },

  -- HLArgs (VeryLazy)
  { 'm-demare/hlargs.nvim', event = 'VeryLazy', config = function() require('hlargs').setup() end },

  -- Leap (VeryLazy)
  {
    'ggandor/leap.nvim',
    event = 'VeryLazy',
    config = function() require('leap').set_default_keymaps() end,
  },
})

-- Colorscheme
vim.cmd.colorscheme "catppuccin"

-- Setup Modicator (very lazy)
require('modicator').setup({
  integration = {
    iualine = { enabled = true, highlight = 'bg' },
  },
})


-- Setup Ibl (indent blankline)
local highlight = {
		"RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange",
		"RainbowGreen", "RainbowViolet", "RainbowCyan",
}
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#8839EF" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#C6A0F6" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#CBA6F7" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#CBA6F7" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#CA9EE6" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#B4BEFE" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)
require("ibl").setup { indent = { highlight = highlight } }


require('guess-indent').setup {}
vim.o.foldtext = "v:lua.FoldText()"
function _G.FoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  return 'Folded: ' .. line
end
-- In your init.lua
vim.o.foldcolumn = '1'    -- Number of fold columns to display (default 0 means no column)
vim.o.foldchar = '⯇⯈'     -- Custom fold characters (you can use any symbol here)
-- In your init.lua
vim.o.foldcolumn = '1'   -- Display fold column with 1 character (you can set it to 0 to hide it)
-- In your init.lua
vim.cmd [[
  highlight Folded ctermbg=235 guibg=#2E2E2E  -- Change background color of folded text
  highlight FoldColumn ctermbg=235 guibg=#2E2E2E  -- Change fold column background
]]

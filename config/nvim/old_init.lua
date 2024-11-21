----------------
-- Built-in Plugins
----------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_loaded_remote_plugins = 1
vim.g.loaded_loaded_tutor_mode_plugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_spec = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logipat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_matchit = 1
vim.g['omni_sql_no_default_maps']=1
vim.g['loaded_python_provider']=0
vim.g['loaded_perl_provider']=1
vim.g['loaded_ruby_provider']=1

-------------------
-- General settings
-------------------

vim.g.mapleader=','
-- vim.g.maplocalleader=','
vim.g.have_nerd_font=true
vim.opt.compatible = false
vim.o.linebreak = true
vim.wo.relativenumber = true
vim.opt.mouse='a'
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.tabstop=4
vim.opt.number=true
vim.opt.shortmess:append('c')

vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.hlsearch = true
vim.o.termguicolors = true
vim.opt.syntax="enable"
vim.opt.shiftwidth = 4
--vim.filetype.plugin.on = true
vim.opt.cursorline = true
local bufnr = vim.api.nvim_get_current_buf()
vim.api.nvim_buf_set_option(bufnr, "swapfile", false)
vim.opt.ttyfast = true
vim.opt.showbreak = "↪"
vim.opt.breakindent = true
vim.opt.updatetime = 250
vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-----------------
-- Commands
-----------------

-- Disable auto-commenting in new lines
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
vim.keymap.set({'n'}, '<Enter>', 'o', {noremap = true})
vim.keymap.set({'n'}, '<S-Enter>', 'O', {noremap = true})
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
    'nvim-lualine/lualine.nvim',
    event="VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
    'mawkler/modicator.nvim',
    event = "VeryLazy",
    },
    {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end
    },{'NvChad/nvim-colorizer.lua'},
    {"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
          ensure_installed = { "c", "lua", "markdown", "markdown_inline", "cpp", "python", "json", "javascript", "html", "css", "bash"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = false },  
        })
    end},
    {'nmac427/guess-indent.nvim',},
    {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event= {'BufReadPost', 'BufNewFile'},
    opts = {enabled=false,scope={enabled=false,},indent={char='|',},},
    },
		{
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- Setup fzf-lua
      require('fzf-lua').setup({
        -- Customize the layout and preview window
        winopts = {
          height = 0.50,           -- 50% of screen height for fzf window
          width = 0.85,            -- 85% of screen width
          preview = {
            vertical = 'down:50%', -- Make preview window take up 50% of screen height
            hidden = 'nohidden',   -- Show preview even for hidden files
          },
        },
      })

      -- Keybindings for fzf-lua
      vim.keymap.set('n', '<leader>f', require('fzf-lua').files, { noremap = true, silent = true })
    end,
  },
    {'m-demare/hlargs.nvim',event = "VeryLazy"},
    {'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()  -- Set up default key mappings
    end
  },
	{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
	}
})

require("lualine").setup()
vim.cmd.colorscheme "catppuccin-mocha"
require('modicator').setup({
  integration = {
    iualine = {
      enabled = true,
      -- Letter of lualine section to use (if `nil`, gets detected automatically)
      mode_section = nil,
      -- Whether to use lualine's mode highlight's foreground or background
      highlight = 'bg',
    },
  },
})

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
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

require('guess-indent').setup {
  auto_cmd = true,  -- Set to false to disable automatic execution
  override_editorconfig = false, -- Set to true to override settings set by .editorconfig
  filetype_exclude = {  -- A list of filetypes for which the auto command gets disabled
    "netrw",
    "tutor",
  },
  buftype_exclude = {  -- A list of buffer types for which the auto command gets disabled
    "help",
    "nofile",
    "terminal",
    "prompt",
  },
  on_tab_options = { -- A table of vim options when tabs are detected 
    ["expandtab"] = false,
  },
  on_space_options = { -- A table of vim options when spaces are detected 
    ["expandtab"] = false,
    ["tabstop"] = "detected", -- If the option value is 'detected', The value is set to the automatically detected indent size.
    ["softtabstop"] = "detected",
    ["shiftwidth"] = "detected",
  },
}
require('hlargs').setup()
require('colorizer').setup()
require('leap').setup({
  -- Enable or disable specific features
  case_sensitive = true,  -- Enable case-insensitive searching
  highlight_unlabeled = true,  -- Highlight all the positions that can be jumped to
})
vim.api.nvim_set_keymap('n', 's', "<Cmd>lua require('leap').leap({target_windows = vim.api.nvim_list_wins()})<CR>", { noremap = true, silent = true })

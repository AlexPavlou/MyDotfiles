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

--vim.o.spell = true
vim.o.spelllang = 'en_us'
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
--vim.o.cursorline = true
vim.o.ttyfast = true
vim.o.showbreak = "↪"
vim.o.breakindent = true
vim.o.updatetime = 250
vim.o.scrolloff = 10
vim.cmd("hi Cursor guibg=#ff5f00")  -- Bright orange cursor background, text color remains unaffected
vim.o.swapfile = false
vim.o.clipboard = 'unnamedplus'
vim.o.showcmd = true               -- Show partial commands as you type them
vim.o.inccommand = "split"        -- Show live previews of substitutions
vim.o.wildmenu = true             -- Enhance command-line completion (wildmenu)
vim.opt.wildmode = { "longest:full", "full" }  -- Better completion behavior
vim.o.history = 1000              -- Increase command-line history length
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }  -- Better completion behavior
vim.opt.wildignore = "*.o,*.pyc,*.swp,*.git/*"  -- Ignore certain files in completion
vim.o.shell = "/bin/zsh"         -- Set your preferred shell (bash in this case)
vim.o.shellcmdflag = "-c"         -- Flag used with the shell commands

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

-- Map Ctrl+Esc to exit Terminal Mode
vim.api.nvim_set_keymap('t', '<C-Esc>', '<C-\\><C-n>', { noremap = true })

-- Move between splits using Ctrl+j/k/h/l
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

-- Resize splits using Ctrl+h/l
vim.api.nvim_set_keymap('n', '<C-S-h>', '<C-w><', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-l>', '<C-w>>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-j>', '<C-w>+', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-k>', '<C-w>-', { noremap = true })

-- Open a terminal in a horizontal split
vim.keymap.set('n', '<Leader>t', ':split | terminal<CR>i', { noremap = true })

-- Open a terminal in a vertical split
vim.keymap.set('n', '<Leader>v', ':vsplit | terminal<CR>i', { noremap = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set({'n'}, ';', ':', {noremap = true})

--vim.keymap.set({'n'}, '<leader>c', ':w! | !compile "%:p"<CR>', {noremap = true})
vim.keymap.set('n', '<leader>c', ':w! | belowright split | terminal compile "%:p"<CR>i', { noremap = true })

vim.keymap.set({'n'}, '<Tab>', ':bnext<CR>', {noremap = true})

vim.keymap.set({'n'}, '<S-Tab>', ':bprevious<CR>', {noremap = true})

vim.keymap.set({'n'}, '<S-Enter>', 'O', {noremap = true})

vim.keymap.set('n', '<leader>f', ':FzfLua files<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>l', ':set spell!<CR>', { noremap = true, silent = true })

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

  -- Nightfox Colorscheme
  {
   "EdenEast/nightfox.nvim",
    config = function()
      -- Set the Nightfox theme to Duskfox style
      vim.cmd("colorscheme duskfox")
      
      -- Optionally: Set other configuration settings for Nightfox/Duskfox
      vim.g.nightfox_style = "duskfox"  -- This sets the style to Duskfox
    end
  },

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
  -- LSP / Autocompletion
  -- ==========================

  -- LSP Config (loaded for specific filetypes)
  {
    'neovim/nvim-lspconfig',
    ft = { "cpp", "c", "python", "javascript", "typescript", "javascriptreact", "lua", " html", "css" },
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
    ft = { "c", "lua", "markdown", "cpp", "python", "json", "javascript", "typescript", "javascriptreact", "html", "css", "bash" },
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "c", "lua", "markdown", "cpp", "python", "json", "javascript", "html", "css", "bash" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = false },
        fold = {enable = true },
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

  -- Null-ls (only for JavaScript and CSS)
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "javascript", "css", "html", "css", "cpp", "c", "python", "html", "css"},
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("null-ls").setup() end,
  },

  -- Leap (VeryLazy)
  {
    'ggandor/leap.nvim',
    event = 'VeryLazy',
    config = function() require('leap').set_default_keymaps() end,
  },
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } },
  { 'mfussenegger/nvim-dap-python' },
  { 'mhinz/vim-signify' },
  -- nvim-cmp for autocompletion
  { 'hrsh7th/nvim-cmp' },

  -- Completion sources for nvim-cmp
  { 'hrsh7th/cmp-nvim-lsp' },    -- LSP completions
  { 'hrsh7th/cmp-buffer' },      -- Buffer completions
  { 'hrsh7th/cmp-path' },        -- Path completions
  { 'hrsh7th/cmp-cmdline' },     -- Cmdline completions

  -- Snippet engine
  { 'L3MON4D3/LuaSnip' },

  -- nvim-cmp source for LuaSnip
  { 'saadparwaiz1/cmp_luasnip' },

  -- Optional: Friendly snippets (pre-made snippets for many languages)
  { 'rafamadriz/friendly-snippets' },
  { 'nvim-neotest/nvim-nio' },
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

-- Colorscheme

-- Setup Modicator (very lazy)
require('modicator').setup({
  integration = {
    iualine = { enabled = true, highlight = 'bg' },
  },
})

require('guess-indent').setup {}

-------------------
-- LSP Setup
-------------------
local lspconfig = require('lspconfig')
local null_ls = require("null-ls")

-------------------
-- Python LSP setup (pylsp with pylint for division by 0 and full linting)
-------------------
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.pylsp.setup({
  capabilities = capabilities,  -- Use extended capabilities for nvim-cmp
  settings = {
    pylsp = {
      plugins = {
        pylint = {
          enabled = true,
          args = {
            '--max-line-length=100',
            '--disable=all',
            '--enable=division-by-zero',
            '--enable=undefined-variable',
            '--load-plugins=pylint_django',
          },
        },
        flake8 = {
          enabled = true,
          maxLineLength = 100,
          ignore = { "E203", "E501" },
        },
        pycodestyle = { enabled = false },
        yapf = { enabled = false },
        black = { enabled = true, line_length = 100 },
        mccabe = { enabled = true, complexity = 10 },
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Keymaps for LSP functions (hover, references, rename, etc.)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  end,
})

-------------------
-- TypeScript/JavaScript LSP setup (tsserver/ts_ls)
-------------------

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.ts_ls.setup({
  capabilities = capabilities,  -- This now includes nvim-cmp's LSP capabilities
  on_attach = function(client, bufnr)
    -- keymaps for LSP functions (go to definition, hover, references, etc.)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  end,
})

-- init.lua or your config file

local cmp = require('cmp')
local luasnip = require('luasnip')

-- Set up nvim-cmp
cmp.setup({
  -- Enable completion for LSP, buffer, paths, and cmdline
  sources = {
    { name = 'nvim_lsp' },      -- LSP completions
    { name = 'buffer' },        -- Buffer completions
    { name = 'path' },          -- Path completions
    { name = 'cmdline' },       -- Cmdline completions
    { name = 'luasnip' },       -- Snippet completions
  },

  -- Mapping for completion
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },

  -- Snippet setup
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `LuaSnip` users
    end,
  },

  -- Formatting options
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s %s', entry.source.name, vim_item.kind)
      return vim_item
    end,
  },
})

-- Load VSCode-style snippets (optional)
require("luasnip.loaders.from_vscode").lazy_load()

-- Optional: Add custom snippets
require('luasnip').add_snippets("html", {
  luasnip.snippet("html", {
    luasnip.text_node("<!DOCTYPE html>"),
    luasnip.text_node("<html>"),
    luasnip.text_node("<head>"),
    luasnip.text_node("<title>"),
    luasnip.insert_node(1, "Title"),
    luasnip.text_node("</title>"),
    luasnip.text_node("</head>"),
    luasnip.text_node("<body>"),
    luasnip.insert_node(2, "Content here"),
    luasnip.text_node("</body>"),
    luasnip.text_node("</html>"),
  })
})

-------------------
-- HTML LSP setup (html-languageserver)
-------------------
lspconfig.html.setup{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  end,
}

-------------------
-- CSS LSP setup (css-languageserver)
-------------------
lspconfig.cssls.setup{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  end,
}

-------------------
-- C++ LSP setup (clangd)
-------------------
lspconfig.clangd.setup{
  cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  end,
}

-------------------
-- null-ls setup for linters and formatters
-------------------

-- Setup for null-ls
null_ls.setup({
  sources = {
    -- JavaScript/TypeScript diagnostics and formatting
    null_ls.builtins.diagnostics.eslint.with({
      disable = { "warning" },
      extra_args = { "--max-warnings=5" },  -- Configure max warnings for eslint
    }),
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "html", "css", "javascript", "json", "yaml", "markdown" }
    }),

    -- CSS diagnostics and formatting
    null_ls.builtins.diagnostics.stylelint.with({
      disable = { "warning" },
      extra_args = { "--max-warnings=5" },
    }),
    null_ls.builtins.formatting.stylelint,

    -- Python diagnostics and formatting
    null_ls.builtins.diagnostics.flake8.with({
      extra_args = { "--max-line-length=100", "--select=E,F,W" },
    }),
    null_ls.builtins.formatting.black.with({
      extra_args = { "--line-length", "100" },
    }),

    -- C++ diagnostics and formatting
    --null_ls.builtins.diagnostics.clang_tidy.with({
    --  filetypes = { "cpp", "c", "h", "hpp" }
    --}),
    null_ls.builtins.formatting.clang_format.with({
      filetypes = { "cpp", "c", "h", "hpp" }
    }),

    -- HTML diagnostics
    null_ls.builtins.diagnostics.tidy,
    -- JSON formatting (through Prettier)
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "json" }
    }),

    -- Additional formatters and linters can be added below:
    -- Example for Go
    -- null_ls.builtins.diagnostics.golangci_lint,
    -- null_ls.builtins.formatting.gofmt,
  },
})

-------------------
-- Diagnostic configuration (error detection)
-------------------
vim.diagnostic.config({
  virtual_text = { prefix = '|' },  -- Disable virtual text to improve performance
  signs = true, 
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Diagnostic Signs with modern icons
local signs = { 
  Error = "",     -- Error icon
  Warn = "",      -- Warning icon
  Hint = "",      -- Hint icon
  Info = "",      -- Info icon
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-------------------
-- Key Mappings for LSP functions
-------------------
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap=true, silent=true })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap=true, silent=true })  -- Hover for function info
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap=true, silent=true })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap=true, silent=true })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap=true, silent=true })

vim.o.foldtext = "v:lua.FoldText()"
function _G.FoldText()
  local line = vim.fn.getline(vim.v.foldstart)
  return 'Folded: ' .. line
end
-- In your init.lua
vim.o.foldcolumn = '0'    -- Number of fold columns to display (default 0 means no column)

-------------------
-- All things Debugging
-------------------

local dap = require('dap')
local dapui = require('dapui')

-- Set up debugging for Python using debugpy
dap.adapters.python = {
  type = 'executable',
  command = 'python',  -- or the path to the python binary
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',  -- The currently opened Python file
  }
}

-- Set up debugging for C++ using LLDB
dap.adapters.cppdbg = {
  type = 'executable',
  command = 'lldb-vscode',  -- or just 'lldb' if using default LLDB
  name = 'cppdbg',
}

dap.configurations.cpp = {
  {
    name = 'Launch C++',
    type = 'cppdbg',
    request = 'launch',
    program = '${workspaceFolder}/a.out',  -- Make sure to specify the path to your C++ binary
    args = {},  -- Arguments passed to the program
    cwd = '${workspaceFolder}',  -- Current working directory
    stopAtEntry = false,
    MIMode = 'lldb',  -- Specify the LLDB debugger mode
    miDebuggerPath = '/path/to/lldb-vscode',  -- Path to LLDB (adjust if necessary)
    setupCommands = {
      {
        text = '-enable-pretty-printing',  -- Enable pretty-printing
        description = 'Enable pretty printing',
      },
    },
  },
}

-- Key mappings for debugging (general)
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)  -- Start/Continue debugging
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)  -- Step over
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)  -- Step into
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)  -- Step out
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)  -- Toggle breakpoint
vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Breakpoint condition: ')) end)  -- Conditional breakpoint

vim.keymap.set('n', '<leader>m', function() vim.lsp.buf.formatting_sync() end, { buffer = bufnr, noremap = true, silent = true })


-- Auto-format on save
--vim.api.nvim_exec([[
--  autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.css,*.scss,*.html,*.python,*.cpp,*.h,*.cpp lua vim.lsp.buf.formatting_sync(nil, 1000)
--]], false)
vim.o.completeopt = "menuone,noselect"
-- Disable line numbers and relative numbers in terminal buffers
vim.cmd([[
  autocmd TermOpen * setlocal nonumber norelativenumber
]])

-- Enable line numbers in non-terminal buffers (if needed)
vim.cmd([[
  autocmd BufEnter * if &buftype != 'terminal' | setlocal number relativenumber | endif
]])

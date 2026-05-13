---@diagnostic disable: undefined-global

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nerd font
vim.g.have_nerd_font = true

-- Options
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- Indenting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Basic keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-n>', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })
vim.g.loaded_netrw = 1

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic Quickfix' })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = -1 } end, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = 1 } end, { desc = 'Next diagnostic' })

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diags = vim.diagnostic.get(0, { lnum = line })
    if #diags > 0 then
      vim.diagnostic.open_float(nil, { focus = false })
    end
  end,
})

vim.diagnostic.config {
  virtual_text = {
    spacing = 2,
    prefix = '●',
  },
}

-- Terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Split movement
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move to right split' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move to lower split' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move to upper split' })

-- Yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.g.disable_auto_format = true

-- Install lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup {
  'NMAC427/guess-indent.nvim',

  -- LSP + mason
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      local util = require 'lspconfig.util'

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              diagnostics = { globals = { 'vim' } },
            },
          },
        },
        csharp_ls = {
          filetypes = { 'cs' },
          init_options = {
            AutomaticWorkspaceInit = true,
          },
          root_dir = function(fname)
            return util.root_pattern('*.sln', '*.slnx', '*.csproj')(fname)
              or util.path.dirname(fname)
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require('mason-tool-installer').setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      require('mason-lspconfig').setup {
        automatic_installation = false,
        handlers = {
          function(server)
            local opts = servers[server] or {}
            opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, opts.capabilities or {})
            require('lspconfig')[server].setup(opts)
          end,
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-keymaps', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
          map('gd', vim.lsp.buf.definition, 'Go to Definition')
          map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
        end,
      })
    end,
  },

  -- Colorscheme
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        styles = { comments = { italic = false } },
      }
      vim.cmd.colorscheme 'tokyonight-moon'
      vim.cmd [[
        hi Normal guibg=NONE ctermbg=NONE
        hi NormalNC guibg=NONE ctermbg=NONE
        hi EndOfBuffer guibg=NONE ctermbg=NONE
      ]]
    end,
  },

  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',

  { import = 'custom.plugins' },
}

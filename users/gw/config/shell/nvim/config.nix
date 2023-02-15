{ colors, ... }:
with colors; ''
  lua << EOF

  -- Basics
  ---------
  vim.g.loaded             = 1
  vim.g.loaded_netrwPlugin = 1
  vim.opt.termguicolors    = true

  -- Plugins Setup
  ----------------
  -- Extra plugins not in NixOS's repos
  require('packer').startup(function() 
    use { 'Everblush/everblush.nvim', as = 'everblush',
      require('everblush').setup({
        nvim_tree = { contrast = true }
      })
    }
    use { 'neanias/everforest-nvim',
      require('everforest').setup()
    }
    use 'altercation/solarized'
  end)

  -- Colorscheme Handling
  -- Everforest
  if "${theme}" == "everforest" then
    vim.cmd[[set background=dark]]
    vim.cmd[[colorscheme everforest]]
  -- Catppuccin
  elseif "${theme}" == "catppuccin" then
    require('catppuccin').setup({
      flavour                = "macchiato",
      transparent_background = true,
      term_colors            = true,
    })
    vim.cmd[[colorscheme catppuccin]]
  -- Tokyonight
  elseif "${theme}" == "tokyonight" then
    vim.cmd[[colorscheme tokyonight-moon]]
  -- Everblush
  elseif "${theme}" == "everblush" then
    vim.cmd[[colorscheme everblush]]
  -- Gruvbox (light)
  elseif "${theme}" == "gruvbox" then
    vim.o.background = "light"
    vim.cmd[[colorscheme gruvbox]]
  -- Solarized (light)
  elseif "${theme}" == "solarized_light" then
    vim.o.background = "light"
    vim.cmd[[colorscheme solarized]]
  -- Asabay (mine)
  elseif "${theme}" == "asabay"
    vim.cmd[[colorscheme tokyonight-day]]
  end

  -- Completion
  local cmp = require('cmp')
  cmp.setup({    
    snippet = {
      expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
    },
    mapping = {
      ['<C-b>']     = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>']     = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>']     = cmp.mapping({
        i           = cmp.mapping.abort(),
        c           = cmp.mapping.close(),
      }),
      ['<CR>']      = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, { 
      { name = 'buffer' },
    })
  })
  cmp.setup.cmdline('/', {
    sources = { { name = 'buffer' } }
  })

  -- Bling
  require('colorizer').setup()
  require('lualine').setup({
    options = {
        theme = '${theme}',
        component_separators = { left = ' ', right = ' ' },
        section_separators   = { left = ' ', right = ' ' },
        icons_enabled        = true
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { " " },
      lualine_x = { " " },
      lualine_y = { "encoding" },
      lualine_z = { "location" }
    }
  })
  require('nvim-tree').setup({
    view = {
      adaptive_size = false,
      mappings = { list = {
        { key = "u", action = "dir_up" }
      } }
    },
    renderer = { group_empty = true },
    filters  = { dotfiles = true }
  })

  -- Commenting
  require('nvim-treesitter.configs').setup({
    context_commentstring = { enable = true, enable_autocmd = false }
  })
  require('Comment').setup({
      pre_hook = function(ctx)
          local U = require('Comment.utils') local location = nil
          if ctx.ctype == U.ctype.block then
              location = require('ts_context_commentstring.utils').get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require('ts_context_commentstring.utils').get_visual_start_location()
          end
          return require('ts_context_commentstring.internal').calculate_commentstring {
              key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
              location = location
          }
      end
  })

  -- Settings
  -----------
  vim.o.number       = true
  vim.wo.cursorline  = true
  vim.o.showmatch    = true
  vim.o.hlsearch     = true
  vim.o.incsearch    = true
  vim.o.clipboard    = 'unnamedplus'

  vim.o.syntax       = 'on'
  vim.o.expandtab    = true
  vim.o.shiftwidth   = 8
  vim.bo.autoindent  = true
  vim.bo.smartindent = true

  vim.o.backup       = false
  vim.bo.swapfile    = false

  -- Nvim Tree fixes
  ------------------
  vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = '*',
    callback = function()
      if vim.bo.filetype == 'NvimTree' then
        require'bufferline.api'.set_offset(31, 'FileTree')
      end
    end
  })
  vim.api.nvim_create_autocmd('BufWinLeave', {
    pattern = '*',
    callback = function()
      if vim.fn.expand('<afile>'):match('NvimTree') then
        require'bufferline.api'.set_offset(0)
      end
    end
  })

  -- Keybindings
  --------------
  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }
  -- Show/Hide tree
  map("n", "<A-n>",":NvimTreeToggle<cr>", opts)
  -- Move to previous/next tab
  map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
  map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
  -- Re-order to previous/next tab
  map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
  map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
  -- Kill current buffer
  map('n', '<A-c>', '<Cmd>BufferClose!<CR>', opts)
  -- Window split rebinds
  map('n', '<A-b>', '<Cmd>split<CR>', {})
  map('n', '<A-v>', '<Cmd>vsplit<CR>', {})
  map('n', '<A-h>', '<Cmd>wincmd h<CR>', {})
  map('n', '<A-j>', '<Cmd>wincmd j<CR>', {})
  map('n', '<A-k>', '<Cmd>wincmd k<CR>', {})
  map('n', '<A-l>', '<Cmd>wincmd l<CR>', {})

  EOF
''

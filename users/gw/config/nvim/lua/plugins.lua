require('packer').startup(function()
    -- Basics
    use 'wbthomason/packer.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate<cr>' }
    use { 'norcalli/nvim-colorizer.lua', require('colorizer').setup() }
    use 'sheerun/vim-polyglot'
    -- Commenting
    use { 'JoosepAlviste/nvim-ts-context-commentstring',
            require('nvim-treesitter.configs').setup {
                context_commentstring = { enable = true, enable_autocmd = false }
            }
        }
    use { 'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup {
                    pre_hook = function(ctx)
                        local U = require 'Comment.utils' local location = nil
                        if ctx.ctype == U.ctype.block then
                            location = require('ts_context_commentstring.utils').get_cursor_location()
                        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                            location = require('ts_context_commentstring.utils').get_visual_start_location()
                        end
                        return require('ts_context_commentstring.internal').calculate_commentstring {
                            key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
                            location = location,
                        }
                    end,
                }
            end
        }
    -- Bling
    -- use { 'folke/tokyonight.nvim',
    --         vim.cmd[[colorscheme tokyonight-night]]
    --     }
    use { 'decaycs/decay.nvim', 
            as = 'decay',
            require('decay').setup({
                    style     = 'decayce',
                    italics   = {
                        code     = true,
                        comments = true
                    },
                    nvim_tree = {
                        contrast = true
                    }
                })
    }
    use { 'nvim-lualine/lualine.nvim',
            require('lualine').setup {
                options = {
                    component_separators = { left = ' ', right = ' ' },
                    sections_separators  = { left = ' ', right = ' ' },
                    theme = 'decay',
                }
            }
        }
    use { 'romgrk/barbar.nvim',
            require("bufferline").setup({
                clickable = true,
                auto_hide = false,
                tabpages  = true,
                closable  = false,
                animation = false,
            }),
    }
    -- This is an IDE now
    use { 'kyazdani42/nvim-tree.lua',
            requires = {
                'kyazdani42/nvim-web-devicons',
            },
            require("nvim-tree").setup({
                view = {
                    adaptive_size = true,
                    mappings = {
                        list = {
                            { key = "u", action = "dir_up" },
                        }
                    }
            },
            renderer = {
               group_empty = true
            },
         })
     }
end)

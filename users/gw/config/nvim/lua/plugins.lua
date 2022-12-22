require('packer').startup(function()
    -- Basics
    use 'wbthomason/packer.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate<cr>' }
    use { 'norcalli/nvim-colorizer.lua', require('colorizer').setup() }
    use 'sheerun/vim-polyglot'
    -- Autocompletion
    --[[ use { 'ms-jpq/coq_nvim', branch = 'coq', ]]
    --[[         vim.cmd [[let g:coq_settings = { 'auto_start': 'shut-up' }]]--, ]]
    --[[         require("coq") ]]
    --[[     } ]]
    --[[ use { 'ms-jpq/coq.artifacts', branch = 'artifacts' } ]]
    --[[ use { 'ms-jpq/coq.thirdparty', branch = '3p', ]]
    --[[         require("coq_3p") { ]]
    --[[             { src = "nvimlua", short_name = "nLUA", conf_only = true }, ]]
    --[[             { src = "vimtex",  short_name = "vTEX" }, ]]
    --[[             { src = "copilot", short_name = "COP", accept_key = "<c-f>" }, ]]
    --[[         } ]]
    --[[     } ]]
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
    use { 'folke/tokyonight.nvim',
            vim.cmd[[colorscheme tokyonight-night]]
        }
    use { 'nvim-lualine/lualine.nvim',
            require('lualine').setup {
                options = {
                    component_separators = { left = ' ', right = ' ' },
                    sections_separators  = { left = ' ', right = ' ' },
                    theme = 'tokyonight',
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

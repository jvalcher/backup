
--[[ lualine.nvim ]]--

require('lualine').setup {
    options = {
        --theme = 'ayu_dark',
        icons_enabled = false,
        disabled_filetypes = { 'NvimTree' },
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {''},
        lualine_c = {''},
        lualine_x = {''},
        lualine_y = {'branch', 'diff', 'diagnostics'},
        lualine_z = {''},
    },
}


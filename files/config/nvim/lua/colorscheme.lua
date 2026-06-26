
local M = {}

local aqua       = '#5ea48f'
local blue       = '#3a86ea'
local blueItal   = '#76cce0'
local gray       = '#88909d'
local orange     = '#f3a24d'
local green      = '#6fae6f'
local pink       = '#fc5d7c'
local purpleItal = '#b39df3'
local red        = '#ff5555'
local yellow     = '#e2d28a'

local function apply_dark()
end

local function apply_sonokai()
    vim.opt.background = 'dark'
    vim.api.nvim_set_hl(0, 'LineNr', { fg='#008787', bold=true })
    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

    vim.g.sonokai_transparent_background = 1
    vim.cmd('colorscheme sonokai')

    vim.api.nvim_set_hl(0, '@keyword.repeat', { fg = blue })
    vim.api.nvim_set_hl(0, '@keyword.conditional', { fg = blue })
    vim.api.nvim_set_hl(0, '@string.escape', { fg = blueItal })
    vim.api.nvim_set_hl(0, '@property', { fg = purpleItal })
    vim.api.nvim_set_hl(0, '@constant.builtin', { fg = orange })
    vim.api.nvim_set_hl(0, '@constant.macro', { fg = orange })
    vim.api.nvim_set_hl(0, '@constant', { fg = orange })
    vim.api.nvim_set_hl(0, '@keyword.import', { fg = blue })

    vim.api.nvim_set_hl(0, 'Comment', { fg = gray })
    vim.api.nvim_set_hl(0, 'PreProc', { fg = blue })
    vim.api.nvim_set_hl(0, 'lexPatBlock', { fg = gray, bg = nil })
    vim.api.nvim_set_hl(0, 'Todo', { fg = gray, bg = nil })

    vim.api.nvim_set_hl(0, 'Aqua', { fg = aqua })
    vim.api.nvim_set_hl(0, 'Blue', { fg = blue })
    vim.api.nvim_set_hl(0, 'Orange', { fg = orange })
    vim.api.nvim_set_hl(0, 'Green', { fg = green })
    vim.api.nvim_set_hl(0, 'Red', { fg = red })
    vim.api.nvim_set_hl(0, 'Yellow', { fg = yellow })
end

local function apply_kanagawa()
    vim.opt.background = 'dark'
    vim.cmd("colorscheme kanagawa")
    vim.api.nvim_set_hl(0, 'LineNr', { fg='#008787', bold=true })
end

function M.apply()
    --apply_sonokai()
    apply_kanagawa()
end

return M


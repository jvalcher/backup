local green = "#00ff00"
local blue = "#00aaff"
local yellow = "#ffff00"
local purple = "#cc66ff"
local cyan = "#00ffff"
local orange = "#ff9900"
local pink = "#ff00aa"
local red = "#ff3333"
local teal   = "#00cc99"

vim.api.nvim_set_hl(0, "fcsQuestion", { fg = green, bold = true })
vim.api.nvim_set_hl(0, "fcsAnswer", { fg = purple, bold = true })
vim.api.nvim_set_hl(0, "fcsEnd", { fg = blue, bold = true })
vim.api.nvim_set_hl(0, "fcsImage", { fg = orange, bold = true })
vim.api.nvim_set_hl(0, "fcsAudio", { fg = red, bold = true })
vim.api.nvim_set_hl(0, "fcsVideo", { fg = yellow, bold = true })
vim.api.nvim_set_hl(0, "fcsLink", { fg = pink, bold = true })
vim.api.nvim_set_hl(0, "fcsLast", { fg = cyan, bold = true })
vim.api.nvim_set_hl(0, "fcsCode", { fg = teal, bold = true })

vim.cmd([[
    syntax match fcsQuestion "^\~\+q"
    syntax match fcsAnswer "^\~\+a"
    syntax match fcsEnd "^\~\+e"
    syntax match fcsImage "^\~image:[^:]\+:"
    syntax match fcsAudio "^\~audio:"
    syntax match fcsVideo "^\~video:"
    syntax match fcsLink "^\~link:"
    syntax match fcsLast "^\~last:"
    syntax match fcsCode "^```"
]])


local highlight = {
    "Red",
    "Yellow",
    "Blue",
    "Orange",
    "Green",
    "Violet",
    "Cyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "Red", { fg = "#733e3e" })
    vim.api.nvim_set_hl(0, "Yellow", { fg = "#806b3c" })
    vim.api.nvim_set_hl(0, "Blue", { fg = "#9494e3" })
    vim.api.nvim_set_hl(0, "Orange", { fg = "#a8835b" })
    vim.api.nvim_set_hl(0, "Green", { fg = "#5d8c5b" })
    vim.api.nvim_set_hl(0, "Violet", { fg = "#5c5370" })
    vim.api.nvim_set_hl(0, "Cyan", { fg = "#536470" })
end)

local colors = require("colorscheme")

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

vim.g.rainbow_delimiters = { highlight = highlight }

require("ibl").setup { 
    enabled = false,
    indent = { highlight = highlight },
    scope = { enabled = false }
}


vim.keymap.set("n", "<leader>l", function()
    vim.cmd("IBLToggle")
    colors.apply()
end, { desc = "Toggle indent lines", silent = true })

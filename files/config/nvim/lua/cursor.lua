
vim.opt.updatetime = 250		  -- Decrease update time
vim.opt.timeoutlen = 300		  -- Decrease mapped sequence wait time
vim.opt.startofline = false       -- Preserve cursor position when entering buffer
vim.opt.cursorline = false		  -- Show which line cursor is on

-- Move screen
vim.keymap.set('n', '<C-n>', '<C-e>', { desc = 'Move screen down' });
vim.keymap.set('n', '<C-m>', '<C-y>', { desc = 'Move screen up' });

---- Return cursor to start of visual selection
vim.keymap.set('n', 'v', 'm`v')
vim.keymap.set('n', 'V', 'm`V')
vim.keymap.set('n', '<C-V>', 'm`<C-v>')
vim.keymap.set('x', '<Esc>', "<Esc>:keepjumps normal ``<cr>")

-- Global bookmark jumping with cursor center
local function jump_mark_center(mark)
  pcall(function()
    vim.cmd("normal! '" .. mark .. "zz")
  end)
end
for _, mark in ipairs({"a","b","c","d","e","f","g","h","i","j",
                       "k","l","m","n","o","p","q","r","s","t",
                       "u","v","w","x","y","z"}) do
  vim.keymap.set("n", "'" .. mark, 
    function()
      jump_mark_center(mark)
    end, { noremap = true, silent = true })
end

-- Center cursor
vim.opt.scrolloff = math.floor(0.5 * vim.o.lines)

-- Navigate wrapped lines
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })

--[[

-- Center screen when (re)entering buffer even with blank lines at the end
vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
        local ft = vim.bo.filetype
        if ft == "TelescopePrompt" or ft == "TelescopeResults" then
            return
        end
        vim.schedule(function()
            vim.cmd("normal! zz")
        end)
    end,
})

-- Center screen on cursor when entering buffer
vim.api.nvim_create_autocmd('BufEnter', { pattern = {'*'}, command = 'normal! zz' })

-- Toggle centering screen on cursor
local centering_enabled = true
local centering_maps = {
    { { "n", "v" }, "j",  "gjzz" },
    { { "n", "v" }, "k",  "gkzz" },
    { { "n", "v" }, "G",  "Gzz"  },
    { "n", "''",   "''zz" },
    { "n", "<C-d>", "<C-d>zz" },
    { "n", "<C-u>", "<C-u>zz" },
    { "n", "n",     "nzz" },
    { "n", "N",     "Nzz" },
    { "n", "u",     "uzz" },
    { "n", "<C-r>", "<C-r>zz" },
}
local function enable_centering()
    for _, m in ipairs(centering_maps) do
        local mode, lhs, rhs = m[1], m[2], m[3]
        vim.keymap.set(mode, lhs, rhs, { silent = true })
    end
    centering_enabled = true
end
local function disable_centering()
    for _, m in ipairs(centering_maps) do
        local mode, lhs = m[1], m[2]
        vim.keymap.del(mode, lhs)
    end
    centering_enabled = false
end
local function toggle_centering()
    if centering_enabled then
        disable_centering()
        vim.notify("Cursor free")
    else
        enable_centering()
        vim.notify("Cursor center")
    end
end
vim.keymap.set("n", "<localleader>c", toggle_centering, {
    desc = "Toggle centering motions"
})
enable_centering()

--]]


--[ Help pages ]--

-- Open help page in new tab (:H vim)
vim.api.nvim_create_user_command("H", function(opts)
    vim.cmd("help " .. opts.args .. " | only")
end, { nargs = "*", desc = "Open help page in new tab" })

-- Help page configuration
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help' },
  callback = function(opts)
    local opts = { buffer = true }
    vim.keymap.set({'n', 'v'}, 'j', 'gjzz', opts)
    vim.keymap.set({'n', 'v'}, 'k', 'gkzz', opts)
    vim.keymap.set({'n', 'v'}, 'G', 'Gzz', opts)
    vim.keymap.set('n', "''", "''zz", opts)
  end
})



----------
-- Man pages  (ft-man-plugin)
----------

-- Open man page in new tab (:M 1 mkdir)
vim.api.nvim_create_user_command("M", function(opts)
    vim.cmd("Man " .. opts.args .. " | only")
end, { nargs = "*", desc = "Open man page in new tab" })

-- Open man page for word under cursor in new tab ('K')
local function open_man()
    local word = vim.fn.expand("<cword>")
    vim.cmd("Man " .. word .. " | only")
end
vim.keymap.set('n', 'K', open_man, { desc = "Open man page for word under cursor in new tab"})

-- Man page configuration
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'man' },
  callback = function(opts)
    local opts = { buffer = true }
    vim.keymap.set({'n', 'v'}, 'j', 'gjzz', opts)
    vim.keymap.set({'n', 'v'}, 'k', 'gkzz', opts)
    vim.keymap.set({'n', 'v'}, 'G', 'Gzz', opts)
    vim.keymap.set('n', "''", "''zz", opts)
    vim.keymap.set('n', 'K', open_man, opts)
    vim.keymap.set('n', 'q', ':bdelete<CR>', opts) -- Otherwise q exits Neovim
  end
})

-- Preserve man page cursor position when reentering buffer
vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = "man://*",
    callback = function()
        vim.w._man_last_line = vim.fn.line(".")
    end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "man://*",
    callback = function()
        local lnum = vim.w._man_last_line
        if lnum then
            vim.schedule(function()
                pcall(vim.api.nvim_win_set_cursor, 0, { lnum, 0 })
                vim.cmd("normal! zz")
            end)
        end
    end,
})

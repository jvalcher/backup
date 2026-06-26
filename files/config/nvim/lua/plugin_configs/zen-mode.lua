
require('zen-mode').setup {
    {
        window = {
            width = .5,
            height = vim.api.nvim_win_get_height(0) * .5,
            options = {
                number = false,
            },
        },
    },
    on_open = function(win)
        local ft = vim.bo.filetype
        if ft == "markdown" or ft == "text" then
            vim.opt.number = false
            vim.opt.relativenumber = false
        end
    end,

    on_close = function(win)
        local ft = vim.bo.filetype
        if ft == "markdown" or ft == "text" then
            vim.opt.number = true
            vim.opt.relativenumber = true
        end
    end,
}

vim.keymap.set('n', '<leader>z', ':ZenMode<CR>', { silent = true, desc = 'Toggle zen mode' })

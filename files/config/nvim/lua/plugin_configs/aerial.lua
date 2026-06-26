
require('aerial').setup({
    close_on_select = true,
    backends = { 'treesitter', 'lsp' },
    highlight_closest = true,
    highlight_on_hover = false,
    open_automatic = false,
    layout = { max_width = 40 },
})

local function open_and_move_to_aerial()
    vim.cmd('AerialToggle')
    vim.api.nvim_input('<leader>l')
end

vim.keymap.set('n', '<leader>c', open_and_move_to_aerial, { desc = 'Toggle aerial.nvim' })

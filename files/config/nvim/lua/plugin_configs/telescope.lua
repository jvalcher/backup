vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            'node_modules',
            '.git',
        },
        mappings = {
            i = {
                ["jk"] = { "<esc>", type = "command" },
            },
            n = {
                ['<C-d>'] = actions.delete_buffer,
            },
        },
    },
}

vim.keymap.set('n', '<localleader>g', builtin.live_grep,  { desc = 'Telescope: search for string in cwd' })
vim.keymap.set('n', '<localleader>f', builtin.find_files, { desc = 'Telescope: find files in cwd' })

-- Buffers
--vim.keymap.set('n', '<localleader>b', function()
--    builtin.buffers()
--    vim.api.nvim_input('<Esc>')
--end, { desc = 'Telescope: list open buffers' })

-- LSP
--vim.keymap.set('n', '<leader>m', vim.lsp.buf.hover, {desc = 'LSP: Display hover information' })
--vim.keymap.set('n', '<leader>[', require('telescope.builtin').diagnostics, { desc = 'Telescope: List diagnostics' })
--vim.keymap.set('n', '<leader>y', require('telescope.builtin').lsp_references, { desc = 'lsp: find reference results with telescope ' })
--vim.keymap.set('n', '<leader>u', require('telescope.builtin').lsp_definitions, { desc = 'lsp: jump to word definition' })
--vim.keymap.set('n', '<leader>i', require('telescope.builtin').lsp_implementations, { desc = 'Telescope: Jump to word implementation' })




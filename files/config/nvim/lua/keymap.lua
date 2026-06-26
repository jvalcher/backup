--[[ Key mappings ]]--

-- Return to normal mode from visual mode, clear search highlighting, last command text
local function clear_all()
    vim.api.nvim_input('<Esc>') -- Escape
    vim.cmd('nohlsearch')       -- Clear search highlights
    vim.cmd('stopinsert')       -- Clear last command text
end

-- Create gdb breakpoint string <filename>:<line>, copy to clipboard
local function create_break()
    local filename = vim.fn.expand('%:t')
    local linenumber = vim.fn.line('.')
    local breakpoint = filename .. ':' .. linenumber
    vim.fn.setreg('+', breakpoint)
    print('Copied breakpoint \"' .. breakpoint .. '\" to clipboard')
end

-- Generate C/C++ ctags recursively starting in current directory
local function gen_ctags_c()
    local cmd = vim.env.HOME .. "/.bin/gen_ctags_cwd"
    vim.system({ cmd, "." }, { text = true }, function(res)
        if res.stderr == "" then
            print("C/C++ ctags generated")
        else
            print("stderr:", res.stderr)
        end
    end)
end

-- Copy current file's name, relative path, or absolute path to clipboard
local function copy_file_path(type)
    local file_path
    if type == "abs" then
        file_path = vim.fn.expand('%:p')
    elseif type == "rel" then
        file_path = vim.fn.expand('%:.')
    elseif type == "file" then
        file_path = vim.fn.expand('%')
    end
    vim.fn.setreg('+', file_path)
    print('Copied to clipboard: \"' .. file_path .. '\"')
end

-- Toggle spell checker on/off
local function toggle_spell()
    if vim.opt.spell:get() then
        print ("Spell check off")
    else
        print ("Spell check on")
    end
    vim.opt.spell = not(vim.opt.spell:get())
end

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Misc
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Return to normal mode' })
vim.keymap.set('v', 'd', '"_d', { desc = 'Delete selection without yanking text' });
vim.keymap.set('n', 'dd', '"_dd', { desc = 'Delete line without yanking text' });
vim.keymap.set({'v', 'n'}, '<leader>d', clear_all, { desc = 'Clear search highlighting, visual selection, last command text' })
vim.keymap.set('v', '>', '>gv', { desc = 'Keep visual selection when shifting indent right' })
vim.keymap.set('v', '<', '<gv', { desc = 'Keep visual selection when shifting indent left' })
vim.keymap.set('n', '<leader>t', ':terminal<CR>', { desc = 'Open terminal' });
vim.keymap.set('n', '<leader>b', create_break, { desc = 'Create debugger breakpoint string' });
vim.keymap.set('n', '<localleader>p', toggle_spell, { desc = 'Toggle spell checker on, off' });
vim.keymap.set('n', '<leader>f', function() copy_file_path("file") end, { desc = "Copy current file's name to clipboard" })
vim.keymap.set('n', '<leader>r', function() copy_file_path("rel") end, { desc = "Copy current file's relative path to clipboard" })
vim.keymap.set('n', '<leader>p', function() copy_file_path("abs") end, { desc = "Copy current file's absolute path to clipboard" })
vim.keymap.set('x', "p", '"_dP', { noremap = true, silent = true })
vim.keymap.set('n', "<leader>g", gen_ctags_c, { desc = "Generate C/C++ ctags recursively in cwd" })

-- Buffers
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { desc = 'Delete current buffer'});
--vim.keymap.set('n', '<leader>a', ':bprev<CR>', { desc = 'Go to previous buffer'});    -- Handled with bufferline plugin
--vim.keymap.set('n', '<leader>s', ':bnext<CR>', { desc = 'Go to next buffer'});

-- Panes
vim.keymap.set('n', '<leader>o', ':split<CR>', { desc = 'Open pane below' })
vim.keymap.set('n', '<leader>e', ':vsplit<CR>', { desc = 'Open pane to right' })
vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left pane' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right pane' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower pane' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper pane' })
vim.keymap.set('n', '<leader><left>', '2<C-W>+', { desc = 'Adjust pane size left' })
vim.keymap.set('n', '<leader><right>', '2<C-W>-', { desc = 'Adjust pane size right' })
vim.keymap.set('n', '<leader><down>', '2<C-W>>', { desc = 'Adjust pane size down' })
vim.keymap.set('n', '<leader><up>', '2<C-W><', { desc = 'Adjust pane size up' })


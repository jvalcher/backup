local function on_attach (bufnr)

    local api = require("nvim-tree.api")
    local Event = api.events.Event

    -- Expand all directories on open
    --api.events.subscribe(Event.TreeOpen, function()
    --    api.tree.expand_all()
    --end)

    -- Options
    local function opts (desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    api.config.mappings.default_on_attach (bufnr)

    vim.keymap.set('n', '?',    api.tree.toggle_help,               opts('Help'))
    vim.keymap.set('n', '[e',   api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
    vim.keymap.set('n', ']e',   api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
    vim.keymap.set('n', 'h',    api.tree.toggle_custom_filter,      opts('Toggle Filter: Dotfiles'))
    vim.keymap.set('n', 'b',    api.tree.toggle_no_buffer_filter,   opts('Toggle Filter: No Buffer'))
    vim.keymap.set('n', 'P',    api.tree.change_root_to_parent,     opts('Change root to parent'))
    vim.keymap.set('n', 'C',    ":NvimTreeCollapse<CR>", opts('Collapse all'))

    require('nvim-tree.view').View.winopts.number = true;

end

require('nvim-tree').setup({
    actions = {
        open_file = { quit_on_open = true },
        expand_all = {
            max_folder_discovery = 300,
            exclude = { ".git", "venv", "__pycache__" },
        },
    },
    git = { enable = false },
    update_focused_file = { enable = true },
    view = { width = 46 },
    on_attach = attach_this,
})

local function toggle_tree ()
    local api = require("nvim-tree.api")
    if require('nvim-tree.view').is_visible() then
        api.tree.close_in_this_tab()
    else
        api.tree.open()
        vim.api.nvim_input('zz')
    end
end

vim.keymap.set('n', '<leader>n', toggle_tree, { desc = 'nvim-tree toggle'})


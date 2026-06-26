
-- Disable comment insertion on newline
vim.api.nvim_create_autocmd('BufEnter', { pattern = {'*'}, command = 'set formatoptions-=cro' })

-- Autosave
vim.api.nvim_create_autocmd({ 'InsertLeave', 'FocusLost', 'TextChanged' }, { pattern = {'*'}, command = 'silent! write' })

	-- Move to line where you left off when opening file
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = {"*"},
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_exec("normal! g'\"",false)
        end
    end
})

-- Turn on spell checking
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
        vim.opt_local.spellcapcheck = ""
    end,
})

-- Set 2-space indent filetypes
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = {'*.vimrc', '*.htm', '*.html', '*.yml', '*.yaml','*.json', '*.md', '*.spec', '*.css', '*.scss'},
    command = 'setlocal tabstop=2 shiftwidth=2 softtabstop=2'
})

-- Override arduino indent
vim.api.nvim_create_autocmd("FileType", {
    pattern = "arduino",
    callback = function()
        vim.bo.expandtab = true
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
    end,
})

-- Terminal
vim.api.nvim_create_autocmd('TermOpen', { pattern = {'*'}, command = 'setlocal nonumber' })
vim.api.nvim_create_autocmd('TermOpen', { pattern = {'*'}, command = 'lua vim.api.nvim_input("A")' })
vim.api.nvim_create_autocmd('FocusLost', { pattern = {'*'}, command = 'hi TermCursor cterm=NONE gui=NONE'})
vim.api.nvim_create_autocmd('FocusGained', { pattern = {'*'}, command = 'hi TermCursor cterm=reverse gui=reverse'})

-- vimtex
vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        vim.opt_local.conceallevel = 1
        vim.opt_local.fileencodings = "utf-8"
    end,
})


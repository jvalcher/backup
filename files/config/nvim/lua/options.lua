
--[[ Options ]]--

vim.opt.mouse = 'a'		       	  -- Mouse mode
vim.opt.showmode = false          -- Don't show mode
vim.opt.number = true			  -- Show line numbers
vim.opt.relativenumber = true     -- Show relative line numbers
vim.opt.clipboard = 'unnamedplus' -- Enable clipbard copy/paste
vim.opt.breakindent = true		  -- Enable break indent
vim.opt.undofile = true			  -- Save undo history
vim.opt.ignorecase = true		  -- Case insensitive searching
vim.opt.smartcase = true		  -- Apply capital letters in search if used
vim.opt.signcolumn = 'no'		  -- Enable sign column
vim.opt.splitright = true		  -- Split to right
vim.opt.splitbelow = true		  -- Split to below
vim.opt.inccommand = 'split'	  -- Preview substitutions live
vim.opt.hlsearch = false		  -- Highlight on search
vim.opt.tabstop = 4				  -- Tabstop
vim.opt.shiftwidth = 4			  -- Set shiftwidth
vim.opt.softtabstop = 4           -- Set softtabstop
vim.opt.shiftround = true         -- Set shiftround
vim.opt.expandtab = true          -- Convert tabs to spaces
vim.opt.swapfile = false          -- Disable swap files
vim.opt.wrapscan = false          -- Disable search file wrap
vim.opt.autoindent = true         -- Apply current indent to next line
vim.opt.smartindent = true        -- Apply indent based on syntax/style of code
vim.opt.termguicolors = true      -- Enable 24-bit RGB color
vim.opt.linebreak = true          -- Don't break in middle of word
vim.opt.cinoptions:append("L0")   -- Disable C label: indentation
vim.opt.syntax = "on"

vim.g.pyindent_open_paren = 4

vim.opt.tags = { 
    "tags",
    os.getenv("HOME") .. "/.tags_linux" 
}



local ts_languages = {
  'bash', 'c', 'css', 'dockerfile', 'git_config',
  'git_rebase', 'gitattributes', 'gitcommit',
  'gitignore', 'html', 'htmldjango', 'http',
  'javascript', 'jsdoc', 'json', 'json5', 'kotlin',
  'lua', 'make', 'markdown', 'markdown_inline',
  'python', 'regex', 'query', 'scss', 'sql',
  'ssh_config', 'tmux', 'typescript', 'vim',
  'vimdoc', 'xml', 'yaml', 'rust', 'toml',
}

require'nvim-treesitter'.install(ts_languages)

vim.api.nvim_create_autocmd('FileType', {
  pattern = ts_languages,
  callback = function() vim.treesitter.start() end,
})

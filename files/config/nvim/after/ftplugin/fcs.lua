local opts = {
    buffer = true,
    noremap = true,
    silent = true,
}

local createCard  = "gc"
local nextCard    = "gn"
local prevCard    = "gp"
local insertImage = "gi"
local insertAudio = "ga"
local insertVideo = "gv"
local insertLink  = "gl"

local defaultImageHeight = "400"

local function putAtLineEnd(text)
    vim.cmd("normal! A" .. text)
end

vim.keymap.set("n", createCard, function()
  local current_row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_put({
      "~~~~~~~~~~~~~~~~~~~~~~~~q",
      "",
      "~~~~~~~~~~~~~~~~~~~~~~~~a",
      "",
      "~~~~~~~~~~~~~~~~~~~~~~~~e",
      "",
  }, "l", true, true)
  vim.api.nvim_win_set_cursor(0, { current_row + 2, 0 })
end, opts)

vim.keymap.set("n", nextCard, function()
    vim.fn.search("\\~q", "w")
    vim.cmd("normal! zz")
end)

vim.keymap.set("n", prevCard, function()
    vim.fn.search("\\~q", "b")
    vim.cmd("normal! zz")
end)

vim.keymap.set("n", insertImage, function()
    putAtLineEnd("~image:" .. defaultImageHeight .. ":")
end, opts)

vim.keymap.set("n", insertAudio, function()
    putAtLineEnd("~audio:")
end, opts)

vim.keymap.set("n", insertVideo, function()
    putAtLineEnd("~video:")
end, opts)

vim.keymap.set("n", insertLink, function()
    putAtLineEnd("~link:")
end, opts)

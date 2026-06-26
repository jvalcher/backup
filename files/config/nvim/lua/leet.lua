local function copy_between_markers()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    local start_idx, end_idx = nil, nil

    for i, line in ipairs(lines) do
        if line:find("^// START") then
            start_idx = i
        elseif line:find("^// END") then
            end_idx = i
        end
    end

    if not start_idx or not end_idx or start_idx >= end_idx then
        vim.notify("Markers not found", vim.log.levels.ERROR)
        return
    end

    local chunk = table.concat(
        vim.list_slice(lines, start_idx + 1, end_idx - 1),
        "\n"
    )

    vim.fn.setreg("+", chunk)
    vim.notify("Copied LeetCode answer to clipboard")
end

vim.keymap.set("n", "<localleader>l", copy_between_markers)

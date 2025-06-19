-- lua/config/autocmds.lua
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    while #lines > 0 and lines[#lines]:match("^%s*$") do
      table.remove(lines, #lines)
    end
    table.insert(lines, "")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  end,
})

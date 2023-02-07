
local M = {}

function M.flatten_sql()
  local raw_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local lines = {}
  for _, line in ipairs(raw_lines) do
    -- strip whitespace
    local line_trimmed = string.gsub(line, "^%s*(.-)%s*$", "%1")
    local no_comments = string.gsub(line_trimmed, "%-%-.*", "")
    if no_comments ~= "" then
      table.insert(lines, no_comments)
      -- if we ran into a semicolon, it's the end of a statement
      if string.find(no_comments, ";") then
        break
      end
    end
  end
  -- set the clipboard
  vim.fn.setreg("*", table.concat(lines, " "))
  print("Set clipboard")
end

return M

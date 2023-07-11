
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


function M.flatten_sql_highlighted()
  -- need this so marks are set when we go to copy
  vim.cmd('noau normal! :silent "vy"')
  --[[
  print(vim.inspect{
      vim.fn.visualmode(), -- last visual mode
      vim.fn.getpos("'<'"), -- last start 
      vim.fn.getpos("'>'"), -- last end 
      vim.fn.line('v'), -- current visual line 
      vim.fn.col('v') -- current visual column 
  })
  --]]
  -- print("Exiting normal mode")
  local m1 = vim.api.nvim_buf_get_mark(0, "<")[1]
  local m2 = vim.api.nvim_buf_get_mark(0, ">")[1]
  local raw_lines = vim.api.nvim_buf_get_lines(0, m1-1, m2+1, false)
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
  print("Set clipboard (highlighted only)")
end

return M

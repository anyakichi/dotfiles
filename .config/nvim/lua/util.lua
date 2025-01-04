local M = {}

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.curry(f, ...)
  local args = { ... }
  return function(...)
    local result = f(unpack(args), ...)
    return result
  end
end

function M.curry2(f, ...)
  local args = { ... }
  return function(a, ...)
    local result = f(a, unpack(args), ...)
    return result
  end
end

local function subapply(s, f, i, j)
  i = i or 1
  j = j or #s
  return s:sub(1, i - 1) .. f(s:sub(i, j)) .. s:sub(j + 1)
end

function M.Filterfunc(f, type)
  if not type then
    _G.operatorfunc = M.curry(M.Filterfunc, f)
    vim.opt.operatorfunc = "v:lua.operatorfunc"
    return "g@"
  elseif type == "block" then
    local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local end_line = unpack(vim.api.nvim_buf_get_mark(0, ">"))

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local new_lines = vim.iter(lines):map(M.curry2(subapply, f, start_col + 1)):totable()
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
  else
    local start_line = unpack(vim.api.nvim_buf_get_mark(0, "["))
    local end_line = unpack(vim.api.nvim_buf_get_mark(0, "]"))

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local new_lines = vim.iter(lines):map(f):totable()
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
  end
end

function M.filterfunc(f, type)
  if not type then
    _G.operatorfunc = M.curry(M.filterfunc, f)
    vim.opt.operatorfunc = "v:lua.operatorfunc"
    return "g@"
  elseif type == "block" then
    local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local new_lines =
      vim.iter(lines):map(M.curry2(subapply, f, start_col + 1, end_col + 1)):totable()
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
  elseif type == "char" then
    local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, "["))
    local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, "]"))

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local new_lines = {}

    if #lines == 1 then
      table.insert(new_lines, subapply(lines[1], f, start_col + 1, end_col + 1))
    else
      table.insert(new_lines, subapply(lines[1], f, start_col + 1))
      for i = 2, #lines - 1 do
        table.insert(new_lines, f(lines[i]))
      end
      table.insert(new_lines, subapply(lines[#lines], f, 1, end_col + 1))
    end

    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
  else
    local start_line = unpack(vim.api.nvim_buf_get_mark(0, "["))
    local end_line = unpack(vim.api.nvim_buf_get_mark(0, "]"))

    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local new_lines = vim.iter(lines):map(f):totable()
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, new_lines)
  end
end

return M

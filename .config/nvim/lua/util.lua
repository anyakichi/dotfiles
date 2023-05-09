local M = {}

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.wrap(f, ...)
  local args = { ... }
  return function()
    return f(unpack(args))
  end
end

return M

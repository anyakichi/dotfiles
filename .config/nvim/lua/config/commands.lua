vim.api.nvim_create_user_command("ReadCommand", function(opts)
  vim.system(opts.fargs, { text = true }, function(job)
    if job.code == 0 then
      local output = job.stdout:gsub("\n$", "")
      local lines = vim.split(output, "\n")
      vim.schedule(function()
        if opts.bang then
          vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
        else
          local cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1
          vim.api.nvim_buf_set_lines(0, cursor_line, cursor_line, false, lines)
        end
      end)
    else
      print(("code: %d, stderr: %s"):format(job.code, job.stderr))
    end
  end)
end, { nargs = "*", bang = true, complete = "file" })

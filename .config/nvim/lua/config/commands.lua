vim.api.nvim_create_user_command("ReadCommand", function(opts)
  vim.system(opts.fargs, { text = true }, function(job)
    if job.code == 0 then
      vim.schedule(function()
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(job.stdout, "\n"))
      end)
    else
      print(("code: %d, stderr: %s"):format(job.code, job.stderr))
    end
  end)
end, { nargs = "*", complete = "file" })

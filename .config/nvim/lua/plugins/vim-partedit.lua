return {
  "thinca/vim-partedit",
  cmd = "Partedit",
  init = function()
    vim.g["partedit#filetype"] = "markdown"
    vim.g["partedit#opener"] = "split"

    local function partedit_filetype()
      local prevline_nr = vim.fn.getpos("v")[2] - 1
      local prevline =
        vim.api.nvim_buf_get_lines(0, prevline_nr - 1, prevline_nr, false)
      local _, _, filetype = prevline[1]:find("%s*```%s*([^:]+)")
      return filetype or vim.g["partedit#filetype"]
    end

    vim.keymap.set("x", "<Space>p", function()
      return string.format(
        ":Partedit<Space>-filetype<Space>%s",
        partedit_filetype()
      )
    end, { expr = true })
  end,
}

return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    return {
      actions = {
        files = {
          default = require("fzf-lua").actions.file_edit,
        },
      },
      grep = {
        rg_glob = true,
        glob_separator = "%s//",
      keymap = {
        fzf = { false },
      },
    }
  end,
  init = function()
    vim.keymap.set("n", "<C-s>", require("fzf-lua").buffers)
    vim.keymap.set("n", "<C-_>", require("fzf-lua").oldfiles)
    vim.keymap.set("n", "<C-g>.", require("fzf-lua").files)
    vim.keymap.set("n", "<C-g>q", require("fzf-lua").quickfix)
    vim.keymap.set("n", "<C-g>l", require("fzf-lua").loclist)
    vim.keymap.set("n", "<C-g><C-g>", ":<C-u>LiveGrep<Space>")
    vim.keymap.set("n", "<C-g>g", require("fzf-lua").live_grep_resume)
    vim.keymap.set("n", "<C-g><C-m>", require("fzf-lua").marks)
    vim.keymap.set("n", "<C-g><C-t>", require("fzf-lua").tags)
    vim.keymap.set("n", "<C-g>/", require("fzf-lua").search_history)
    vim.keymap.set("n", "<C-g>:", function()
      local fzf = require("fzf-lua")
      fzf.command_history({ actions = { ["ctrl-e"] = false, ["ctrl-y"] = fzf.actions.ex_run } })
    end)
    vim.keymap.set("n", "<C-g>;", "<C-g>:", { remap = true })
    vim.keymap.set("n", "<C-g><C-l>", require("fzf-lua").blines)
    vim.keymap.set("n", "<C-g>L", require("fzf-lua").lines)
    vim.keymap.set("n", "<C-g>C", require("fzf-lua").git_commits)
    vim.keymap.set("n", "<C-g>c", require("fzf-lua").git_bcommits)

    local function fzf_files(edit, opts)
      local fzf = require("fzf-lua")
      local map = {
        edit = fzf.actions.file_edit,
        split = fzf.actions.file_split,
        vsplit = fzf.actions.file_vsplit,
        tabedit = fzf.actions.file_tabedit,
      }
      local actions = { default = map[edit] or map.edit }

      if #opts.fargs == 0 then
        fzf.files({ actions = actions })
      else
        local dir = nil
        for i = #opts.fargs, 1, -1 do
          if vim.fn.isdirectory(vim.fn.expand(opts.fargs[i])) ~= 0 then
            dir = table.remove(opts.fargs, i)
            break
          end
        end

        for _, file in ipairs(opts.fargs) do
          vim.cmd(string.format("%s %s", edit, vim.fn.fnameescape(file)))
        end

        if dir then
          fzf.files({ actions = actions, cwd = dir })
        end
      end
    end

    for _, cmd in ipairs({ "edit", "split", "vsplit", "tabedit" }) do
      vim.api.nvim_create_user_command(cmd:sub(1, 1):upper() .. cmd:sub(2), function(opts)
        fzf_files(cmd, opts)
      end, { nargs = "*", complete = "file" })
    end

    vim.api.nvim_create_user_command("LiveGrep", function(opts)
      local args = {}
      args.search = table.remove(opts.fargs, 1)
      args.filespec = table.concat(opts.fargs, " ")
      if args.search == nil then
        args.continue_last_search = true
      elseif args.search == "-" then
        args.search = nil
      end
      require("fzf-lua").live_grep(args)
    end, { nargs = "*", complete = "file" })
  end,
}

return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  opts = function()
    return {
      actions = {
        files = {
          true,
          ["ctrl-]"] = require("fzf-lua").actions.file_edit,
          ["ctrl-o"] = require("fzf-lua").actions.file_edit,
          ["enter"] = require("fzf-lua").actions.file_tabedit,
        },
      },
      grep = {
        rg_glob = true,
        rg_glob_fn = function(query, opts)
          local utils = require("fzf-lua.utils")
          local libuv = require("fzf-lua.libuv")
          local regex, flags = query:match("(.-)" .. opts.glob_separator .. "%s(.*)")
          if flags then
            return (regex or query), flags
          end

          local glob_args = ""
          regex, flags = query:match("(.*)" .. opts.glob_separator .. "(.*)")
          for _, s in ipairs(utils.strsplit(flags, "%s")) do
            glob_args = glob_args .. ("%s %s "):format(opts.glob_flag, libuv.shellescape(s))
          end
          return regex, glob_args
        end,
      },
      keymap = {
        fzf = { false },
      },
    }
  end,
  keys = {
    { "<C-/>", "<Cmd>FzfLua tabs<CR>", desc = "FzfLua tabs" },
    { "<C-_>", "<Cmd>FzfLua tabs<CR>", desc = "FzfLua tabs" },
    { "<C-g>/", "<Cmd>FzfLua search_history<CR>", desc = "FzfLua search_history" },
    {
      "<C-g>:",
      function()
        FzfLua.command_history({
          actions = { ["ctrl-e"] = false, ["ctrl-y"] = FzfLua.actions.ex_run },
        })
      end,
      desc = "FzfLua command_history",
    },
    { "<C-g>;", "<C-g>:", desc = "FzfLua command_history", remap = true },
    { "<C-g><C-.>", "<Cmd>FzfLua files<CR>", desc = "FzfLua files" },
    { "<C-g><C-/>", "<Cmd>FzfLua oldfiles<CR>", desc = "FzfLua oldfiles" },
    { "<C-g><C-_>", "<Cmd>FzfLua oldfiles<CR>", desc = "FzfLua oldfiles" },
    {
      "<C-g><C-d>",
      "<Cmd>FzfLua diagnostics_document<CR>",
      desc = "FzfLua diagnostics_document",
    },
    { "<C-g><C-f>", "<Cmd>FzfLua lsp_finder<CR>", desc = "FzfLua lsp_finder" },
    { "<C-g><C-g>", ":<C-u>LiveGrep<Space>", desc = "FzfLua live_grep" },
    { "<C-g><C-h>", "<Cmd>FzfLua helptags<CR>", desc = "FzfLua helptags" },
    { "<C-g><C-l>", "<Cmd>FzfLua loclist<CR>", desc = "FzfLua loclist" },
    { "<C-g><C-m>", "<Cmd>FzfLua marks<CR>", desc = "FzfLua marks" },
    { "<C-g><C-r>", "<Cmd>FzfLua registers<CR>", desc = "FzfLua registers" },
    { "<C-g><C-s>", "<Cmd>FzfLua spell_suggest<CR>", desc = "FzfLua spell_suggest" },
    { "<C-g><C-t>", "<Cmd>FzfLua treesitter<CR>", desc = "FzfLua treesitter" },
    { "<C-g><C-u>", "<Cmd>FzfLua undotree<CR>", desc = "FzfLua undotree" },
    { "<C-g>C", "<Cmd>FzfLua git_commits<CR>", desc = "FzfLua git_commits" },
    { "<C-g>L", "<Cmd>FzfLua lines<CR>", desc = "FzfLua lines" },
    { "<C-g>T", "<Cmd>FzfLua tags<CR>", desc = "FzfLua tags" },
    { "<C-g>c", "<Cmd>FzfLua git_bcommits<CR>", desc = "FzfLua git_bcommits" },
    { "<C-g>g", "<Cmd>FzfLua live_grep_resume<CR>", desc = "FzfLua live_grep_resume" },
    { "<C-g>h", "<Cmd>FzfLua highlights<CR>", desc = "FzfLua highlights" },
    { "<C-g>k", "<Cmd>FzfLua keymaps<CR>", desc = "FzfLua keymaps" },
    { "<C-g>l", "<Cmd>FzfLua blines<CR>", desc = "FzfLua blines" },
    { "<C-g>m", "<Cmd>FzfLua manpages<CR>", desc = "FzfLua manpages" },
    { "<C-g>q", "<Cmd>FzfLua quickfix<CR>", desc = "FzfLua quickfix" },
    { "<C-g>s", "<Cmd>FzfLua spellcheck<CR>", desc = "FzfLua spellcheck" },
    { "<C-g>t", "<Cmd>FzfLua btags<CR>", desc = "FzfLua btags" },
    { "<C-s>", "<Cmd>FzfLua buffers<CR>", desc = "FzfLua buffers" },
  },
  init = function()
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
        args.resume = true
      elseif args.search == "-" then
        args.search = nil
      end
      require("fzf-lua").live_grep(args)
    end, { nargs = "*", complete = "file" })
  end,
}

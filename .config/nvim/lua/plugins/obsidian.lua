return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/.obsidian-vault/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/.obsidian-vault/*.md",
  },
  cmd = {
    "ObsidianDailies",
    "ObsidianNew",
    "ObsidianQuickSwitch",
    "ObsidianSearch",
    "ObsidianToday",
  },
  keys = {
    { "<Leader>oT", "<cmd>ObsidianToday<CR>", desc = "Today's note" },
    { "<Leader>oa", "<cmd>ObsidianTemplate<CR>", desc = "Add template" },
    { "<Leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Back links" },
    { "<Leader>od", "<cmd>ObsidianDailies<CR>", desc = "Daily notes" },
    { "<Leader>ol", "<cmd>ObsidianLinks<CR>", desc = "Links" },
    { "<Leader>on", "<cmd>ObsidianNew<CR>", desc = "New note" },
    { "<Leader>oo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Open a note" },
    { "<Leader>oq", "<cmd>ObsidianTemplate today-section<CR>", desc = "Add today's section" },
    { "<Leader>or", "<cmd>ObsidianRename<CR>", desc = "Rename a note" },
    { "<Leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search notes" },
    { "<Leader>ot", "<cmd>ObsidianTags<CR>", desc = "Search tags" },
    {
      "<Leader>ov",
      function()
        require("fzf-lua").grep({ cwd = "~/.obsidian-vault", search = os.date("📅 %Y-%m-%d") })
      end,
      desc = "Search today's tasks",
    },
  },
  enabled = vim.fn.isdirectory(vim.fn.expand("~/.obsidian-vault")) == 1,
  opts = {
    daily_notes = {
      date_format = "%Y/%m/%Y-%m-%d",
      template = "daily.md",
    },
    disable_frontmatter = true,
    note_id_func = function(_)
      return os.date("%Y%m%d%H%M%S")
    end,
    picker = {
      name = "fzf-lua",
    },
    templates = {
      folder = "/Templates",
      substitutions = {
        ["date-1"] = function()
          return os.date("%Y-%m-%d", os.time() - (60 * 60 * 24))
        end,
        ["date+1"] = function()
          return os.date("%Y-%m-%d", os.time() + (60 * 60 * 24))
        end,
      },
    },
    ui = { enable = false },
    wiki_link_func = "use_alias_only",
    workspaces = {
      {
        name = "default",
        path = "~/.obsidian-vault",
      },
    },
  },
}

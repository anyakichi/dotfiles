return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/.obsidian-vault/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/.obsidian-vault/*.md",
  },
  cmd = {
    "Obsidian",
  },
  keys = {
    { "<Leader>oT", "<cmd>Obsidian today<CR>", desc = "Today's note" },
    { "<Leader>oa", "<cmd>Obsidian template<CR>", desc = "Add template" },
    { "<Leader>ob", "<cmd>Obsidian backlinks<CR>", desc = "Back links" },
    { "<Leader>od", "<cmd>Obsidian dailies<CR>", desc = "Daily notes" },
    { "<Leader>ol", "<cmd>Obsidian links<CR>", desc = "Links" },
    { "<Leader>on", "<cmd>Obsidian new<CR>", desc = "New note" },
    { "<Leader>oo", "<cmd>Obsidian quick_switch<CR>", desc = "Open a note" },
    { "<Leader>oq", "<cmd>Obsidian template today-section<CR>", desc = "Add today's section" },
    { "<Leader>or", "<cmd>Obsidian rename<CR>", desc = "Rename a note" },
    { "<Leader>os", "<cmd>Obsidian search<CR>", desc = "Search notes" },
    { "<Leader>ot", "<cmd>Obsidian tags<CR>", desc = "Search tags" },
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
    legacy_commands = false,
    daily_notes = {
      date_format = "%Y/%m/%Y-%m-%d",
      template = "daily.md",
    },
    frontmatter = {
      enabled = false,
    },
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

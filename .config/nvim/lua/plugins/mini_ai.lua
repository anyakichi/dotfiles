return {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  config = function()
    local mini_ai = require("mini.ai")
    mini_ai.setup({
      custom_textobjects = {
        k = { "「().-()」" },
        K = { "『().-()』" },
        [""] = { "（().-()）" },
      },
    })
  end,
}

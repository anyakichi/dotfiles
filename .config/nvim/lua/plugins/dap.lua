return {
  "mfussenegger/nvim-dap",
  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dd", ":<C-u>DapRun<Space>", desc = "Run" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
  dependencies = {
    {
      "mfussenegger/nvim-dap-python",
      config = function()
        require("dap-python").setup()
      end,
    },
    "nvim-neotest/nvim-nio",
    {
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({reset = true}) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
      },
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup({
          layouts = {
            {
              elements = {
                {
                  id = "scopes",
                  size = 0.25,
                },
                {
                  id = "breakpoints",
                  size = 0.25,
                },
                {
                  id = "stacks",
                  size = 0.25,
                },
                {
                  id = "watches",
                  size = 0.25,
                },
              },
              position = "right",
              size = 0.4,
            },
            {
              elements = {
                {
                  id = "repl",
                  size = 0.5,
                },
                {
                  id = "console",
                  size = 0.5,
                },
              },
              position = "bottom",
              size = 10,
            },
          },
        })
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({ reset = true })
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end,
    },
    "simrat39/rust-tools.nvim",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    dap.configurations.rust = {
      {
        name = "Launch",
        type = "rt_lldb",
        request = "launch",
        program = function()
          return vim.fn.input({
            prompt = "Path to executable: ",
            default = vim.fn.getcwd() .. "/",
            completion = "file",
          })
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
          return { vim.fn.input("args: ") }
        end,
      },
    }
    dap.configurations.c = dap.configurations.rust
    dap.configurations.cpp = dap.configurations.rust

    vim.api.nvim_create_user_command("DapRun", function(opts)
      local bin_dir = vim.fn.expand(".")
      local bin_name = table.remove(opts.fargs, 1)
      if vim.o.filetype == "rust" then
        local metadata = vim.fn.system({ "cargo", "metadata", "--no-deps", "--format-version=1" })
        bin_dir = vim.fn.systemlist({ "jq", "-r", ".target_directory" }, metadata)[1] .. "/debug"
        if not bin_name or bin_name == "-" then
          bin_name = vim.fn.systemlist(
            { "jq", "-r", '.packages[].targets[] | select(.kind | map(. == "bin")) | .name' },
            metadata
          )[1]
        end
      end
      if not bin_name or bin_name == "-" then
        bin_name = vim.fn.input({
          prompt = "Path to executable: ",
          default = bin_dir .. "/",
          completion = "file",
        })
      end
      require("dap").run({
        type = "rt_lldb",
        request = "launch",
        program = bin_dir .. "/" .. bin_name,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = opts.fargs,
      })
    end, { nargs = "*", complete = "file" })

    for name, sign in pairs(require("config").icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end
  end,
}

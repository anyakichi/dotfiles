return {
  cmd = {
    "node",
    require("lazy.core.config").options.root .. "/vim-rescript/server/out/server.js",
    "--stdio",
  },
}

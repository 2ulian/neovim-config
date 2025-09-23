return {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          (vim.env.VIMRUNTIME or vim.fn.expand("$VIMRUNTIME")) .. "/lua",
          vim.fn.stdpath("config") .. "/lua",
        },
      },
    },
  },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
}

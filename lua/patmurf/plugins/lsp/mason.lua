-- mason.lua
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        -- core
        "bashls",
        "clangd",
        "csharp_ls",
        "cmake",
        "dockerls",
        "jsonls",
        "markdown_oxide",
        "matlab_ls",
        "rust_analyzer",
        "sqlls",
        "taplo",
        "gitlab_ci_ls",
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        -- frontend
        "svelte",
        "graphql",
        "emmet_ls",
        "prismals",
        -- other languages
        "lua_ls",
        "pyright",
        "ltex",
      },
    })
  end,
}

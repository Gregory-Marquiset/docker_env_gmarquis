{
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
  end,
},
{
  "williamboman/mason-lspconfig.nvim",
  after = "mason.nvim",
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua-language-server", "stylua" },
      automatic_installation = true,
    })
  end,
},
{
  "neovim/nvim-lspconfig",
}
{
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  after = "mason.nvim",
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = { "lua-language-server", "stylua" },
      auto_update = true,
      run_on_start = true,
    })
  end,
}

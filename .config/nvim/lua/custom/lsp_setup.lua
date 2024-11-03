require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")

local servers = { "lua-language-server", "stylua", "bashls", "jsonls" }

mason_lspconfig.setup({
  ensure_installed = servers,
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      on_attach = function(_, bufnr)
        -- Ajoutez ici vos raccourcis et options
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end,
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
  end,
})

-- Installation automatique des serveurs
for _, server in ipairs(servers) do
  vim.cmd("MasonInstall " .. server)
end

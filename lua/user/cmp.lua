local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- Configuración de snippets
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- Confirmar con Enter
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    -- Otras teclas útiles
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- Completar desde el LSP
    { name = "buffer" },   -- Completar desde el buffer
    { name = "path" },     -- Completar rutas
  }),
})
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
  },
  opts = function()
    local cmp = require("cmp")
    return {
      mapping = cmp.mapping.preset.insert(),
      sources = {
        { name = "buffer" },
        { name = "path" },
        { name = "nvim_lsp" },
      },
    }
  end,
}
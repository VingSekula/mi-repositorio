return {
  -- Iconos para otros plugins
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true, -- Se carga solo cuando lo necesita otro plugin
  },

  -- Lualine (barra de estado)
  {
    "nvim-lualine/lualine.nvim",
    lazy = false, -- Carga al inicio
    config = function()
      require("lualine").setup()
    end,
  },

  -- Integración con Obsidian
  {
    "epwalsh/obsidian.nvim",
    lazy = false, -- Cargar al inicio
    config = function()
      require("obsidian").setup({
        dir = "~/Documents/Daniel Díaz", -- Ruta al vault de Obsidian
        completion = {
          nvim_cmp = true, -- Habilitar autocompletado con nvim-cmp
        },
        finder = {
          sort_by = "name", -- Ordenar por nombre
          prioritize_title_match = true, -- Priorizar coincidencias exactas con títulos
        },
      })
    end,
  },
}

return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true, -- Solo se carga cuando es necesario
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false, -- Se carga al inicio
    config = function()
      require("lualine").setup()
    end,
  },
  {
    "epwalsh/obsidian.nvim", -- Plugin de Obsidian
    lazy = false, -- Cargar inmediatamente al inicio
    config = function()
      require("obsidian").setup({
        dir = "~/Documents/Daniel Díaz", -- Ruta al vault
        completion = {
          nvim_cmp = true, -- Habilitar autocompletado
        },
        finder = {
          sort_by = "name", -- Ordenar por nombre
          prioritize_title_match = true, -- Prioriza coincidencias con títulos exactos
        },
      })
    end,
  },
}

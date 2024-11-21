return {
  "stevearc/aerial.nvim",
  opts = {
    backends = { "lsp", "treesitter", "markdown" },
    layout = {
      default_direction = "right",
      min_width = 30,
    },
    attach_mode = "global",
    highlight_on_jump = true,
  },
  lazy = false, -- Fuerza la carga inmediata del plugin
  keys = { -- Asegúrate de que `keys` esté dentro del plugin
    { "<leader>a", "<cmd>AerialToggle<CR>", desc = "Toggle Aerial Outline" },
  },
}

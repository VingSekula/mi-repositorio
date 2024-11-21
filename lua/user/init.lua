require("lazy").setup({
  -- Otros ajustes aquí...
  ui = {
    -- Ocultar notificaciones de advertencias específicas
    notifications = {
      disable = {
        "Re-sourcing your config is not supported with lazy.nvim",
      },
    },
  },
})

return {
  -- Otros plugins...

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Iconos para archivos
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true, -- Cierra el árbol si es la última ventana
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          follow_current_file = true, -- Abre automáticamente el árbol en el archivo actual
          hijack_netrw_behavior = "open_current", -- Reemplaza netrw
          use_libuv_file_watcher = true,
        },
        buffers = {
          follow_current_file = true,
        },
        default_component_configs = {
          indent = { padding = 2 },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
          },
        },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim", -- Dependencia para File Browser
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--hidden",
            "--no-ignore",
            "--fixed-strings", -- Necesario para tratar patrones literales
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--pcre2", -- Soporte para expresiones regulares avanzadas
          },
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
        },
        extensions = {
          file_browser = {
            hijack_netrw = true, -- Reemplaza netrw
            mappings = {
              ["i"] = {}, -- Mapas adicionales para modo insertar (opcional)
              ["n"] = {}, -- Mapas adicionales para modo normal (opcional)
            },
          },
        },
      })

      -- Cargar la extensión del File Browser
      telescope.load_extension("file_browser")
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    lazy = false,
    config = function()
      -- Obtener el año, el mes y el día de la semana dinámicamente
      local current_year = os.date("%Y")
      local current_month = os.date("%m-%B"):gsub("^%l", string.upper) -- Ejemplo: "11-Noviembre"
      local day_of_week = os.date("%A"):lower() -- Día de la semana en minúsculas

      require("obsidian").setup({
        dir = "~/Documents/Daniel Díaz", -- Ruta absoluta de tu vault
        completion = {
          nvim_cmp = true, -- Habilitar autocompletado
        },
        daily_notes = {
          folder = "3-Notas diarias/" .. current_year .. "/" .. current_month, -- Ruta dinámica
          date_format = "%Y-%m-%d-" .. day_of_week, -- Formato: YYYY-MM-DD-dia
        },
      })

      -- Mapeos personalizados
      vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>", { noremap = true, silent = true }) -- Nota diaria
      vim.keymap.set("n", "<leader>oq", ":ObsidianQuickSwitch<CR>", { noremap = true, silent = true }) -- Buscar notas rápidamente
      vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { noremap = true, silent = true }) -- Buscar texto dentro de las notas
      vim.keymap.set("n", "<leader>on", ":ObsidianNew ", { noremap = true, silent = false }) -- Crear nueva nota (requiere nombre)
      vim.keymap.set("n", "gf", function()
        require("obsidian").open_note_under_cursor()
      end, { noremap = true, silent = true }) -- Abrir wikilink bajo el cursor
    end,
  },

  -- Añade el archivo de mapeos
  {
    config = function()
      require("user.mappings")
    end,
  },
}

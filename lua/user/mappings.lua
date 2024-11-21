-- Mapeos específicos para Obsidian.nvim y Telescope

-- Ver backlinks (notas entrantes) con `<leader>ob`
vim.keymap.set("n", "<leader>ob", function()
  local current_note = vim.fn.expand("%:t:r") -- Nombre de la nota actual (sin extensión)
  require("telescope.builtin").live_grep({
    prompt_title = "Notas Entrantes (Backlinks)",
    cwd = "/Users/danidiaz/Documents/Daniel Díaz", -- Ruta completa al vault
    default_text = "[[" .. current_note .. "]]", -- Busca el patrón exacto del enlace
    additional_args = function()
      return { "--fixed-strings" } -- Asegura que rg interprete el patrón literalmente
    end,
  })
end, { noremap = true, silent = true, desc = "Ver notas entrantes (backlinks)" })

-- Ver outlinks (notas salientes) con `<leader>oo`
vim.keymap.set("n", "<leader>oo", function()
  local current_file = vim.fn.expand("%:p")
  print("Archivo: " .. current_file) -- Verifica la ruta
  require("telescope.builtin").live_grep({
    prompt_title = "Depuración Outlinks",
    search_dirs = { current_file },
    default_text = "\\[\\[.*\\]\\]",
    additional_args = function()
      return { "--pcre2" }
    end,
  })
end, { noremap = true, silent = true, desc = "Depuración outlinks" })

-- Buscar archivos exactos (sólo `.md`) en el vault con `<leader>ox`
vim.keymap.set("n", "<leader>ox", function()
  require("telescope.builtin").find_files({
    prompt_title = "Buscar Archivo Exacto",
    cwd = "/Users/danidiaz/Documents/Daniel Díaz", -- Ruta completa al vault
    find_command = { "rg", "--files", "--iglob", "*.md" }, -- Busca sólo archivos .md
  })
end, { noremap = true, silent = true, desc = "Buscar archivo exacto en el vault" })

-- Buscar texto en el archivo actual con `<leader>fz`
vim.keymap.set("n", "<leader>fz", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Buscar en el archivo actual" })

-- Buscar backlinks con soporte para múltiples coincidencias en el archivo actual con `<leader>bb`
vim.keymap.set("n", "<leader>bb", function()
  local current_note = vim.fn.expand("%:t:r") -- Nombre de la nota actual
  require("telescope.builtin").live_grep({
    prompt_title = "Backlinks en Todo el Vault",
    cwd = "/Users/danidiaz/Documents/Daniel Díaz", -- Ruta completa al vault
    default_text = "[[" .. current_note .. "]]", -- Coincidencia exacta
    additional_args = function()
      return { "--fixed-strings" } -- Trata la búsqueda literalmente
    end,
  })
end, { noremap = true, silent = true, desc = "Buscar backlinks en todo el vault" })

-- Buscar backlinks y outlinks en una misma búsqueda con `<leader>bl`
vim.keymap.set("n", "<leader>bl", function()
  require("telescope.builtin").live_grep({
    prompt_title = "Buscar Backlinks y Outlinks",
    cwd = "/Users/danidiaz/Documents/Daniel Díaz", -- Ruta completa al vault
    default_text = "\\[\\[.*\\]\\]", -- Patrón genérico para enlaces
    additional_args = function()
      return { "--pcre2" } -- Expresiones regulares avanzadas
    end,
  })
end, { noremap = true, silent = true, desc = "Buscar backlinks y outlinks" })

vim.keymap.set("n", "<leader>fe", function()
    require("telescope").extensions.file_browser.file_browser({
        path = "%:p:h", -- Empieza en el directorio del archivo actual
        cwd = vim.fn.expand("%:p:h"), -- Define el directorio de trabajo como el actual
        respect_gitignore = false, -- Ignora archivos en `.gitignore`
        hidden = true, -- Muestra archivos ocultos
        grouped = true, -- Agrupa directorios primero
    })
end, { noremap = true, silent = true, desc = "Abrir File Browser" })

return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--hidden",
        "--no-ignore",
        "--fixed-strings",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--pcre2",
      },
      prompt_prefix = "🔍 ",
    },
  },
  config = function(_, opts)
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    require("telescope").setup(opts)

    local function move_or_copy_file(operation)
      local current_file = vim.fn.expand("%:p")
      if current_file == "" then
        print("No hay archivo seleccionado.")
        return
      end

      require("telescope.builtin").find_files({
        prompt_title = operation == "copy" and "Seleccionar Carpeta para Copiar" or "Seleccionar Carpeta para Mover",
        cwd = vim.fn.getcwd(),
        find_command = { "fd", "--type", "d" }, -- Usa `fd` para buscar solo carpetas
        attach_mappings = function(prompt_bufnr, map)
          local function perform_operation()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)

            if selection and selection.path then
              local destination = selection.path
              local command = operation == "move" and { "mv", current_file, destination }
                or { "cp", current_file, destination }
              vim.fn.system(command)
              print("Archivo " .. operation .. " a: " .. destination)
            else
              print("Operación cancelada.")
            end
          end

          map("i", "<CR>", perform_operation)
          map("n", "<CR>", perform_operation)
          return true
        end,
      })
    end

    vim.keymap.set("n", "<leader>cf", function()
      move_or_copy_file("copy")
    end, { noremap = true, silent = true, desc = "Copiar archivo a una carpeta" })

    vim.keymap.set("n", "<leader>mf", function()
      move_or_copy_file("move")
    end, { noremap = true, silent = true, desc = "Mover archivo a una carpeta" })
  end,
}

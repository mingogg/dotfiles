-- stylua: ignore start
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,

  config = function()
    -- Configuración básica de Neo-tree
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_by_name = {
            "node_modules",
            ".cache",
            ".eclipse",
            ".local",
            ".mozilla",
            ".npm",
            ".npm-global",
            ".pki",
            ".ssh",
            ".swt",
            ".XCompose",
            ".bash_history",
            ".bash_logout",
            ".bash_profile",
            ".npmrc",
            ".python_history",
          },
          always_show = {
            ".config",
            "nvim/.config",
            "kitty/.config",
            "hypr/.config",
          },
        },

        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },

        bind_to_cwd = false,
        use_libuv_file_watcher = true,
      }
    })

    -- Cerrar Neo-tree
    vim.keymap.set("n", "<leader>r", "<cmd>Neotree close filesystem<CR>", {
      desc = "Close Neo-tree",
    })

    -- Toggle focus Neo-tree / previous window
    local last_window = nil

    vim.keymap.set("n", "<leader>e", function()
      local current_win = vim.api.nvim_get_current_win()
      local found = false
      local neo_tree_win = nil

      -- Busca ventana Neo-tree
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")
        if ft == "neo-tree" then
          neo_tree_win = win
          found = true
          break
        end
      end

      local ft_current = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype")

      if ft_current == "neo-tree" then
        -- Si ya estás en Neo-tree, vuelve a la ventana anterior
        if last_window and vim.api.nvim_win_is_valid(last_window) then
          vim.api.nvim_set_current_win(last_window)
        end
      else
        -- Guardamos la ventana actual para poder volver luego
        last_window = current_win

        if found then
          vim.api.nvim_set_current_win(neo_tree_win)
        else
          local current_dir = vim.fn.expand("%:p:h")
          vim.cmd("Neotree reveal dir=" .. current_dir)
        end
      end
    end, { desc = "Toggle focus Neo-tree / previous window" })
  end
}
-- stylua: ignore end

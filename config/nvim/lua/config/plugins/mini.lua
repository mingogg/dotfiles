return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "sa",
          delete = "sd",
          replace = "sr",
          find = "sf",
          highlight = "sh",
          update_n_lines = "sn",
        }
      })
    end,
  },
}

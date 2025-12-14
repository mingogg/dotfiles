return (
  {
    {
      "folke/todo-comments.nvim",
      event = "VimEnter",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = { signs = false },
    },

    {
      'numToStr/Comment.nvim',
    },

    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        local npairs = require("nvim-autopairs")

        npairs.setup({})

        local Rule = require("nvim-autopairs.rule")

        npairs.add_rules({
          Rule("/**", " */", "javascript, typescript, typescriptreact, javascriptreact"),
        })
      end,
    },

  }
)

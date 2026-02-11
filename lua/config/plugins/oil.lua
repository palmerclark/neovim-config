return {
  {
    'nvim-mini/mini.icons',
    version = "*",
    config = function()
      require("mini.icons").setup()
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    lazy = false,
    config = function()
      local mini_icons = require("mini.icons")
      require("oil").setup({
        use_devicons = false,
        icons = mini_icons.icons,
        keymaps = {
          ["<leader>cd"] = {
            "actions.cd",
            opts = {
              silent = false,
            }
          }
        }
      })
    end,
  }
}

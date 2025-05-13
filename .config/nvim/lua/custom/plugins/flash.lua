return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>j", mode = { "n",}, function() require("flash").jump() end, desc = "Flash" },
  },
}

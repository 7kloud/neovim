return {
  -- Add a command to toggle between Nerd Font icons and ASCII fallbacks
  {
    "nvim-lualine/lualine.nvim",
    keys = {
      {
        "<leader>ui",
        function()
          vim.g.have_nerd_font = not vim.g.have_nerd_font
          -- Force lualine to refresh
          require("lualine").refresh()
          local status = vim.g.have_nerd_font and "enabled" or "disabled"
          vim.notify("Nerd Font icons " .. status, vim.log.levels.INFO)
        end,
        desc = "Toggle Nerd Font Icons",
      },
    },
  },
}

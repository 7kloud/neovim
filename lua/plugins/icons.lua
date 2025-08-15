return {
  -- Configure mini.icons for proper icon rendering
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- Ensure nvim-web-devicons is properly configured as fallback
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh"
        },
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "GitIgnore"
        },
        ["tmux.conf"] = {
          icon = "",
          color = "#1BB91F",
          name = "Tmux"
        },
      },
      color_icons = true,
      default = true,
      strict = true,
    },
  },
}

return {
  -- Configure Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- load during startup
    priority = 1000, -- make sure it loads before all other plugins
    config = function()
      local ok, catppuccin = pcall(require, "catppuccin")
      if not ok then
        vim.notify("Catppuccin theme not available, falling back to default", vim.log.levels.WARN)
        return
      end

      catppuccin.setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- LazyVim specific integrations
          alpha = true,
          dashboard = true,
          flash = true,
          grug_far = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          lsp_trouble = true,
          mason = true,
          neotest = true,
          noice = true,
          telescope = true,
          which_key = true,
        },
      })

      -- Apply the colorscheme
      local colorscheme_ok, _ = pcall(vim.cmd, "colorscheme catppuccin")
      if not colorscheme_ok then
        vim.notify("Failed to apply Catppuccin colorscheme", vim.log.levels.WARN)
      end
    end,
  },

  -- Configure LazyVim to use Catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}

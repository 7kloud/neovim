return {
  -- Configure additional Go tools via Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Go Language Server
        "gopls",
        
        -- Formatters
        "gofumpt",      -- Stricter gofmt
        "goimports",    -- Auto-import management
        "golines",      -- Long line formatter
        
        -- Linters (optional - gopls provides most linting via LSP)
        "golangci-lint", -- Comprehensive Go linter for manual use
        "staticcheck",   -- Advanced static analysis
        
        -- Debugging
        "delve",        -- Go debugger
        
        -- Testing and benchmarking
        "gotests",      -- Generate Go tests
        "gotestsum",    -- Enhanced test output
        
        -- Code generation and refactoring
        "impl",         -- Generate interface implementations
        "gomodifytags", -- Modify struct tags
        "iferr",        -- Generate if err != nil blocks
      },
    },
  },

  -- Enhanced Go LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                -- Enable additional analyses for better linting
                shadow = true,
                simplifycompositelit = true,
                simplifyrange = true,
                simplifyslice = true,
                sortslice = true,
                testinggoroutine = true,
                unreachable = true,
                unusedvariable = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
      },
    },
  },

  -- Configure formatters for Go
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
      },
    },
  },

  -- Manual linting commands (gopls provides most linting via LSP)
  {
    "neovim/nvim-lspconfig",
    keys = {
      {
        "<leader>cl",
        function()
          -- Run golangci-lint manually and show results in quickfix
          local cmd = "golangci-lint run --out-format=line-number " .. vim.fn.expand("%")
          local output = vim.fn.system(cmd)
          if vim.v.shell_error == 0 then
            vim.notify("No linting issues found", vim.log.levels.INFO)
          else
            -- Parse output and populate quickfix list
            local lines = vim.split(output, "\n")
            local qf_list = {}
            for _, line in ipairs(lines) do
              if line ~= "" then
                local parts = vim.split(line, ":")
                if #parts >= 4 then
                  table.insert(qf_list, {
                    filename = parts[1],
                    lnum = tonumber(parts[2]) or 1,
                    col = tonumber(parts[3]) or 1,
                    text = table.concat(vim.list_slice(parts, 4), ":"),
                  })
                end
              end
            end
            if #qf_list > 0 then
              vim.fn.setqflist(qf_list)
              vim.cmd("copen")
            end
          end
        end,
        desc = "Run golangci-lint on current file",
        ft = "go",
      },
      {
        "<leader>cL",
        function()
          -- Run golangci-lint on entire project
          local cmd = "golangci-lint run"
          vim.cmd("!" .. cmd)
        end,
        desc = "Run golangci-lint on entire project",
        ft = "go",
      },
    },
  },

  -- Go-specific treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "gosum",
      },
    },
  },

  -- DAP (Debug Adapter Protocol) for Go debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = { ensure_installed = { "delve" } },
      },
      {
        "leoluz/nvim-dap-go",
        config = true,
      },
    },
  },

  -- Go-specific testing support
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          -- Here we can set options for neotest-go, e.g.
          -- args = { "-tags=integration" }
        },
      },
    },
  },

  -- Additional Go keymaps and commands
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- Add Go-specific keymaps
      keys[#keys + 1] = { "<leader>cR", "<cmd>GoRun<cr>", desc = "Run Go Program", ft = "go" }
      keys[#keys + 1] = { "<leader>ct", "<cmd>GoTest<cr>", desc = "Run Go Tests", ft = "go" }
      keys[#keys + 1] = { "<leader>cT", "<cmd>GoTestFunc<cr>", desc = "Run Go Test Function", ft = "go" }
      keys[#keys + 1] = { "<leader>cc", "<cmd>GoCoverage<cr>", desc = "Go Coverage", ft = "go" }
    end,
  },
}

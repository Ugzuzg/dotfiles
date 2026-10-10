return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "nvim-neotest/nvim-nio",
    },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          cwd = function(path)
            return vim.fs.dirname(vim.fs.find("jest.config.js", { path = path, upward = true })[1])
          end,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
        virtual_lines = true,
      },
      servers = {
        tsc = { mason = true },
        vtsls = { enabled = false },
        r_language_server = { enabled = false },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.quarto = { "injected" }
      opts.formatters_by_ft.rmd = { "injected" }
      opts.formatters_by_ft.r = { "air" }

      local root_has_oxfmt_project = vim.fs.find({ "oxfmt.config.ts" }, { upward = true, path = vim.fn.getcwd() })[1]

      if root_has_oxfmt_project then
        opts.formatters_by_ft.javascript = { "oxfmt" }
        opts.formatters_by_ft.javascriptreact = { "oxfmt" }
        opts.formatters_by_ft.typescript = { "oxfmt" }
        opts.formatters_by_ft.typescriptreact = { "oxfmt" }
        opts.formatters_by_ft.json = { "oxfmt" }
        opts.formatters_by_ft.vue = { "oxfmt" }
      end
    end,
  },
}

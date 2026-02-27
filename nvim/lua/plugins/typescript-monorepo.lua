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
      servers = {
        vtsls = {
          enabled = false,
        },
      },
    },
  },
}

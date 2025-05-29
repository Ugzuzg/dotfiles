local get_root_dir = function(fname)
  local util = require("lspconfig.util")
  return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    or util.root_pattern("package.json", "tsconfig.json")(fname)
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          -- root_dir = get_root_dir,
          -- set the path to the node binary with pointer compression
          -- https://github.com/yioneko/vtsls/issues/136#issuecomment-1919246219
          settings = {
            typescript = {
              tsserver = {
                nodePath = "/home/ugzuzg/node-v22.9.0-linux-x64-glibc-217/bin/node",
              },
            },
          },
        },
      },
    },
  },
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
}

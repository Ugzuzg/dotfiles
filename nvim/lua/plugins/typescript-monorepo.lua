local get_root_dir = function(fname)
  local util = require("lspconfig.util")
  return util.find_git_ancestor(fname) or util.root_pattern("package.json", "tsconfig.json")(fname)
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        root_dir = get_root_dir,
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
}

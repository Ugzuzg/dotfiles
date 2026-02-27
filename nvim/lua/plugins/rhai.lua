return {
  { "rhaiscript/vim-rhai" },
  { "phha/zenburn.nvim" },
  { "lbrayner/vim-rzip" },
  -- { "s1n7ax/nvim-window-picker", opts = { hint = "floating-big-letter" } },
  {
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        pattern = [[.*<((KEYWORDS)\s*(-\d+)?):]],
      },
      search = {
        pattern = [[\b(KEYWORDS)(-\d+)?:]],
      },
    },
  },
  -- { "xiyaowong/transparent.nvim", lazy = false },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard =
        ---@class snacks.dashboard.Config
        {
          width = 80,
          sections = {
            { section = "header" },
            { section = "keys", gap = 1, padding = 1 },
            function()
              local git_root = Snacks.git.get_root()
              local in_git = git_root ~= nil
              local on_github = in_git
                and vim.fn.system({ "git", "-C", git_root, "remote", "-v" }):match("github.com") ~= nil
              local on_rad = in_git and vim.fn.system({ "git", "-C", git_root, "remote", "-v" }):match("rad://") ~= nil
              local cmds = {
                -- {
                --   title = "Open Issues",
                --   cmd = "gh issue list -L 3",
                --   key = "i",
                --   action = function()
                --     vim.fn.jobstart("gh issue list --web", { detach = true })
                --   end,
                --   icon = " ",
                --   height = 7,
                -- },
                -- {
                --   icon = " ",
                --   title = "jj log",
                --   cmd = "jj log",
                --   height = 20,
                -- },
                {
                  title = "Open Issues",
                  enabled = on_rad,
                  cmd = "rad issue list",
                  icon = " ",
                  height = 7,
                },
                {
                  icon = " ",
                  title = "Open PRs",
                  cmd = "GH_PAGER= gh pr list",
                  key = "P",
                  action = function()
                    vim.fn.jobstart("gh pr list --web", { detach = true })
                  end,
                  height = 15,
                },
              }
              return vim.tbl_map(function(cmd)
                return vim.tbl_extend("force", {
                  pane = 2,
                  section = "terminal",
                  enabled = on_github,
                  padding = 1,
                  ttl = 5 * 60,
                  indent = 3,
                }, cmd)
              end, cmds)
            end,
            { section = "startup" },
          },
        },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      max_count = 5,
      disable_mouse = false,
      disabled_keys = {
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<Left>"] = {},
        ["<Right>"] = {},
      },
    },
  },
}

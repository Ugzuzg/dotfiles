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
      max_count = 10,
      disable_mouse = false,
      disabled_keys = {
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<Left>"] = {},
        ["<Right>"] = {},
      },
    },
  },

  {
    "kawre/leetcode.nvim",
    opts = {
      lang = "rust",
      injector = {
        ["rust"] = {
          before = { "fn main(){}", "struct Solution;" },
        }, ---@type table<lc.lang, lc.inject>
      },
      hooks = {
        ---@type fun(question: lc.ui.Question)[]
        ["question_enter"] = {
          function(question)
            if question.lang ~= "rust" then
              return
            end

            local cargo_path = require("leetcode.config").user.storage.home .. "/Cargo.toml"
            local content = [[
                  [package]
                  name = "leetcode"
                  edition = "2024"

                  [lib]
                  name = "%s"
                  path = "%s"

                  [dependencies]
                  rand = "0.8"
                  regex = "1"
                  itertools = "0.14.0"
                ]]

            local file = io.open(cargo_path, "w")
            if file then
              local formatted = (content:gsub(" +", "")):format(question.q.frontend_id, question:path())
              file:write(formatted)
              file:close()
            else
              print("Failed to open file: " .. cargo_path)
            end

            -- like the extraPackages, only keep these two lines if you dont have a system-wide rust-toochain configured
            vim.env.RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}"
            vim.cmd("LspRestart rust_analyzer")
          end,
        },
      },
    },
  },
}

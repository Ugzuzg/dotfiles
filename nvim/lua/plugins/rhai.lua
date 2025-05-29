return {
  { "rhaiscript/vim-rhai" },
  { "phha/zenburn.nvim" },
  { "s1n7ax/nvim-window-picker", opts = { hint = "floating-big-letter" } },
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
  { "xiyaowong/transparent.nvim", lazy = false },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disable_mouse = false,
    },
  },
}

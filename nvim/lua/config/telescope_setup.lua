local map = vim.api.nvim_set_keymap

local silent = { silent = true, noremap = true }
-- Navigate buffers and repos
map('n', '<c-p>', [[<cmd>Telescope git_files<cr>]], silent)
map('n', '<c-d>', [[<cmd>Telescope find_files<cr>]], silent)
map('n', '<c-s>', [[<cmd>Telescope buffers show_all_buffers=true<cr>]], silent)
-- map('n', '<c-P>', [[<cmd>Telescope file_browser<cr>]], silent)
map('n', '<c-a>', [[<cmd>Telescope buffers show_all_buffers=true<cr>]], silent)
map('n', '<c-e>', [[<cmd>Telescope frecency<cr>]], silent)
map('n', '<c-g>', [[<cmd>Telescope live_grep<cr>]], silent)

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Speed up loading Lua modules in Neovim to improve startup time.
  use 'lewis6991/impatient.nvim'

  -- Movement
  use 'chaoren/vim-wordmotion'
  use {
    {
      'ggandor/leap.nvim',
      requires = 'tpope/vim-repeat',
      config = [[require'leap'.add_default_mappings()]],
    },
    { 'ggandor/flit.nvim', config = [[require'flit'.setup { labeled_modes = 'nv' }]] },
  }

  -- Indentation tracking
  -- TODO: more things can be configured
  use { 'lukas-reineke/indent-blankline.nvim', config = [[require'indent_blankline'.setup { show_end_of_line = true, space_char_blankline = " " }]] }

    -- Search
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'telescope-frecency.nvim',
        'telescope-fzf-native.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
      },
      wants = {
        'popup.nvim',
        'plenary.nvim',
        'telescope-frecency.nvim',
        'telescope-fzf-native.nvim',
      },
      setup = [[require('config.telescope_setup')]],
      config = [[require('config.telescope')]],
      cmd = 'Telescope',
      module = 'telescope',
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      after = 'telescope.nvim',
      requires = 'tami5/sqlite.lua',
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
    'crispgm/telescope-heading.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
  }

  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use 'kyazdani42/nvim-web-devicons'

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'RRethy/nvim-treesitter-textsubjects',
    },
    config = [[require'config.treesitter']],
    run = ':TSUpdate',
  }
  use 'nvim-treesitter/nvim-treesitter-context'

  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup {}
    end,
  }

  use 'jnurmine/Zenburn'


  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'
  use {
    'jose-elias-alvarez/typescript.nvim',
    config = [[require'typescript'.setup {}]]
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

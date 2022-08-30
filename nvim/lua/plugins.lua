vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Let packer manage itself
  use 'wbthomason/packer.nvim'
  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      require('conf.nvim-lsp-installer-conf')
    end
  }
  -- MyLspConfig
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'

  use {
    'tami5/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {}
    end
  }

  -- MyStatusLine
  use({
    'NTBBloodbath/galaxyline.nvim',
    config = function()
      require('galaxyline.themes.eviline')
    end,
    -- some optional icons
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  })

  -- MyDashboard
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end
  }
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  -- telescope
  use 'nvim-telescope/telescope-live-grep-args.nvim'
  use 'nvim-telescope/telescope.nvim'
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use 'nvim-telescope/telescope-ui-select.nvim'
  use 'nvim-telescope/telescope-rg.nvim'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'kosayoda/nvim-lightbulb' -- code action
  use 'ray-x/lsp_signature.nvim' -- show function signature when typing
  use 'windwp/nvim-autopairs' -- Autopairs, integrates with both cmp and treesitter
  use 'terrortylor/nvim-comment'
  use { 'akinsho/bufferline.nvim', tag = '2.*', requires = 'kyazdani42/nvim-web-devicons' }

  -- colorscheme
  use 'navarasu/onedark.nvim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- toggleterm.nvim
  use 'akinsho/toggleterm.nvim'

  -- tabout.nvim
  use 'abecodes/tabout.nvim'

  -- markdown-preview.nvim
  use({ 'iamcco/markdown-preview.nvim', run = 'cd app && npm install',
    setup = function() vim.g.mkdp_filetypes = { 'markdown' } vim.g.mkdp_browser = 'wsl-open' end, ft = { 'markdown' } })

  -- switch
  -- use { 'Leiyi548/vim-im-select' }
end)

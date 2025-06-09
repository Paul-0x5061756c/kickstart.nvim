return {
  -- NeoTree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = {
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
      vim.cmd([[ hi NeoTreeNormal guibg=NONE ]])
      vim.cmd([[ hi NeoTreeNormalNC guibg=NONE ]])
      vim.cmd([[ hi NeoTreeWinSeparator guibg=NONE ]])
    end,
  },
}

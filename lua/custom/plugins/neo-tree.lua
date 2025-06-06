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
  },
  vim.cmd [[ hi NeoTreeNormal guibg=NONE ctermbg=NONE
  hi NeoTreeNormalNC guibg=NONE ctermbg=NONE
  hi NeoTreeEndOfBuffer guibg=NONE ctermbg=NONE
]]
}

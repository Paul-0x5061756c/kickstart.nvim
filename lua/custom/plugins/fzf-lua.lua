return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")

      -- Setup
      fzf.setup {}

      -- Keymaps
      vim.keymap.set("n", "<leader>ss", fzf.builtin, { desc = "FZF: All pickers" })
      vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "FZF: Files" })
      vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "FZF: Live Grep" })
      vim.keymap.set("n", "<leader>sb", fzf.buffers, { desc = "FZF: Buffers" })
      vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "FZF: Help" })

      -- LSP mappings
      vim.keymap.set("n", "grr", fzf.lsp_references, { desc = "LSP References" })
      vim.keymap.set("n", "gri", fzf.lsp_implementations, { desc = "LSP Implementations" })
      vim.keymap.set("n", "grd", fzf.lsp_definitions, { desc = "LSP Definitions" })
      vim.keymap.set("n", "grt", fzf.lsp_typedefs, { desc = "LSP Type Definitions" })
      vim.keymap.set("n", "gO", fzf.lsp_document_symbols, { desc = "Document Symbols" })
      vim.keymap.set("n", "gW", fzf.lsp_workspace_symbols, { desc = "Workspace Symbols" })
    end,
  }
}


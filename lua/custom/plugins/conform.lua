return {
  -- Autoformat
  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local no = { c = true, cpp = true }
        if no[vim.bo[bufnr].filetype] then return nil end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
      formatters_by_ft = { lua = { "stylua" } },
    },
  },
}

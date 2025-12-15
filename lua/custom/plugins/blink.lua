return {
  {
    'saghen/blink.cmp',
    build = 'cargo build --release',
    opts = {
      keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },
      },
      completion = {
        menu = { auto_show = true },
      },
      fuzzy = {
        implementation = 'prefer_rust',
      },
    },
  },
}

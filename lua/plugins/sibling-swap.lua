return {
  'Wansmer/sibling-swap.nvim',
  dependencies = { 'nvim-treesitter' },
  opts = {
    use_default_keymaps = false,
  },
  config = function(_, opts)
    local map  = LazyVim.safe_keymap_set
    local swap = require('sibling-swap')
    swap.setup(opts)

    map('n', '<leader>.', swap.swap_with_right,          { desc = 'swap to right' })
    map('n', '<leader>,', swap.swap_with_left,           { desc = 'swap to left' })
    map('n', '<leader>:', swap.swap_with_right_with_opp, { desc = 'swap to right opposite' })
    map('n', '<leader>;', swap.swap_with_left_with_opp,  { desc = 'swap to left opposite' })
  end,
}

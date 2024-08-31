local telescope = {
	"nvim-telescope/telescope.nvim",
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function(...)
		require('telescope').setup({})
		local builtin = require('telescope.builtin')
		local keymaps = require("keymaps").telescope
		vim.keymap.set('n', keymaps.find_files, builtin.find_files, {})
		vim.keymap.set('n', keymaps.live_grep, builtin.live_grep, {})
		vim.keymap.set('n', keymaps.diagnostics, builtin.diagnostics, {})
	end,
}

return telescope

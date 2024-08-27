return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	lazy = false,
	init = function(...)
		vim.cmd("colorscheme kanagawa")
	end,
}

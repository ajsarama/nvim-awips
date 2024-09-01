local keymaps = require("keymaps")

local ensure_installed = {
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"make",
	"java",
	"gitcommit",
	"gitignore",
	"git_config",
	"git_rebase",
	"bash",
	"diff",
	"markdown",
	"markdown_inline",
	"json",
	"yaml",
	"toml",
	"regex",
}

local parser_path = vim.fn.stdpath("config") .. "/treesitter-parsers"
vim.opt.rtp:prepend(parser_path)

local function config_tree_sitter()
	---@diagnostic disable-next-line
	require('nvim-treesitter.configs').setup({
		ensure_installed = ensure_installed,
		sync_install = true,

		parser_install_dir = parser_path,

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},

		indent = {
			enable = true,
		},

		incremental_selection = {
			enable = false
		},
	})
end

local tree_sitter = {
	"nvim-treesitter/nvim-treesitter",
	init = function(...)
		config_tree_sitter()
		-- download treesitter lang updates
		vim.cmd("TSUpdateSync")
	end,
}

local select = {
	enable = true,

	-- Automatically jump forward to textobj, similar to targets.vim
	lookahead = true,

	keymaps = {
		[keymaps.ts_textobj.function_outer] = "@function.outer",
		[keymaps.ts_textobj.function_inner] = "@function.inner",
		[keymaps.ts_textobj.comment_outer] = "@comment.outer",
		[keymaps.ts_textobj.comment_inner] = "@comment.inner",
	},

}

local function config_tree_sitter_to()
	---@diagnostic disable-next-line
	require 'nvim-treesitter.configs'.setup {
		textobjects = {
			select = select,
		},
	}
end

local tree_sitter_to = {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	init = function(...)
		config_tree_sitter_to()
	end,

}

return { tree_sitter, tree_sitter_to }

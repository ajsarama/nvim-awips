local jdtls = {
	"mfussenegger/nvim-jdtls",
	dependencies = { "neovim/nvim-lspconfig" },
	lazy = true,
	ft = "java",
}

local lsp = {
	"neovim/nvim-lspconfig",
	lazy = false,
}

return { lsp, jdtls }

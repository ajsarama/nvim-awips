-- Path to java 17 or newer
local java_17_path = '/Users/ajsarama/awips/java/jdk-17.0.11.jdk/Contents/Home/bin/java'

-- org.eclipse.equinox.launcher[version].jar
-- from jdtls/plugins
local jdtls_plugin_path = '/Users/ajsarama/awips/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'

-- config_[os] directory
local jdtls_config_path = '/Users/ajsarama/awips/jdtls/config_mac'

local working_dirs = {
	["/test/test"] = "/working/dir",
	["/Users/ajsarama/JavaProjects/SocketTesting"] = "/Users/ajsarama/awips/workspace",
}

local root = vim.fs.root(0, ".git")

-- Do not load if we are not in the AWIPS directory
if not working_dirs[root] then
	return
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		java_17_path,

		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

		-- 💀
		'-jar', jdtls_plugin_path,

		'-configuration', jdtls_config_path,

		'-data', working_dirs[root],
	},

	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = root,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
		}
	},
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

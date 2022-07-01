require('nvim-treesitter.configs').setup {
	ensure_installed = { 
		"python", 
		"comment", 
		"lua", 
		"typescript", 
		"javascript", 
		"rust",
		"kotlin",
		"c_sharp",
		"html",
		"css",
		"svelte",
		"json",
		"toml",
		"regex",
		"yaml",
	},
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
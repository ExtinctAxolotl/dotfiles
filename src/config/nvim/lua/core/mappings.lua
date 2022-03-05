-- ░█▀▄░█▀█░▀█▀░█▀▀░▀█▀░█░░░█▀▀░█▀▀
-- ░█░█░█░█░░█░░█▀▀░░█░░█░░░█▀▀░▀▀█
-- ░▀▀░░▀▀▀░░▀░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀
--
-- By: @ExtinctAxolotl
local map = require("core.utils").map
local M = {}

M.misc = function()
	local function foomaps()
		map({ "v", "n" }, "<leader>Cy", '"+y', { noremap = true })
		map({ "v", "n" }, "<leader>Cp", '"+p', { noremap = true })
		map({ "v", "n" }, "<leader>CP", '"+P', { noremap = true })
	end

	local function required_maps()
		-- Add Packer commands because we are not loading it at startup
		vim.cmd("silent! command PackerClean lua require 'pack' require('packer').clean()")
		vim.cmd("silent! command PackerCompile lua require 'pack' require('packer').compile()")
		vim.cmd("silent! command PackerInstall lua require 'pack' require('packer').install()")
		vim.cmd("silent! command PackerStatus lua require 'pack' require('packer').status()")
		vim.cmd("silent! command PackerSync lua require 'pack' require('packer').sync()")
		vim.cmd("silent! command PackerUpdate lua require 'pack' require('packer').update()")
		-- vim.cmd("silent! command PackerProfile lua require 'pack' require('packer').output_profile()")
	end
	foomaps()
	required_maps()
end

M.filetree = function()
	map("n", "<leader>f", "<cmd>NvimTreeToggle<cr>")
end

M.lsp = function()
	map("n", "gr", "<cmd>lua vim.lsp.buf.rename()<cr>")
	map("n", "gx", "<cmd>lua vim.lsp.buf.code_action()<cr>")
	map("n", "K", "<cmd>lua vim.lsp.buf.definition()<cr>")
	map("n", "go", "<cmd>lua vim.diagnostic.setloclist()<cr>")
	map("n", "gj", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
	map("n", "gk", "<cmd>lua vim.diagnostic.goto_next()<cr>")
end

M.zen = function()
	map("n", "<leader>Za", "<cmd>TZAtaraxis<cr>")
	map("n", "<leader>Zm", "<cmd>TZMinimalist<cr>")
	map("n", "<leader>Zf", "<cmd>TZFocus<cr>")
end

M.mundo = function()
	map("n", "<leader>u", "<cmd>MundoToggle<cr>")
end

M.telescope = function()
	map("n", "<leader>s", "<cmd>Telescope find_files<cr>")
	map("n", "<leader>th", "<cmd>Telescope oldfiles<cr>")
	map("n", "<leader>tg", "<cmd>Telescope grep_string<cr>")
end

M.term = function()
	map("n", "<leader>Tc", "<cmd>lua _Term_cargo_run_toggle()<cr>")
	map("n", "<leader>G", "<cmd>lua _Term_lazygit()<cr>")
end

M.bufferline = function()
	map("n", "<tab>", "<cmd>BufferLineCycleNext<cr>")
	map("n", "<s-tab>", "<cmd>BufferLineCyclePrev<cr>")
	map("n", "<c-tab>", "<cmd>BufferLineMoveNext<cr>")
	map("n", "<c-s-tab>", "<cmd>BufferLineMovePrev<cr>")
	map("n", "<leader>bp", "<cmd>BufferLinePick<cr>")
	map("n", "<leader>bc", "<cmd>Bdelete<cr>")
	map("n", "<leader>bC", "<cmd>Bdelete!<cr>")
	map("n", "<leader>bd", "<cmd>bdelete<cr>")
	map("n", "<leader>bD", "<cmd>bdelete!<cr>")

	map("n", "<leader>bse", "<cmd>BufferLineSortByExtension")
end

M.commentbox = function()
	map({ "n", "v" }, "gBc", "<cmd>lua require('comment-box').cbox()<cr>")
	map({ "n", "v" }, "gBl", "<cmd>lua require('comment-box').lbox()<cr>")
end

return M

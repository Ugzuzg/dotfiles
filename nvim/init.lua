require 'impatient'
require 'plugins'

local g = vim.g
local cmd = vim.cmd

-- Settings
local opt = vim.opt
opt.textwidth = 100
opt.tabstop = 2
opt.softtabstop = 0
opt.expandtab = true
opt.shiftwidth = 2
opt.number = true
opt.relativenumber = true

opt.list = true
opt.listchars:append "space:⋅"
opt.listchars:append "eol:↴"

-- Colorscheme
opt.termguicolors = true
cmd [[colorscheme zenburn]]

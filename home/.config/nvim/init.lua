vim.cmd [[set nocp tgc title confirm nosmd ls=3 nu rnu so=999 nocul]]
vim.cmd [[set ts=4 sw=4 et sta si cc=100 tw=100 sm hls is]]
vim.cmd [[inoremap # X#]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                transparent_background = true
            }
            vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        'ojroques/nvim-hardline',
        config = function()
            require("hardline").setup {}
        end,
    },
    {
        'xiyaowong/virtcolumn.nvim',
        init = function()
            vim.g.virtcolumn_char = '|'
            vim.g.virtcolumn_priority = 10
        end,
    },
}

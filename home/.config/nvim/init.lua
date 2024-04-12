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

require("lazy").setup({
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
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {
                tab = {
                    sync = {
                        open = true,
                        close = true,
                    },
                },
            }
        end,
    },
    {
        'ojroques/nvim-hardline',
        config = function()
          require("hardline").setup {}
        end,
    },
    {
        'xiyaowong/virtcolumn.nvim'
    },
--    {
--        'Valloric/YouCompleteMe',
--        build = 'python3 install.py --verbose --clang-completer --rust-completer'
--    },  -- why not building?
    {
        'kaarmu/typst.vim',
        ft = 'typst',
        lazy = false,
    }
}, {
    git = { 
        timeout = 3600, -- kill after AN HOUR instead of 2 minutes
    }
})

vim.g.virtcolumn_char = '▕' -- char to display the line
vim.g.virtcolumn_priority = 10 -- priority of extmark

--vim.cmd [[nmap <leader>yfw <Plug>(YCMFindSymbolInWorkspace)]]
--vim.cmd [[nmap <leader>yfd <Plug>(YCMFindSymbolInDocument)]]
--vim.cmd [[nmap <F3> :YcmCompleter Format<CR>]]
--vim.cmd [[nmap <F1> :tab YcmCompleter GetDoc<CR>]]
--vim.cmd [[nmap <C-t> :YcmCompleter GetType<CR>]]
--vim.cmd [[nmap <leader>gg :YcmCompleter GoTo<CR>]]
--vim.cmd [[nmap <leader>gu :YcmCompleter GoToReferences<CR>]]

--vim.cmd [[let g:ycm_language_server = [{
--    \   'name': 'ccls',
--    \   'cmdline': [ 'ccls' ],
--    \   'filetypes': [ 'c', 'cpp', 'cuda', 'objc', 'objcpp' ],
--    \   'project_root_files': [ '.ccls-root', 'compile-commands.json', 'build/compile-commands.json' ],
--    \}]
--]]

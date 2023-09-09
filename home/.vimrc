set nocp
language en_US.utf8
syntax on
color monokai
set tgc title confirm
set nosmd ls=2
set nu rnu
set ts=4 sw=4 et sta si cc=100
set sm hls is
inoremap # X#
set cot+=popup

let g:ycm_show_detailed_diag_in_popup = 1
let g:ycm_echo_current_diagnostic = 'virtual-text'
nmap <leader>yfw <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>yfd <Plug>(YCMFindSymbolInDocument)
nmap <F3> :YcmCompleter Format<CR>
nmap <F1> :tab YcmCompleter GetDoc<CR>
nmap <C-t> :YcmCompleter GetType<CR>
nmap <leader>gg :YcmCompleter GoTo<CR>
nmap <leader>gu :YcmCompleter GoToReferences<CR>

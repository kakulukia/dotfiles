" ===========================================================================
" File: move_line.vim
" Description: Move line(s) up/down with Alt+Up/Alt+Down
" Location: ~/.SpaceVim.d/plugin/move_line.vim

if exists('g:loaded_move_line_plugin')
  finish
endif
let g:loaded_move_line_plugin = 1

" Normal mode: move current line up/down
nnoremap <A-Up>   :m .-2<CR>==
nnoremap <A-Down> :m .+1<CR>==

" Visual mode: move selected block up/down
vnoremap <A-Up>   :m '<-2<CR>gv=gv
vnoremap <A-Down> :m '>+1<CR>gv=gv
" Insert mode: move current line up/down and return to insert mode
inoremap <A-Up>   <Esc>:m .-2<CR>==gi
inoremap <A-Down> <Esc>:m .+1<CR>==gi

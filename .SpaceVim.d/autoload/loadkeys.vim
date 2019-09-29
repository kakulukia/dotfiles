
" move lines with ALT + UP / DOWN
function! loadkeys#before() abort
  nnoremap <Esc>[1;9A :m-2<CR>
  nnoremap <Esc>[1;9B :m+<CR>
  inoremap <Esc>[1;9A <Esc>:m-2<CR>
  inoremap <Esc>[1;9B <Esc>:m+<CR>

  vnoremap <Esc>[1;9B :m '>+1<CR>gv=gv
  vnoremap <Esc>[1;9A :m '<-2<CR>gv=gv

  nnoremap <Esc>[1;3A :m-2<CR>
  nnoremap <Esc>[1;3B :m+<CR>
  inoremap <Esc>[1;3A <Esc>:m-2<CR>
  inoremap <Esc>[1;3B <Esc>:m+<CR>

  vnoremap <Esc>[1;3B :m '>+1<CR>gv=gv
  vnoremap <Esc>[1;3A :m '<-2<CR>gv=gv

endf

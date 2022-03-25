
" move lines with ALT + UP / DOWN
function! loadkeys#before() abort
  nnoremap <Esc>[1;9A :m-2<CR>
  nnoremap <Esc>[1;9B :m+<CR>
  inoremap <Esc>[1;9A <Esc>:m .+1<CR>==gi
  inoremap <Esc>[1;9B <Esc>:m .+1<CR>==gi

  vnoremap <Esc>[1;9B :m '>+1<CR>gv=gv
  vnoremap <Esc>[1;9A :m '<-2<CR>gv=gv

  " nnoremap <Esc>[1;3B :m+<CR>
  " nnoremap <Esc>[1;3A :m-2<CR>
  " inoremap <Esc>[1;3A <Esc>:m-2<CR>
  " inoremap <Esc>[1;3B <Esc>:m+<CR>
  " vnoremap <Esc>[1;3B :m '>+1<CR>gv=gv
  " vnoremap <Esc>[1;3A :m '<-2<CR>gv=gv

  " activate copy mode again
  set mouse=r
  set paste

  """"""""""""""
  " tmux fixes "
  """"""""""""""
  " Handle tmux $TERM quirks in vim
  " if $TERM =~ '^screen-256color'
  map <Esc>OH <Home>::
  map! <Esc>OH <Home>
  map <Esc>OF <End>
  map! <Esc>OF <End>

  map <ESC>[8    <End>
  map <ESC>[7    <Home>
  imap <ESC>[8    <End>  
  imap <ESC>[7    <Home>
  " endif

endf

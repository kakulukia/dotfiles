" ===========================================================================
" File: lastcursor.vim
" Description: Always restore cursor to last known position on file open
" Location: ~/.SpaceVim.d/plugin/lastcursor.vim

if exists('g:loaded_lastcursor_plugin')
  finish
endif

augroup lastcursor
  autocmd!
  " After reading a buffer, jump to the last known cursor position
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END
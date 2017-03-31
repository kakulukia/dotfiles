execute pathogen#infect()
syntax on
filetype plugin indent on
let g:airline_powerline_fonts = 1
set laststatus=2

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
" let g:airline_theme='murmur'

"set background=dark
"colorscheme solarized
set number

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction


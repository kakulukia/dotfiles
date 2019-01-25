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

" set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.

" Un-\Ident in Normal mode with Shift\Tab
nnoremap <Tab> >>
nnoremap <S-Tab> <<
" Un-\Ident in Insert mode with Shift\Tab
inoremap <Tab> <C-t>
inoremap <S-Tab> <C-d>
" Un-\Ident in Visual mode with Shift\Tab
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" this way undo works even after the file has been closed
set undofile
set undodir=~/.vim/undodir

let mapleader="\<space>"
nmap <leader>u :GundoToggle<CR>
let g:gundo_close_on_revert = 1


" Fast saving
nmap <leader>s :w!<cr>

" Save as super user
noremap <leader>S :w !sudo tee % > /dev/null<CR>

" Fast quit
nmap <leader>q :q<cr>


" Keep search matches in middle of window
nnoremap n nzzzv
nnoremap N Nzzzv
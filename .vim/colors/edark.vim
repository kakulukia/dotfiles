" Vim color file
" Maintainer: Yuki <paselan at Gmail.com>
" URL: https://github.com/pasela/edark.vim
" Last Change: Mon, 24 Mar 2014 10:49:08 +0900
" Version: 0.1.13
"
" A dark color scheme for GUI and 256 colors CUI, inspired by the rdark color scheme.
"
" Thanks to Radu Dineiu, the rdark author.
" (rdark http://www.vim.org/scripts/script.php?script_id=1732)
"
" Features:
"   - let g:edark_ime_cursor = 1 if you want to highlight the cursor when IME on
"   - let g:edark_insert_status_line = 1 if you want to highlight the status line when insert-mode
"
" Changelog:
"   0.1.13
"     - Always clear augroup when loaded
"     - Remove g:edark_current_line. Set 'cursorline' manually.
"
"   0.1.12
"     - ADD: 'SpellBad', 'SpellCap', 'SpellRare', 'SpellLocal'
"
"   0.1.11
"     - Refine CUI colors.
"
"   0.1.10
"     - Change the colors of htmlTagName and htmlSpecialTagName to orange from silver.
"
"   0.1.9
"     - Performance improved. Stopped dynamic calculation of CUI color palette
"       index and set it statically.
"     - t_Co=88 terminal is no longer supported.
"     - t_Co and gui_running are no longer checked.
"
"   0.1.8
"     - CHANGE 'diffFile', 'diffAdded', 'diffDeleted', 'diffChanged' color.
"
"   0.1.7
"     - ADD: 'CursorLineNr' color.
"
"   0.1.6
"     - CHANGE: 'NonText' color.
"     - CHANGE: 'DiffAdd', 'DiffDelete', 'DiffChange', 'DiffText' color.
"
"   0.1.5
"     - CHANGE: 'IncSearch' color.
"
"   0.1.4
"     - FIX: 'Visual' color.
"
"   0.1.3
"     - FIX: 'Search' hilight definition was wrong value.
"
"   0.1.2
"     - FIX: all options were ignored
"     - IMPROVE: support 88 and 256 CUI
"
"   0.1
"     - initial version
"
" License: MIT License {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

set background=dark

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "edark"

" Current Line
highlight CursorLine guibg=#333333 ctermbg=236
highlight CursorLineNr guifg=#babdb6 ctermfg=250 gui=none cterm=none

" Default Colors
highlight Normal guifg=#babdb6 ctermfg=250 guibg=#1e2426 ctermbg=234
"highlight NonText guifg=#2c3032 ctermfg=235 guibg=#2c3032 ctermbg=235
highlight NonText guifg=#505456 ctermfg=239 guibg=#2c3032 ctermbg=235
highlight Cursor guibg=#babdb6 ctermbg=250
highlight ICursor guibg=#babdb6 ctermbg=250

" IME Cursor
if exists('g:edark_ime_cursor') && g:edark_ime_cursor == 1
  if has('multi_byte_ime') || has('xim')
    highlight CursorIM guifg=NONE ctermfg=NONE guibg=#8ae234 ctermbg=112
  endif
endif

" Search
highlight Search guifg=#2e3436 ctermfg=236 guibg=#fcaf3e ctermbg=214
highlight IncSearch guifg=#ff8060 ctermfg=209 guibg=#2e3436 ctermbg=236

" Spell
highlight SpellBad gui=undercurl guisp=#ff0000 ctermfg=196 ctermbg=bg cterm=underline
highlight SpellCap gui=undercurl guisp=#005fff ctermfg=27 ctermbg=bg cterm=underline
highlight SpellRare gui=undercurl guisp=#af00af ctermfg=127 ctermbg=bg cterm=underline
highlight SpellLocal gui=undercurl guisp=#00afd7 ctermfg=38 ctermbg=bg cterm=underline

" Window Elements
highlight StatusLine guifg=#2e3436 ctermfg=236 guibg=#babdb6 ctermbg=250 gui=none cterm=none
highlight StatusLineNC guifg=#2e3436 ctermfg=236 guibg=#888a85 ctermbg=102 gui=none cterm=none
highlight VertSplit guifg=#555753 ctermfg=240 guibg=#888a85 ctermbg=102 gui=none cterm=none
highlight Visual guibg=#333333 ctermbg=236
highlight MoreMsg guifg=#729fcf ctermfg=68
highlight Question guifg=#8ae234 ctermfg=112 gui=none cterm=none
highlight WildMenu guifg=#eeeeec ctermfg=255 guibg=#0e1416 ctermbg=234
highlight LineNr guifg=#3f4b4d ctermfg=238 guibg=#000000 ctermbg=16
highlight SignColumn guibg=#1e2426 ctermbg=234

" Insert mode status line
augroup EDarkInsertHook
  autocmd!
augroup END
if exists('g:edark_insert_status_line') && g:edark_insert_status_line == 1
  autocmd EDarkInsertHook InsertEnter * exec "highlight StatusLine guifg=#2e3436 ctermfg=236 guibg=#ccdc90 ctermbg=186"
  autocmd EDarkInsertHook InsertLeave * exec "highlight StatusLine guifg=#2e3436 ctermfg=236 guibg=#babdb6 ctermbg=250 gui=none"
endif

" Pmenu
highlight Pmenu guifg=#eeeeec ctermfg=255 guibg=#2e3436 ctermbg=236
highlight PmenuSel guifg=#1e2426 ctermfg=234 guibg=#ffffff ctermbg=231
highlight PmenuSbar guibg=#555753 ctermbg=240
highlight PmenuThumb guifg=#ffffff ctermfg=231

" QuickFix
highlight qfLineNr guifg=#8ae234 ctermfg=112

" Diff
" highlight DiffDelete guifg=#2e3436 ctermfg=236 guibg=#0e1416 ctermbg=234
" highlight DiffAdd guibg=#1f2b2d ctermbg=235
" highlight DiffChange guibg=#2e3436 ctermbg=236
" highlight DiffText guibg=#000000 ctermbg=16 gui=none cterm=none
highlight DiffDelete guifg=#afafaf ctermfg=248 guibg=#4e3437 ctermbg=52 gui=none cterm=none
highlight DiffAdd guifg=#afafaf ctermfg=248 guibg=#30493b ctermbg=22 gui=none cterm=none
highlight DiffChange guifg=#afafaf ctermfg=248 guibg=#54573b ctermbg=58 gui=none cterm=none
highlight DiffText guifg=#cfcfcf ctermfg=252 guibg=#727750 ctermbg=101 gui=none cterm=none

" Folds
highlight Folded guifg=#d3d7cf ctermfg=188 guibg=#204a87 ctermbg=25
highlight FoldColumn guifg=#3465a4 ctermfg=25 guibg=#000000 ctermbg=16

" Specials
highlight Title guifg=#fcaf3e ctermfg=214
highlight Todo guifg=#fcaf3e ctermfg=214 guibg=bg ctermbg=bg
highlight SpecialKey guifg=#ad7fa8 ctermfg=139

" Tabs
highlight TabLine guifg=#888a85 ctermfg=102 guibg=#0a1012 ctermbg=233
highlight TabLineFill guifg=#0a1012 ctermfg=233
highlight TabLineSel guifg=#eeeeec ctermfg=255 guibg=#555753 ctermbg=240 gui=none cterm=none

" Matches
highlight MatchParen guifg=#2e3436 ctermfg=236 guibg=#906090 ctermbg=96

" Tree
highlight Directory guifg=#ffffff ctermfg=231

" Syntax
highlight Comment guifg=#809090 ctermfg=102
highlight Constant guifg=#8ae234 ctermfg=112
highlight Number guifg=#8ae234 ctermfg=112
highlight Statement guifg=#729fcf ctermfg=68 gui=none cterm=none
highlight Identifier guifg=#ffffff ctermfg=231
highlight PreProc guifg=#fcaf3e ctermfg=214
highlight Function guifg=#fcaf3e ctermfg=214
highlight Type guifg=#e3e7df ctermfg=254 gui=none cterm=none
highlight Keyword guifg=#eeeeec ctermfg=255
highlight Special guifg=#888a85 ctermfg=102
highlight Error guifg=#eeeeec ctermfg=255 guibg=#cc0000 ctermbg=160

" PHP
highlight phpRegionDelimiter guifg=#ad7fa8 ctermfg=139
highlight phpPropertySelector guifg=#888a85 ctermfg=102
highlight phpPropertySelectorInString guifg=#888a85 ctermfg=102
highlight phpOperator guifg=#888a85 ctermfg=102
highlight phpArrayPair guifg=#888a85 ctermfg=102
highlight phpAssignByRef guifg=#888a85 ctermfg=102
highlight phpRelation guifg=#888a85 ctermfg=102
highlight phpMemberSelector guifg=#888a85 ctermfg=102
highlight phpUnknownSelector guifg=#888a85 ctermfg=102
highlight phpVarSelector guifg=#babdb6 ctermfg=250
highlight phpSemicolon guifg=#888a85 ctermfg=102 gui=none cterm=none
highlight phpFunctions guifg=#d3d7cf ctermfg=188
highlight phpParent guifg=#888a85 ctermfg=102

" JavaScript
highlight javaScriptBraces guifg=#888a85 ctermfg=102
highlight javaScriptOperator guifg=#888a85 ctermfg=102

" HTML
highlight htmlTag guifg=#888a85 ctermfg=102
highlight htmlEndTag guifg=#888a85 ctermfg=102
" highlight htmlTagName guifg=#babdb6 ctermfg=250
" highlight htmlSpecialTagName guifg=#babdb6 ctermfg=250
highlight htmlTagName guifg=#fcaf3e ctermfg=214
highlight htmlSpecialTagName guifg=#fcaf3e ctermfg=214
highlight htmlArg guifg=#d3d7cf ctermfg=188
highlight htmlTitle guifg=#8ae234 ctermfg=112 gui=none cterm=none
highlight link htmlH1 htmlTitle
highlight link htmlH2 htmlH1
highlight link htmlH3 htmlH1
highlight link htmlH4 htmlH1
highlight link htmlH5 htmlH1
highlight link htmlH6 htmlH1

" XML
highlight link xmlTag htmlTag
highlight link xmlEndTag htmlEndTag
highlight link xmlAttrib htmlArg

" CSS
highlight cssSelectorOp guifg=#eeeeec ctermfg=255
highlight link cssSelectorOp2 cssSelectorOp
highlight cssUIProp guifg=#d3d7cf ctermfg=188
highlight link cssPagingProp cssUIProp
highlight link cssGeneratedContentProp cssUIProp
highlight link cssRenderProp cssUIProp
highlight link cssBoxProp cssUIProp
highlight link cssTextProp cssUIProp
highlight link cssColorProp cssUIProp
highlight link cssFontProp cssUIProp
highlight cssPseudoClassId guifg=#eeeeec ctermfg=255
highlight cssBraces guifg=#888a85 ctermfg=102
highlight cssIdentifier guifg=#fcaf3e ctermfg=214
highlight cssTagName guifg=#fcaf3e ctermfg=214
highlight link cssInclude Function
highlight link cssCommonAttr Constant
highlight link cssUIAttr Constant
highlight link cssTableAttr Constant
highlight link cssPagingAttr Constant
highlight link cssGeneratedContentAttr Constant
highlight link cssAuralAttr Constant
highlight link cssRenderAttr Constant
highlight link cssBoxAttr Constant
highlight link cssTextAttr Constant
highlight link cssColorAttr Constant
highlight link cssFontAttr Constant

" diff
highlight link diffFile Title
highlight link diffAdded DiffAdd
highlight link diffRemoved DiffDelete
highlight link diffChanged DiffChange

" vim: set fdm=marker:
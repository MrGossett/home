" =============================================================================
" File:        mrg256.vim
" Description: Vim color scheme file
" Maintainer:  Tim Gossett
" =============================================================================
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "mrg256"

hi  Normal        ctermfg=252   ctermbg=16
hi  Cursor        ctermfg=bg    ctermbg=fg
hi  CursorLine    ctermfg=NONE  ctermbg=17 cterm=NONE
hi  CursorLineNr  ctermfg=240   ctermbg=16
hi  LineNr        ctermfg=236   ctermbg=16
hi  FoldColumn    ctermfg=248   ctermbg=16
hi  Folded        ctermfg=252   ctermbg=16
hi  Statement     ctermfg=155   ctermbg=16  cterm=bold
hi  PreProc       ctermfg=155   ctermbg=16  cterm=bold
hi  String        ctermfg=41    ctermbg=16
hi  Comment       ctermfg=240   ctermbg=16
hi  Constant      ctermfg=45    ctermbg=16
hi  Type          ctermfg=39    ctermbg=16  cterm=bold
hi  Function      ctermfg=60    ctermbg=16
hi  Identifier    ctermfg=115   ctermbg=16
hi  Special       ctermfg=115   ctermbg=16
hi  MatchParen    ctermfg=16    ctermbg=39
hi  Search        ctermfg=15    ctermbg=67
hi  Visual        ctermfg=15    ctermbg=67
hi  NonText       ctermfg=240   ctermbg=16
hi  Directory     ctermfg=20    ctermbg=16  cterm=bold
hi  Title         ctermfg=20    ctermbg=16  cterm=bold
hi  Todo          ctermfg=16    ctermbg=54  cterm=bold
hi  Pmenu         ctermfg=16    ctermbg=67
hi  PmenuSel      ctermfg=67    ctermbg=16
hi  OverLength    ctermfg=124   ctermfg=52

" red-on-red for anything past col 80
match OverLength /\%81v.\+/


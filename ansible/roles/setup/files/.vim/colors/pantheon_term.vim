"SOME COLOR CHANGING TO DEFAULT THEME
"   Most of these settings are set to work best with Elementary OS terminal
"   default color theme

hi cType ctermfg=106

" sets the comment color to blue
hi Comment term=bold ctermfg=4 guifg=#406090  

" set color of line numbers
hi LineNr term=underline ctermfg=3 guifg=Red3

" set color of statements ex: while, if, return...
hi Statement cterm=none ctermfg=yellow

" set Pair matching color
" hi MatchParen ctermfg=226 ctermbg=none
hi MatchParen term=bold ctermfg=76 ctermbg=none

" set colorcolumn color
hi ColorColumn ctermbg=106

" Vertual line hilight color
hi Visual ctermfg=70 ctermbg=238 guifg=#52b000 guibg=#585858

" set error color for syntastic (highlight color is linked to Search)
" line warning
" line error
hi Search term=reverse ctermfg=none ctermbg=237
hi SyntasticError term=standout ctermfg=15 ctermbg=1 guifg=White guibg=Red 
hi SyntasticWarning term=standout ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow

" sets supertab to menu to dark color scheme
hi Pmenu        cterm=none ctermfg=White     ctermbg=Black
hi PmenuSel     cterm=none ctermfg=Black     ctermbg=DarkGreen
hi PmenuSbar    cterm=none ctermfg=none      ctermbg=Green
hi PmenuThumb   cterm=none ctermfg=DarkGreen ctermbg=DarkGreen

" sets the comment color to blue
hi Comment term=bold ctermfg=12 guifg=#406090  

" set color of line numbers
hi LineNr term=underline ctermfg=130 guifg=Red3

" set color of statements ex: while, if, return...
hi Statement cterm=none ctermfg=178

" colors such of items such as 'none' 'bold'
hi PreProc ctermfg=14

hi Type term=bold ctermfg=34 ctermbg=none  

" C programing colors
hi cInclude ctermfg=6
hi cDefine ctermfg=6
hi cComment ctermfg=12
hi cType ctermfg=34
hi cStructure ctermfg=178
hi cSpecial ctermfg=6


" set Pair matching color
" hi MatchParen ctermfg=226 ctermbg=none
hi MatchParen term=bold ctermfg=76 ctermbg=none

" set colorcolumn color
hi ColorColumn ctermbg=Green

" string and constant color
hi Constant term=none ctermfg=196


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


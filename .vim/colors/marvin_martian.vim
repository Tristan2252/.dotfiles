"SOME COLOR CHANGING TO DEFAULT THEME
"   Most of these settings are set to work best with Elementary OS terminal
"   default color theme

"##### Markdown #####
autocmd FileType markdown call MDhighlight()
autocmd FileType tex,latex call Texhighlight()
function MDhighlight()
	hi markdownH1 ctermfg=34 cterm=underline,bold
	hi markdownH2 ctermfg=34 cterm=underline,bold
	hi markdownH3 ctermfg=34 cterm=underline
	hi markdownH4 ctermfg=34
	hi markdownH5 ctermfg=34
	hi markdownH6 ctermfg=34
	hi markdownHeadingDelimiter ctermfg=106
	hi markdownItalic ctermfg=4
	hi markdownCodeDelimiter ctermfg=208
	hi markdownCode ctermfg=208 ctermbg=0
	hi markdownListMarker ctermfg=196
	hi markdownOrderedListMarker ctermfg=196
    hi markdownBold ctermfg=220
	" Spell Warnings dont look good in markdown
	hi SpellLocal cterm=underline ctermfg=none ctermbg=none
	hi SpellCap cterm=underline ctermfg=none ctermbg=none
endfunction

function Texhighlight()
    hi Special ctermfg=34
    hi texDelimiter ctermfg=220
    hi texBeginEnd ctermfg=34
    hi texBeginEndName ctermfg=208
    hi texMath ctermfg=none
    hi texSpecialChar ctermfg=239
endfunction

" ##### C language #####
hi cType ctermfg=34
hi cStructure ctermfg=208
hi cSpecial ctermfg=208
hi cString ctermfg=34
hi Type ctermfg=34

"##### General #####
hi SpellBad cterm=underline ctermfg=none ctermbg=none
hi SpellLocal cterm=underline ctermfg=4 ctermbg=none
hi SpellCap cterm=underline ctermfg=4 ctermbg=none

hi WildMenu term=bold,standout ctermfg=106 ctermbg=0
hi StatusLine term=bold,reverse ctermfg=0 gui=bold,reverse
hi NonText ctermfg=239
hi SpecialKey ctermfg=239

" sets the comment color to blue
hi Comment term=bold ctermfg=4 guifg=#406090  

" set color of line numbers
hi LineNr term=underline ctermfg=3 guifg=Red3

" set color of statements ex: while, if, return...
hi Statement cterm=none ctermfg=208
hi PreProc ctermfg=196
hi Number ctermfg=220
hi String ctermfg=34

" set Pair matching color
" hi MatchParen ctermfg=226 ctermbg=none
hi MatchParen term=bold ctermfg=76 ctermbg=none

" set colorcolumn color
hi ColorColumn ctermbg=11

" Vertual line hilight color
hi Visual ctermfg=70 ctermbg=238 guifg=#52b000 guibg=#585858

" set error color for syntastic (highlight color is linked to Search)
" line warning
" line error
hi Search term=reverse ctermfg=none ctermbg=237
hi SyntasticError term=underline cterm=underline ctermfg=196 ctermbg=none
hi SyntasticWarning term=underline cterm=underline ctermfg=220 ctermbg=none
hi Todo term=standout,bold ctermfg=15 ctermbg=196

" sets supertab to menu to dark color scheme
hi Pmenu        cterm=none ctermfg=White     ctermbg=Black
hi PmenuSel     cterm=none ctermfg=Black     ctermbg=DarkGreen
hi PmenuSbar    cterm=none ctermfg=none      ctermbg=Green
hi PmenuThumb   cterm=none ctermfg=DarkGreen ctermbg=DarkGreen


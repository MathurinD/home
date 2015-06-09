" local syntax file - set colors on a per-machine basis:
" :colorscheme perso
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Mathurin Dorel
" Last Change:	2014 December 5

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "perso"
" Some colors do not work for cterm
hi Normal		guifg=white ctermfg=white guibg=black
hi String       guifg=13 gui=bold ctermfg=13 cterm=bold
hi Comment		guifg=grey gui=bold ctermfg=grey cterm=bold
hi Statement	guifg=yellow gui=bold ctermfg=yellow cterm=bold
hi Type			guifg=green	gui=bold ctermfg=green cterm=bold
"seagreen
hi PreProc		guifg=cyan gui=bold ctermfg=blue cterm=bold
" Pink2
hi Special      guifg=red gui=bold  ctermfg=red cterm=bold
hi Operator		guifg=orange gui=bold ctermfg=green cterm=bold
hi Number       guifg=red gui=bold ctermfg=red cterm=bold
hi ErrorMsg		guifg=White	guibg=Red gui=bold ctermfg=White ctermbg=Red cterm=bold
hi WarningMsg	guifg=Black	guibg=Red
hi Todo			guifg=Black	guibg=orange cterm=reverse ctermbg=white ctermfg=red
hi Done         guifg=Black guibg=Green cterm=reverse ctermbg=black ctermfg=green

hi clear Visual
hi Visual		term=reverse cterm=reverse gui=reverse

hi NonText		guifg=yellow guibg=#303030
hi constant		guifg=cyan	gui=bold
hi identifier	guifg=cyan	gui=NONE
hi Error		guibg=Red
hi Cursor		guibg=#60a060 guifg=#00ff00
hi Search		guibg=darkgray guifg=black gui=bold 
hi IncSearch	gui=NONE guibg=steelblue
hi LineNr		guifg=darkgrey
hi title		guifg=darkgrey
hi ShowMarksHL ctermfg=cyan ctermbg=lightblue cterm=bold guifg=yellow guibg=black  gui=bold
hi StatusLineNC	gui=NONE guifg=lightblue guibg=darkblue
hi StatusLine	gui=bold	guifg=cyan	guibg=blue
hi label		guifg=gold2

hi DiffChange   guibg=darkgreen
hi DiffText		guibg=olivedrab
hi DiffAdd		guibg=slateblue
hi DiffDelete   guibg=coral
hi Folded		guibg=gray30
hi FoldColumn	guibg=gray30 guifg=white
hi cIf0			guifg=gray
hi diffOnly	guifg=red gui=bold


"Autorise les options spécifiques à VIM
set nocompatible

"Initialisation de pathogen, un gestionnaire de plugin vim
filetype off
call pathogen#infect()
call pathogen#helptags()

" Status line, use fugitive to get branch info when in a git repo
set statusline=%<%#DONE#%f%Y\ %#white#%h%m%r%{fugitive#statusline()}%=%B\ %(%l/%L,%c\ (%P)%)

" Save the folding state when leaving and restores when reopening
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

augroup filetype_sets
    autocmd!
    " Gives two filetypes to php and html files to be able to use html and php snippets together
    autocmd BufRead,BufNewFile *.php set ft=php.html
    autocmd BufRead,BufNewFile *.html set ft=html.php
    " Pandoc markdown files
    autocmd BufNewFile,BufRead *.pan set filetype=pandoc
    " Kappa files
    autocmd BufRead,BufNewFile *.ka set filetype=perl
    " TODOs and NOTES files
    autocmd BufRead,BufNewFile TODO set filetype=TODO
    autocmd BufRead,BufNewFile NOTES set filetype=TODO
    " Read zip-like files as zip
    au BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar set filetype=zip
    " OrgMode pour vim
    au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
    au BufEnter *.org call org#SetOrgFileType()
    "au BufEnter *.org set wrapmargin=80
augroup END

"Active ou désactive la sauvegarde automatique (fichier terminés par un ~)
set backup

"Redirige les backup dans ~/.vim/backup pour ne plus les avoir dans le même fichier que l'original
if filewritable(expand("~/.vim/backup")) == 2
	set backupdir=$HOME/.vim/backup
else
"Si c'est un système compatible Unix, on crée le répertoire et on l'utilise
	if has("unix") || has ("win32unix")
		call system("mkdir $HOME/.vim/backup -p")
		set backupdir=$HOME/.vim/backup
	endif
endif

"Fixe le nombre de retours en arrière possibles
set undolevels=150

"On recharge automatiquement les fichiers modifiés en dehors de vim
set autoread

"Lorsqu'on ferme une parenthèse, vim fait clignoter l'ouverture pour montrer où elle se trouve
"set showmatch
"set matchtime=2

"Afficher la commande en cours d'exécution en bas à gauche
set showcmd

"Choix de l'indentation
" Preserver l'indentation lors d'un retour à la ligne
set autoindent
" Modifie l'indentation en fonction de la syntaxe ({[:)
set smartindent
"Indentation automatique lors d'un programme en C
"set cindent
"Continue l'indentation précédente
set indentexpr=GetMyIndent()

"Active l'autoindentation des languages de programmation (~/.vim/ftplugin/)
filetype indent plugin on

"Nombre d'espace par indentation
"Avec >> et <<
setlocal shiftwidth=4
" Transform tabs into spaces (retab to transform tab into space)
setlocal expandtab
" Number of spaces per tab
setlocal tabstop=4
" spaces deleted by <BS> and added by <CR>
setlocal softtabstop=4
" Utilise shiftwidth à la place de tabstop en début de ligne 
set smarttab

"Active la coloration syntaxique
"Exécute $VIMRUNTIME/syntax/syntax.vim
syntax enable
"Utilise la coloration syntaxique par défaut
"syntax on

"Forcer une coloration syntaxique particulière
"set syntax=python

"Souligne les tabulation
"syntax match Tab /\t/
"hi Tab gui=underline guifg=blue ctermbg=blue
"Met en surbrillance la ligne actuelle
"syntax match ligne "ligne"
"hi ligne ctermbg=blue guibg=blue


"Active la numérotation des lignes
set number
"Active les informations de positions dans le fichier
set ruler

"Modification de la coloration, voir /usr/share/vim/vim73/colors/README

"Change le fond ce qui influe sur le premier plan (light par défaut)
set background=dark

"Change le schéma de coloration 
"Voir le fichier /usr/share/vim/vim73/colors pour les options
colorscheme perso

"Rend la recherche indépendante de la casse ou indépendante s'il n'y a pas de majuscule dans la recherche
"set ignorecase
set smartcase

"Permet de cacher des morceaux de code (manual, syntax, indent)
set foldmethod=indent
set foldlevel=20

"Complétion des commandes avec C-n
set wildmenu
"Comportement similaire à bash
set wildmode=longest,list:longest:full

"Autorise l'usage de la souris
set mouse=a

"Afficher le mode en cours
set showmode

"Abbréviations
ia #i #include

"Retour à la ligne automatique après x caractères
"set textwidth=100
"set wrapmargin=100

" Change the leader caracter, because \ is not convenient
let mapleader=","
let maplocalleader=","
" Use double , instead of one (which is leader)
noremap ,, ,

" Permet de changer de ligne lorsque le texte est enroulé sans <EOL>
noremap j gj
noremap k gk
noremap <Up> gk
noremap <Down> gj
" Saute entre lignes ayant la même indentation
nn <C-j> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
nn <C-k> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>

" Permet de commenter et décommenter facilement en R et LaTeX
noremap <F2> :s/^\([^#]\)/#\1/<CR>:noh<CR>
noremap <F3> :s/^#//<CR>:noh<CR>
noremap <F4> :s/^\([^%]\)/%\1/<CR>:noh<CR>
noremap <F5> :s/^%//<CR>:noh<CR>
function SwitchComment(symbol)
    if getline(".") =~ "^[^" . a:symbol . "]"
        exec "s/^\\([^" . a:symbol . "]\\)/" . a:symbol . "\\1/"
    else
        exec "s/" . a:symbol . "//"
    end
endfunction

onoremap p i(
onoremap b i{
onoremap c i[

" Provides g command in visual mode which searches the selection in google
" Bugs the block selection
"vmap g :<C-U>!firefox "http://www.google.fr/search?hl=fr&q=<cword>&btnG=Recherche+Google&meta=" &gt;& /dev/null<CR><CR>

" French orthographic correction
noremap ,C :w<CR>:!aspell -c %<CR>:e %<CR>

" Use Space for folding
nnoremap <Space> zA
nnoremap <Tab> za
" In insert mode C-u will uppercase the world, usefull for constants
inoremap <C-u> <Esc>bveU<Esc>i

" Surround a word or a selection with brackets or chevrons
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>< viw<esc>a<<esc>hbi><esc>lel
nnoremap <leader>> viw<esc>a<<esc>hbi><esc>lel
vnoremap <leader>" <Esc>`><esc>a"<esc>`<i"<esc>lel
vnoremap <leader>' <Esc>`><esc>a'<esc>`<i"<esc>lel
vnoremap <leader>< <Esc>`><esc>a<<esc>`<i"<esc>lel
vnoremap <leader>> <Esc>`><esc>a<<esc>`<i"<esc>lel

" Move the cursor in the windows faster with hjkl
nnoremap J L
nnoremap K H
nnoremap H 0
nnoremap L $
" Keep J and K functions
noremap <Leader>j J
noremap <Leader>k K

" Use jk to escape in insert mode
inoremap jk <Esc>

"Coloration de toutes les occurrences lors d'une recherche
set hlsearch

"Permet d'afficher sur plusieurs lignes les lignes qui dépassent de l'écran en coupant au niveau des
"espaces
set wrap
set linebreak

"Met en surbrillance la ligne courante
set cursorline
"highlight CursorLine ctermbg=white

"Envoyer le curseur sur la ligne suivante ou précédente après usage des flèches en extrémité de ligne
" h et l non recommandés, vérifier qu'il n'y a pas de problèmes
set whichwrap=<,>,[,],h,l

"Laisser des lignes visibles au-dessus ou en dessous du curseur quand on atteint les limites de l'écran
set scrolloff=3

"Donne les droits d'exécution si le fichier commence par #!
function ModeChange()
	if getline(1) =~ "#!"
		silent !chmod a+x <afile>
	endif
endfunction

au BufWritePost * call ModeChange()

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"autocmd BufReadPost *
"\ if line("'\"") > 0 && line("'\"") <= line("$") |
"\   exe "normal g`\"" |
"\ endif

" Accordion plugin, vsplit does not generate more that 2 windows, the others
" are tabbed
au BufRead,BufNewFile * Accordion 2 " A utiliser à chaque session

" Options for Vim sessions
set sessionoptions=options,globals,sesdir,winsize,winpos,resize,buffers,blank,tabpages,folds
" Use spaces instead of tabs
set expandtab

" Provides informations for Git commits in Vim
function Git()
endfunction


"""""""""
" Lines added by the Vim-R-plugin command :RpluginConfig (2014-déc.-04 13:01):
filetype indent on
" Use Ctrl+Space to do omnicompletion:
if has("gui_running")
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif

" Force Vim to use 256 colors if running in a capable terminal emulator:
if &term =~ "xterm" || &term =~ "256" || $DISPLAY != "" || $HAS_256_COLORS == "yes"
    set t_Co=256
endif
"""""""""
" 2 '_' give '<-'
let vimrplugin_assign=2

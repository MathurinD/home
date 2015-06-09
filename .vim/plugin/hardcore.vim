" hardcore.vim      : Hardcore mode for the brave people trying to master
"                   : the proper vi/Vim finger habits. Temporarily disables
"		    : some of the common "evil" input methods in Vim, such as
"		    : cursor keys, mouse movement, Home, End, Insert, Delete,
"		    : PgUp, and PgDown keys, as well as "evil" GUI elements
"		    : in gVim, such as the menu bar and the toolbar.
" Version           : 1.2
" Maintainer        : Michael Kamensky <stavdev@mail.ru>
" Last Modified     : 09/09/2013
" License           : This script is released under the Vim License.
" ============================================================================
" Usage             : By default, the hardcore mode is mapped to <Leader>hm in
"		    : normal mode. If you get tired or lost in hardcore mode,
"		    : it can be disabled with the same command. 
"                   :
"                   : While in hardcore mode, the mouse is disabled, the menu
"                   : and the toolbar (in gvim) are disabled, the cursor keys
"                   : and Home/End/Insert/Delete/PgUp/PgDown keys are disabled
"		    : in normal, insert, visual, and command modes.

if exists("g:loaded_HardcoreMode")
    finish
endif

let g:loaded_HardcoreMode = 1
let s:hardcoreMode = 0
let s:hardcoreCommandMode = 1
let s:mouseMode = &mouse
let s:guiOpts = &go

" Default hardcore mode mappings. Change here if necessary.
nnoremap <Leader>hm :call <SID>HM_ToggleHardcore()<CR>
nnoremap <Leader>hc :call <SID>HM_ToggleHardcoreCommandMode()<CR>

function! s:HM_Message(msg)
    echohl ModeMsg
    echo a:msg
    echohl None
endfunction

function! s:HM_ToggleHardcore()
    if s:hardcoreMode == 0
        call <SID>HM_EnableHardcore()
    else
        call <SID>HM_DisableHardcore()
    endif
endfunction

function! s:HM_ToggleHardcoreCommandMode()
    if s:hardcoreCommandMode == 1
	let s:hardcoreCommandMode = 0
	if s:hardcoreMode == 1
	    cunmap <Up>
	    cunmap <Down>
	    cunmap <Left>
	    cunmap <Right>
	    cunmap <Insert>
	    cunmap <Delete>
	    cunmap <PageUp>
	    cunmap <PageDown>
	    cunmap <Home>
	    cunmap <End>
	endif
	call <SID>HM_Message("[HARDCORE MODE]: Hardcore command mode OFF")
    else
	let s:hardcoreCommandMode = 1
	if s:hardcoreMode == 1
	    cnoremap <Up> <Nop>
	    cnoremap <Down> <Nop>
	    cnoremap <Left> <Nop>
	    cnoremap <Right> <Nop>
	    cnoremap <Insert> <Nop>
	    cnoremap <Delete> <Nop>
	    cnoremap <PageUp> <Nop>
	    cnoremap <PageDown> <Nop>
	    cnoremap <Home> <Nop>
	    cnoremap <End> <Nop>
	endif
	call <SID>HM_Message("[HARDCORE MODE]: Hardcore command mode ON")
    endif
endfunction

function! s:HM_EnableHardcore()
    if s:hardcoreMode == 1
	call <SID>HM_Message("Hardcore mode is already on!")
	return
    endif
    let s:hardcoreMode = 1
    let s:mouseMode = &mouse
    let s:guiOpts = &go
    set go-=m
    set go-=T
    set mouse=
    nnoremap <Up> :call <SID>HM_Message("[HARDCORE MODE]: Key disabled, use k instead!")<CR>
    nnoremap <Down> :call <SID>HM_Message("[HARDCORE MODE]: Key disabled, use j instead!")<CR>
    nnoremap <Left> :call <SID>HM_Message("[HARDCORE MODE]: Key disabled, use h instead!")<CR>
    nnoremap <Right> :call <SID>HM_Message("[HARDCORE MODE]: Key disabled, use l instead!")<CR>
    nnoremap <Insert> :call <SID>HM_Message("[HARDCORE MODE]: Key disabled, use i instead!")<CR>
    nnoremap <Delete> :call <SID>HM_Message("[HARDCORE MODE]: Key disabled, use x instead!")<CR>
    nnoremap <PageUp> :call <SID>HM_Message("[HARDCORE MODE]: Key disabled, use C-b instead!")<CR>
    nnoremap <PageDown> :call <SID>HM_Message("[HARDCORE MODE]: Key disabled, use C-f instead!")<CR>
    nnoremap <Home> :call <SID>HM_Message("[HARDCORE MODE]: Key disabled, use 0 instead!")<CR>
    nnoremap <End> :call <SID>HM_Message("[HARDCORE MODE]: Key disabled, use $ instead!")<CR>
    inoremap <Up> <Nop>
    inoremap <Down> <Nop>
    inoremap <Left> <Nop>
    inoremap <Right> <Nop>
    inoremap <Insert> <Nop>
    inoremap <Delete> <Nop>
    inoremap <PageUp> <Nop>
    inoremap <PageDown> <Nop>
    inoremap <Home> <Nop>
    inoremap <End> <Nop>
    vnoremap <Up> <Nop>
    vnoremap <Down> <Nop>
    vnoremap <Left> <Nop>
    vnoremap <Right> <Nop>
    vnoremap <Insert> <Nop>
    vnoremap <Delete> <Nop>
    vnoremap <PageUp> <Nop>
    vnoremap <PageDown> <Nop>
    vnoremap <Home> <Nop>
    vnoremap <End> <Nop>
    if s:hardcoreCommandMode == 1
	cnoremap <Up> <Nop>
	cnoremap <Down> <Nop>
	cnoremap <Left> <Nop>
	cnoremap <Right> <Nop>
	cnoremap <Insert> <Nop>
	cnoremap <Delete> <Nop>
	cnoremap <PageUp> <Nop>
	cnoremap <PageDown> <Nop>
	cnoremap <Home> <Nop>
	cnoremap <End> <Nop>
    endif
    call <SID>HM_Message("--HARDCORE MODE ON--")
endfunction

function! s:HM_DisableHardcore()
    if s:hardcoreMode == 0
	call <SID>HM_Message("Hardcore mode is currently off!")
	return
    endif
    let s:hardcoreMode = 0
    let &mouse = s:mouseMode
    let &go = s:guiOpts
    nunmap <Up>
    nunmap <Down>
    nunmap <Left>
    nunmap <Right>
    nunmap <Insert>
    nunmap <Delete>
    nunmap <PageUp>
    nunmap <PageDown>
    nunmap <Home>
    nunmap <End>
    iunmap <Up>
    iunmap <Down>
    iunmap <Left>
    iunmap <Right>
    iunmap <Insert>
    iunmap <Delete>
    iunmap <PageUp>
    iunmap <PageDown>
    iunmap <Home>
    iunmap <End>
    vunmap <Up>
    vunmap <Down>
    vunmap <Left>
    vunmap <Right>
    vunmap <Insert>
    vunmap <Delete>
    vunmap <PageUp>
    vunmap <PageDown>
    vunmap <Home>
    vunmap <End>
    if s:hardcoreCommandMode == 1
	cunmap <Up>
	cunmap <Down>
	cunmap <Left>
	cunmap <Right>
	cunmap <Insert>
	cunmap <Delete>
	cunmap <PageUp>
	cunmap <PageDown>
	cunmap <Home>
	cunmap <End>
    endif
    call <SID>HM_Message("--HARDCORE MODE OFF--")
endfunction

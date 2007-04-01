" ReloadScript.vim: Reload a VIM script. 
"
"   Re-sources a VIM script. The script may use a multiple inclusion guard
"   variable g:loaded_<scriptname>. If you specify the scriptname (without .vim
"   extension), the script must reside in $VIMRUNTIME/plugin/<scriptname>.vim.
"   Otherwise, the current buffer is used. 
"
"* USAGE:
"   :ReloadScript		Re-sources the current buffer. 
"   :ReloadScript <scriptname>	Re-sources the passed plugin script. 
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
" REVISION	DATE		REMARKS 
"	0.01	14-Dec-2006	file creation

" Avoid installing twice or when in compatible mode
if exists("g:loaded_ReloadScript") || (v:version < 700)
    finish
endif
let g:loaded_ReloadScript = 1

function! s:RemoveInclusionGuard( scriptName )
    let l:scriptInclusionGuard = 'g:loaded_' . a:scriptName
    if ! exists( l:scriptInclusionGuard )
	"let l:scriptInclusionGuard = 'g:loaded_' . tolower(a:scriptName)
    endif
    if exists( l:scriptInclusionGuard )
	execute 'unlet ' . l:scriptInclusionGuard
    else
	echohl WarningMsg
	echomsg 'Warning: No inclusion guard variable found.'
	echohl None
    endif
endfunction

function! s:ReloadScript(...)
    if a:0 == 0
	" Note: We do not check whether the current buffer contains a VIM
	" script; :source will tell. 
	let l:scriptName = expand('%:t:r')
	let l:scriptFilespec = expand('%')
	let l:sourceCommand = 'source'
    else
	" Strip off file path and extension, just to be sure. Users should not
	" pass that, anyway. 
	let l:scriptName = fnamemodify( a:1, ':t:r' )
	let l:scriptFilespec = 'plugin/' . l:scriptName . '.vim'
	let l:sourceCommand = 'runtime'
	" Note: the :runtime command does not complain if no script was found. 
    endif

    call s:RemoveInclusionGuard( l:scriptName )

    execute l:sourceCommand . ' ' . l:scriptFilespec
    echomsg 'Reloaded "' . l:scriptFilespec . '"'
endfunction

"command! -nargs=1 -complete=file ReloadScript if exists("g:loaded_<args>") | unlet g:loaded_<args> | endif | runtime plugin/<args>.vim
command! -nargs=? -complete=file ReloadScript call <SID>ReloadScript(<f-args>)


" ReloadScript.vim: Reload a VIM script. 
"
" Re-sources a VIM plugin. The script must reside in
" $VIMRUNTIME/plugin/<scriptname>.vim and may use an multiple inclusion guard
" variable g:loaded_<scriptname>. 
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
" REVISION	DATE		REMARKS 
"	0.01	14-Dec-2006	file creation

" Avoid installing twice or when in compatible mode
if exists("g:loaded_ReloadScript") || (v:version < 700)
    finish
endif
let g:loaded_ReloadScript = 1

command! -nargs=1 -complete=file ReloadScript if exists("g:loaded_<args>") | unlet g:loaded_<args> | endif | runtime plugin/<args>.vim


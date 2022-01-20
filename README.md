RELOAD SCRIPT
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

Re-sources a Vim script. The script may use a multiple inclusion guard
variable g:loaded\_{scriptname} (with {scriptname} having either the same case
as specified or all lowercase.)
If you specify the bare scriptname (without .vim extension), the script must
reside in plugin/{scriptname}.vim somewhere on 'runtimepath'. Otherwise, the
passed filespec is interpreted as the file system location of a Vim script and
sourced as-is. If you execute :ReloadScript without passing a scriptname,
the current buffer is re-sourced.

### RELATED WORKS

- scriptease.vim ([vimscript #4394](http://www.vim.org/scripts/script.php?script_id=4394)) has a :Runtime command that unlets any
  include guards first

USAGE
------------------------------------------------------------------------------

    ReloadScript                            Re-sources the current buffer.
    ReloadScript {scriptname}               Re-sources the passed plugin script.
    ReloadScript {path/to/script.vim}       Re-sources the passed file.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-ReloadScript
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim ReloadScript*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.

LIMITATIONS
------------------------------------------------------------------------------

- The script cannot reload itself :-)

### ASSUMPTIONS

Not every script supports reloading. There may be error messages like
"function already exists". To support reloading, the script should use the
bang (!) variants of :function! and :command!, which will automatically
override already existing elements.

Ensure that the script uses a multiple inclusion guard variable that conforms
to the conventions mentioned above. The :ReloadScript command will issue a
warning if it cannot find the inclusion guard variable.

### IDEAS

- For compiler, ftplugin, indent and syntax scripts, find all buffers that
  have the script sourced and re-source in that buffer. Currently, one must
  manually :e! these buffers.

### CONTRIBUTING

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-ReloadScript/issues or email (address below).

HISTORY
------------------------------------------------------------------------------

##### 1.21    27-Aug-2012
- Avoid &lt;f-args&gt; because of its unescaping behavior.
- Also no global inclusion guard for ftdetect scripts.

##### 1.20    07-Jan-2011
- BUG: Avoiding "E471: Argument required" error on empty buffer name.
- ENH: Explicitly checking for the existence of the file, as we don't want to
  put the :source command inside try...catch (it would stop showing all
  resulting errors and show only the first), and because :runtime doesn't
  complain at all.
- Added separate help file and packaging the plugin as a vimball.

##### 1.10    25-Jul-2008
- Combined missing inclusion guard warning with reload message to avoid the "Hit
ENTER" prompt. No missing inclusion guard warning for scripts that do not need
one (e.g. after-directory, autoload, ftplugin, indent, syntax, ...)

##### 1.10    28-Feb-2008
- A scriptname argument with path and/or extension is sourced as-is. This allows
a third usage: :ReloadScript {path/to/script.vim}

##### 1.00    22-May-2007
- First published version.

##### 0.01    14-Dec-2006
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2007-2022 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;

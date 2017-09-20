""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  

    " cscope/vim key mappings

    " The following maps all invoke one of the following cscope search types:
    " 's'   symbol: find all references to the token under cursor
    " 'g'   global: find global definition(s) of the token under cursor
    " 'c'   calls:  find all calls to the function name under cursor
    " 't'   text:   find all instances of the text under cursor
    " 'e'   egrep:  egrep search for the word under cursor
    " 'f'   file:   open the filename under cursor
    " 'i'   includes: find files that include the filename under cursor
    " 'd'   called: find functions that function under cursor calls

    " The above maps can be called in three different ways.
    " 1) <Leader> + map:     open search result
    " 2) <Leader> + h + map: open search result in horizontal split
    " 3) <Leader> + v + map: open search result in vertical split
    " 4) <Leader> + t + map: open search result in new tab
 
    " You can use CTRL-T to go back to where you were before the search.  

    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).

    nnoremap <Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap <Leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <Leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>


    " Horizontal split, with search result displayed in the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nnoremap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    nnoremap <Leader>hs :scs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>hg :scs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>hc :scs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>ht :scs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>he :scs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>hf :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap <Leader>hi :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <Leader>hd :scs find d <C-R>=expand("<cword>")<CR><CR>


    " Vertical split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nnoremap <Leader>vs :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>vg :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>vc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>vt :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>ve :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <Leader>vf :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap <Leader>vi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <Leader>vd :vert scs find d <C-R>=expand("<cword>")<CR><CR>

    " open search result in New Tab
    function! CscopeFindNewTab(word, type)
        exe 'tabnew'
        exe 'cs find '.a:type.' '.a:word
    endfunction

    nnoremap <Leader>ts :call CscopeFindNewTab('<C-R><C-W>', 's')<CR>
    nnoremap <Leader>tg :call CscopeFindNewTab('<C-R><C-W>', 'g')<CR>
    nnoremap <Leader>tc :call CscopeFindNewTab('<C-R><C-W>', 'c')<CR>
    nnoremap <Leader>tt :call CscopeFindNewTab('<C-R><C-W>', 't')<CR>
    nnoremap <Leader>te :call CscopeFindNewTab('<C-R><C-W>', 'e')<CR>
    nnoremap <Leader>td :call CscopeFindNewTab('<C-R><C-W>', 'd')<CR>

endif



" Only do this when not done yet for this buffer
" (Also avoids to run the same plugin twice)
if exists("g:did_VimTmuxTerminal")
 finish
endif
let g:did_VimTmuxTerminal = 1

" Source common functions
execute 'source ' . expand("<sfile>:h:h") . '/vim-tmux/vim-tmux.vim'

"######################################################################
" Mappings
"######################################################################
" Spawn Tmux
if system("type bpython > /dev/null && echo '1'")
   nnoremap <Localleader>rf :call Spawn_tmux("bpython")<CR>
else
   nnoremap <Localleader>rf :call Spawn_tmux("python")<CR>
endif

" Kill Tmux
nnoremap <Localleader>rq :call Kill_tmux(g:tmux_session)<CR>

" Send lines
nnoremap <Localleader>l yy:call Send_tmux(g:tmux_session, @", "py")<CR>
nnoremap <Localleader>d yy:call Send_tmux(g:tmux_session, @", "py")<CR>j

" Send lines trimming white space from left
nnoremap <Localleader>k yy:call Send_tmux(g:tmux_session, substitute(@", "^\\s*", "", "g"), "py")<CR>
nnoremap <Localleader>s yy:call Send_tmux(g:tmux_session, substitute(@", "^\\s*", "", "g"), "py")<CR>j

" Send paragraphs
nnoremap <Localleader>pe {y}:call Send_tmux(g:tmux_session, @", "py")<CR>``
nnoremap <Localleader>pa }{y}:call Send_tmux(g:tmux_session, @", "py")<CR>}}{

" Send everything
nnoremap <Localleader>aa :%y<CR>:call Send_tmux(g:tmux_session, @", "py")<CR>

" Send Selections
vnoremap <Localleader>se y:call Send_tmux(g:tmux_session, @" . "\n", "py")<CR>`<
vnoremap <Localleader>sa y:call Send_tmux(g:tmux_session, @" . "\n", "py")<CR>`>

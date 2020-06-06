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
nnoremap <Localleader>rf :call Spawn_tmux("python")<CR>
" Kill Tmux
nnoremap <Localleader>rq :call Kill_tmux(g:tmux_session)<CR>

" Send lines
nnoremap <Localleader>l yy:call Send_tmux(g:tmux_session, @")<CR>
nnoremap <Localleader>d yyj:call Send_tmux(g:tmux_session, @")<CR>

" Send paragraphs
nnoremap <Localleader>pe {jy}``:call Send_tmux(g:tmux_session, @")<CR>
nnoremap <Localleader>pa }{jy}}:call Send_tmux(g:tmux_session, @")<CR>

" Send Selections
vnoremap <Localleader>se y`<:call Send_tmux(g:tmux_session, @")<CR>
vnoremap <Localleader>sa y`>:call Send_tmux(g:tmux_session, @")<CR>

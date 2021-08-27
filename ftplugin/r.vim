" Only do this when not done yet for this buffer
" (Also avoids to run the same plugin twice)
if exists("g:did_VimTmuxTerminal")
 finish
endif
let g:did_VimTmuxTerminal = 1

" Source common functions
execute 'source ' . expand("<sfile>:h:h") . '/vim-tmux/vim-tmux.vim'

"######################################################################
" Function to initialize R
"######################################################################
function! Init_r(init_file)
   if exists("g:vimtmux_r_intepreter")
      call Spawn_tmux(g:vimtmux_r_intepreter)
   else
      call Spawn_tmux("R")
   endif
   sleep
   call Send_tmux(g:tmux_session, "source('" . a:init_file . "')\n", "r")
   redraw!
endfunction



"######################################################################
" Mappings
"######################################################################
" Spawn Tmux
let __init_file_r = expand("<sfile>:h:h") . '/vim-tmux/init_r.R'
nnoremap <Localleader>rf :call Init_r(__init_file_r)<CR>

" Kill Tmux
nnoremap <Localleader>rq :call Kill_tmux(g:tmux_session)<CR>

" Send lines
nnoremap <Localleader>l yy:call Send_tmux(g:tmux_session, @", "r")<CR>
nnoremap <Localleader>d yy:call Send_tmux(g:tmux_session, @", "r")<CR>j

" Send paragraphs
nnoremap <Localleader>pe {y}:call Send_tmux_wrapped(g:tmux_session, @", "r")<CR>``
nnoremap <Localleader>pa }{y}:call Send_tmux_wrapped(g:tmux_session, @", "r")<CR>}}{

" Send everything
nnoremap <Localleader>aa :%y<CR>:call Send_tmux_wrapped(g:tmux_session, @", "r")<CR>

" Send Selections
vnoremap <Localleader>se y:call Send_tmux(g:tmux_session, @" . "\n", "r")<CR>`<
vnoremap <Localleader>sa y:call Send_tmux(g:tmux_session, @" . "\n", "r")<CR>`>
" Send Selection Hiding the code
vnoremap <Localleader>sh y:call Send_tmux_wrapped(g:tmux_session, @" . "\n", "r")<CR>`<
vnoremap <Localleader>sH y:call Send_tmux_wrapped(g:tmux_session, @" . "\n", "r")<CR>`>

" Remap = to <-
inoremap ò <Space><-<Space>

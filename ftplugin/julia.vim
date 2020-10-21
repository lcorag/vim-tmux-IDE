" Only do this when not done yet for this buffer
" (Also avoids to run the same plugin twice)
if exists("g:did_VimTmuxTerminal")
 finish
endif
let g:did_VimTmuxTerminal = 1

" Source common functions
execute 'source ' . expand("<sfile>:h:h") . '/vim-tmux/vim-tmux.vim'



"######################################################################
" Function to initialize Python
"######################################################################
function! Init_jl(init_file)
   if system("type julia > /dev/null && echo '1'")
      call Spawn_tmux("julia")
   else
      call Spawn_tmux("julia")
   endif
   sleep
   call Send_tmux(g:tmux_session, "include(\"". a:init_file . "\")\n", "jl")
   redraw!
endfunction


"######################################################################
" Mappings
"######################################################################
" Spawn Tmux
let __init_file_jl = expand("<sfile>:h:h") . '/vim-tmux/init_jl.jl'
nnoremap <Localleader>rf :call Init_jl(__init_file_jl)<CR>
" Kill Tmux
nnoremap <Localleader>rq :call Kill_tmux(g:tmux_session)<CR>

" Send lines
nnoremap <Localleader>l yy:call Send_tmux(g:tmux_session, @", "jl")<CR>
nnoremap <Localleader>d yy:call Send_tmux(g:tmux_session, @", "jl")<CR>j

" Send paragraphs
nnoremap <Localleader>pe {y}:call Send_tmux(g:tmux_session, @", "jl")<CR>``
nnoremap <Localleader>pa }{y}:call Send_tmux(g:tmux_session, @", "jl")<CR>}}{

" Send everything
nnoremap <Localleader>aa :%y<CR>:call Send_tmux(g:tmux_session, @", "jl")<CR>

" Send Selections
vnoremap <Localleader>se y:call Send_tmux(g:tmux_session, @" . "\n", "jl")<CR>`<
vnoremap <Localleader>sa y:call Send_tmux(g:tmux_session, @" . "\n", "jl")<CR>`>
" Send Selection Hiding the code
vnoremap <Localleader>sh y:call Send_tmux_wrapped(g:tmux_session, @" . "\n", "jl")<CR>`<
vnoremap <Localleader>sH y:call Send_tmux_wrapped(g:tmux_session, @" . "\n", "jl")<CR>`>

" Define an help function
nnoremap K yiw :call Send_tmux(g:tmux_session, "? " . @" . "\n", "jl")<CR>

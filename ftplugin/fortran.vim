" Only do this when not done yet for this buffer
" (Also avoids to run the same plugin twice)
if exists("g:did_VimTmuxTerminal")
 finish
endif
let g:did_VimTmuxTerminal = 1

" Source common functions
execute 'source ' . expand("<sfile>:h:h") . '/vim-tmux/vim-tmux.vim'

"######################################################################
" Functions and utils for fortran
"######################################################################
function! Fort_exec()
   " Alias for calling executable
   let executable = expand("%:p:h") . "/a.out" . " \n"
   silent call Send_tmux(g:tmux_session, executable, "")
endfunction

"######################################################################
" Mappings
"######################################################################
" Spawn Tmux
" for fortran we only need to use a terminal (i.e. Spawn_tmux no arguments)"
nnoremap <Localleader>rf :call Spawn_tmux("")<CR>

" Kill Tmux
nnoremap <Localleader>rq :call Kill_tmux()<CR>

" CURRENT FILE
" Compile and execute
nnoremap <Localleader>aa :call Compile_tmux(g:tmux_session, "default", "default", "gfortran")<CR>:call Fort_exec()<CR>
" Compile
nnoremap <Localleader>cc :call Compile_tmux(g:tmux_session, "default", "default", "gfortran")<CR>
" Execute
nnoremap <Localleader>ee :call Fort_exec()<CR>

" Compile and execute with plplot
nnoremap <Localleader>pp :call Compile_tmux(g:tmux_session, "default", "-g -Wall -O2 -mtune=native $(pkg-config --cflags --libs plplot-fortran)")<CR>:call Fort_exec()<CR>


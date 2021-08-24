" Only do this when not done yet for this buffer
" (Also avoids to run the same plugin twice)
if exists("g:did_VimTmuxTerminal")
 finish
endif
let g:did_VimTmuxTerminal = 1

" Source common functions
execute 'source ' . expand("<sfile>:h:h") . '/vim-tmux/vim-tmux.vim'

"######################################################################
" Functions and utils for go
"######################################################################
function! go_exec()
   " Alias for calling executable
   let execute = "go run " . expand("%:p") . " \n"
   silent call Send_tmux(g:tmux_session, executable, "")
endfunction

function! go_build()
   " Alias for calling executable
   let execute = "go build " . expand("%:p") . " \n"
   silent call Send_tmux(g:tmux_session, executable, "")
endfunction

"######################################################################
" Mappings
"######################################################################
" Spawn Tmux
" for fortran we only need to use a terminal (i.e. Spawn_tmux no arguments)"
nnoremap <Localleader>rf :call Spawn_tmux("")<CR>

" Kill Tmux
nnoremap <Localleader>rq :call Kill_tmux(g:tmux_session)<CR>

" CURRENT FILE
" Compile and execute
nnoremap <Localleader>aa :call go_exec()<CR>
" Compile
nnoremap <Localleader>cc :call go_build<CR>

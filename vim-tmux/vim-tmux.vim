" Initialize g:tmux_session
let g:tmux_session = "notset"

" Create a function to call tmux terminal
function! Spawn_tmux(filetype)
   silent let isthere = system("tmux list-sessions 2&> /dev/null | grep " . g:tmux_session . " | wc -l")
   if isthere
      echom "Tmux session already enstablished.\nSession: " . g:tmux_session
   else
      " create a random number for session naming
      silent let randnum = system("echo -n $RANDOM")
      " Spawn tmux session
      silent execute '!' . g:TERMINAL . ' ' . $SHELL . ' -c "tmux new-session -s ' . randnum . ' ' . a:filetype . '" & disown'
      let g:tmux_session = randnum
      augroup vim_tmux
         au!
         autocmd VimLeavePre * execute "!tmux kill-session -t " . g:tmux_session
      augroup END
   endif
endfunction

"Kill Tmux
function! Kill_tmux(tmux_session)
   if (g:tmux_session == 'notset')
      echo "No Tmux Session to kill (start one with <Localleader>rf)"
   else
      silent execute '! tmux kill-session -t ' . a:tmux_session 
      let g:tmux_session = "notset"
   endif
endfunction
      
" Functions to send command
function! Send_tmux(tmux_session, code)
   if (g:tmux_session == 'notset')
      echo "No Tmux Session linked: start one with <Localleader>rf"
   else
      let code = split(a:code, "\n")
      for line in code
         silent execute '! tmux send-keys -t ' . a:tmux_session . ' "' . line . '" Enter'
      endfor
      redraw!
   endif
endfunction

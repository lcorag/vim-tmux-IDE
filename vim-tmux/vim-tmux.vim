" Initialize g:tmux_session
let g:tmux_session = "notset"

if exists(g:TERMINAL)
    let g:TERMINAL="alacritty"
endif

# define whether to use quoted or unquoted command to terminal
let s:quoted_terminal=["termite"]
let s:unquoted_terminal=["alacritty", "urxvt"]

if count(s:quoted_terminal, g:TERMINAL) >= 1
    let s:terminal_com_quote=1
else
    let s:terminal_com_quote=0
endif

" Create a function to call tmux terminal
function! Spawn_tmux(filetype)
   silent let isthere = system("tmux list-sessions 2&> /dev/null | grep " . g:tmux_session . " | wc -l")
   if isthere
      echom "Tmux session already established.\nSession: " . g:tmux_session
   else
      " create a random number for session naming
      silent let randnum = system("echo -n $RANDOM")
      " Spawn tmux session
      if s:terminal_com_quote
          silent execute '!' . g:TERMINAL . ' -e "tmux new-session -s ' . randnum . ' ' . a:filetype . '" & disown'
      else
          silent execute '!' . g:TERMINAL . ' -e tmux new-session -s ' . randnum . ' ' . a:filetype . ' & disown'
      endif
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

" Prepare Code to send
" Used to write code buffer
function! CodePrepare(code, lang)
   silent execute "redir! > /tmp/tmux_vim_buffer | echon a:code | redir END"
   if (a:lang == 'r')
      silent call CodeClean_r()
   endif
endfunction
      
" Code Specific Manipulation
function! CodeClean_r()
   " Trim white spaces (not needed by R)
   silent execute '! sed -i "s/^\s*//g;s/\s*$//g" /tmp/tmux_vim_buffer'
endfunction

" Functions to send command
function! Send_tmux(tmux_session, code, lang)
   if (g:tmux_session == 'notset')
      echo "No Tmux Session linked: start one with <Localleader>rf"
   else
      call CodePrepare(a:code, a:lang)
      silent execute "! tmux load-buffer /tmp/tmux_vim_buffer && tmux paste-buffer -t  " . a:tmux_session . " && tmux delete-buffer"
      " silent execute '! rm /tmp/tmux_vim_buffer'
      redraw!
   endif
endfunction

" Send command wrapped (language specific, using function lu_vim_tmux_wrapper)
function! Send_tmux_wrapped(tmux_session, code, lang)
   if (g:tmux_session == 'notset')
      echo "No Tmux Session linked: start one with <Localleader>rf"
   else
      call CodePrepare(a:code, a:lang)
      silent execute "! tmux send-keys -t " . a:tmux_session . " 'lu_vim_tmux_wrapper()' Enter"
      redraw!
   endif
endfunction

" Compile current file (for fortran)
function! Compile_tmux(tmux_session, fname, flags)
   if (g:tmux_session == 'notset')
      echo "No Tmux Session linked: start one with <Localleader>rf"
   else
      if (a:flags=="default")
         let flags = "-g -Wall -O2 -mtune=native"
      else
         let flags = a:flags
      endif
      if (a:fname=="default")
         let fname = expand("%:p")
      else
         let fname = a:fname
      endif
      let instruct = "gfortran " . flags . " " . fname
      silent execute "! tmux send-keys -t " . a:tmux_session . ' "' . instruct . '" Enter'
      redraw!
   endif
endfunction

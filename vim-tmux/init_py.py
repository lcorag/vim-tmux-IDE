def lu_vim_tmux_wrapper(sourcefile="/dev/shm/tmux_vim_buffer"):
    exec(open(sourcefile).read(), globals())


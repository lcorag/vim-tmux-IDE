def vim_tmux_wrapper__(sourcefile="/dev/shm/tmux_vim_buffer"):
    exec(open(sourcefile).read(), globals())

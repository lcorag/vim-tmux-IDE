def lu_vim_tmux_wrapper(sourcefile="/tmp/tmux_vim_buffer"):
    exec(open(sourcefile).read(), globals())


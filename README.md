# vim-tmux-IDE
This vim-plugin aims at providing a unified, **minimalistic** solution to use vim as an IDE for several programming languages.
This is achieved by leveraging *tmux*.

The plug-in workflow allows to:

1. Spawn a tmux-terminal linked to the current vim-window. For interpreted languages (e.g. Python, R), the relative interpreter is also invoked.
2. Sending lines/chunks/all code to the linked terminal for evaluation/execution.
3. Quitting the tmux-terminal upon quitting vim.

## Installation

Of course, you need to have tmux installed.
E.g. on Arch:
```
yay -S tmux
```

For vim 8+, simply clone this directory under the ".vim/pack/pack_plugins/start/" directory.

Or, using vim-plug, put this into your .vimrc
```
Plug 'luco00/vim-tmux-IDE'
```

## List of Commands
Currently, all the commands are defined in the "/ftplugin/*.vim" files.
You can change mappings there should you like.
(I will improve on this :) )

|Mapping | Command|
|--------|-----------|
| \<localleader\>rf| spawn tmux terminal|
| \<localleader\>rq| kill tmux terminal|
| \<localleader\>aa| execute full script (or) build and execute script|
| \<localleader\>cc| compile script|
| \<localleader\>ee| execute compiled script|
| \<localleader\>l| send line |
| \<localleader\>k| send line removing trailing blanks |
| \<localleader\>d| send line and go down one line |
| \<localleader\>s| send line removing trailing blanks and go down one line |
| \<localleader\>pe| send paragraph |
| \<localleader\>pa| send paragraph and go to next paragraph |
| \<localleader\>se| send visual selection |
| \<localleader\>sa| send visual selection and go to next paragraph |

## Configuration
Currently, you can configure the interpreter used for python and R.
Put this in your .vimrc:
```
let g:vimtmux_python_interpreter="ipython"
let g:vimtmux_r_intepreter="radian"
```

## Why Tmux?
Tmux makes it easy to create a named session, that can be linked exlusively with the current vim window.
Also, sending code to Tmux is extremely easy.
In addition, Tmux-sessions are peristent so that if you accidentally closed the tmux-terminal (without killing the session), you can easily recover the session by opening a new terminal and typing:
```
tmux attach-session -t nameofthesession
```
## What the plug-in is not
This plug-in is only intended to provide a simple, consistent way to execute scripted code on the fly, while you are editing it.
Thus, it is not intended to provide:
* autocompletion (I personally use the base vim feature for this)
* syntax highlighting (use dedicated plug-ins as needed)
* linting (I personally use and suggest [ALE](https://github.com/dense-analysis/ale) for this)

---
### Additional notes and further devs

* The plug-in is in early stages, but provides a solid experience (tested over the last three years) in Julia, R and Python;

* The followings are on the to do list:
    - [ ] Add more options for easier configuration;
    - [ ] Add vim-documentation;
    - [ ] Add more languages.

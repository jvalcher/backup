
# tmux manpage notes

- See `~/.tmux.conf` for custom commands et al.



## Terms

session   - single collection of pseudo terminals (see pty(4))
window    - occupies entire screen
pane      - separate terminals within window



## Misc

- Terminal multiplexer, i.e. numerous terminals per screen
- Can be detached from screen and later reattached
- Different tmux instances can attach to same session
- Sessions are displayed on screen by clients
- All sessions are managed by a single server
- Servers and each client are separate processes that communicate through a socket in `/tmp`
- Server socket in `TMUX_TMPDIR` if set or `/tmp` at `tmux-<uid>/default`
- Global command queue not attached to client is used on startup for config file
- Each client has a command queue
- Shell commands parsed by shell, tmux or tmux config commands parsed by tmux



## Shell commands

```bash

tmux attach

tmux -V           # print version
tmux -T 256       # start in 256 color mode
tmux -C           # start in control mode
tmux -CC          # start in control mode, disable echo
tmux -c "cmd"     # send shell command
tmux -D           # do not start server as daemon, turn off exit-empty option
tmux -f config    # start with specified config file
tmux -L sock      # set socket name in default path
tmux -S sock      # set socket name with absolute path
tmux -T features  # set terminal features (see terminal-features)
tmux -v           # verbose logging
tmux command      # command(s), new-session assumed if none provided

# command sequence
tmux neww \; splitw
tmux neww\; splitw
tmux neww ';' splitw
tmux 'neww;' splitw


```



## Prefix + command

```bash

?       # list all key bindings
!       # break current pane out of window
#       # list all paste buffers
:       # enter tmux command
d       # detach current client
i       # display current window info
q       # display pane indexes
r       # redraw/load pane
t       # display time

```



## Scripting

- \' and \" cannot span lines, {} can
- Outside quotes and inside \", environment variables replaced with value

```tmux

# command sequence
neww ; splitw
# or
neww ; \
  splitw

# home directory expansion
~       # current use
~bob    # specific user

# escape characters
\e    - escape
\r    - carriage return
\n    - newline
\t    - tab
\<c>  - other chacters replaced with themselves

# braces
if-shell true {
  display -p 'brace-dollar-foo: }$foo'
}
bind x if-shell true {
  if-shell true {
    display "true!"
  }
}

# environment variables
HOME=/home/user
%hidden MYVAR=42  # not passed to tmux processes environments
                  # TODO: GLOBAL AND SESSION ENVIRONMENT

#
# conditionals
#
if-shell true split-window

%if #{==:#{host},myhost} set -g status-style bg=red %endif

%if "#{==:#{host},myhost}"
  set -g status-style bg=red
%elif "#{==:#{host}, myotherhost}"
  set -g status-style bg=green
%else
  set -g status-style bg=blue
%endif

```

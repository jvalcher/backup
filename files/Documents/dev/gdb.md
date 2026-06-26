
# GDB


## Terminal

- Start quietly         - `gdb -q ...`
- Start in TUI layout   - `gdb -tui ...`
- Load config           - `gdb -x ./.gdb.config ...`
- Run binary with args  - `gdb --args a.out < input.txt`

## TUI

- Switch windows        - `ctrl-x o`
- Enter/exit tui mode   - `ctrl-x a`

## CLI

- Help                                - `help breakpoints`
- Run program with argument(s)        - `run 12`
- Previous, next commands             - `ctrl + p,n`
- Jump to file with my_func()         - `list my_func`
- Suspend program                     - `ctrl-c`
- List lines above and below line 5   - `list 5`
- List function lines                 - `list main`
- List lines after previous list      - `list`  or  `list +`
- List lines before previous list     - `list -`

- Set variable value                  - `set x = 12`

- Formatted print (include `\n`)      - `printf "%s\n", p.name`
- Print variable                      - `print in_scope_var`
- Print macro                         - `p MY_MACRO`
- Print function result               - `p my_func(12)`
- Print current memory location       - `p/x $pc`
- Print dynamic array value           - `p *arr@25`
- Print type array value              - `p (int [25]) *x`
- Print hex value                     - `p/x num`
- Print character value               - `p/c ch`
- Print string value                  - `p/s buf`
- Print float value                   - `p/f num`

- Print current local variables       - `info locals`
- Print function arguments            - `info args`
- Print disassembly code              - `disassemble`
- Print stack frames                  - `backtrace`
- Print stack frames with values      - `bt full`
- Print parent stack frame            - `frame 1`
- Print processes                     - `info inferiors`
- Print threads info                  - `info threads`
- Switch to specific thread           - `thread 3`
- Get current thread info             - `bt`

- Watch variable change               - `watch v`
- Watch variable specific value       - `watch (v > 10)`
- Set conditional watchpoint          - `watch (i | j > 12) && i > 24 && strlen(name) > 6`

- Print value on every pause          - `disp *tmp`
- Display item(s) info                - `info dis`
- Disable display item                - `disable disp 1`
- Enable display item                 - `enable disp 1`
- Delete display item                 - `undisp 1`

- Continue past loop                  - `until`
- Continue to particular line         - `until 10`
- Continue to initial function call   - `finish`

- Insert conditional break            - `break 30 if x==5`
- Insert conditional break            - `break test.c:34 if strlen(str) == 0 && i < 0`
- List breakpoints                    - `info break`
- Save current breakpoints            - `save break .gdb_break`
- Set temporary breakpoint            - `tbreak 10`
- Enable breakpoint once              - `enable once 3`
- Temp disable all breakpoint(s)      - `disable`
- Temp enable all breakpoint(s)       - `enable`
- Temp enable specific breakpoints    - `enable 1 5`
- Set thread breakpoint               - `break 15 thread 3`
- Set conditional thread breakpoint   - `break 23 thread 2 if x == y`
- Delete all breakpoints              - `delete`
- Delete breakpoint by id             - `del break 2`
- Delete breakpoint by line number    - `clear 30`
- Delete breakpoint(s) by function    - `clear main`


## Tmux debug layout

- Left pane: `./debug`
```
#!/bin/sh
gdb -q -tui -x ./.gdb_config a.out
```
- Right pane
  - Top: output
```
$ tcs

# Which runs...

$ echo 'tty $(tty)' | tee >(xclip -selection clipboard)
$ clear
$ sleep 99999
```
  - Bottom left: `.gdb_config`
```
tty /dev/pts/5
del
break 72
run < ../input_spaces.txt
undisp
source ./.gdb_disp
disp
```
  - Bottom right: `.gdb_disp`
```
disp buf
disp buf[i]
disp i
```



## Misc techniques


- Print value from previous print statement
```
(gdb) p tmp->left
$1 = 5
(gdb) p *$1
```

- Assign value to variable
```
(gdb) set $q = p
(gdb) p *$q
```

- Iterate through array values
```
(gdb) set $i = 0
(gdb) p arr[$i++]
1
(gdb)
2
```

- Get program memory layout, permissions, ...
```
(gdb) info inferiors

$ cat /proc/<pid>/maps
```

- Handle segfault
  - Via core dump file
```
$ gdb a.out core -tui
(gdb) backtrace
(gdb) frame 0
(gdb) print var1
...
```
  - From inside gdb
```
(gdb) run
......
(gdb) bt
(gdb) frame 0
(gdb) bt full
```

- Ignore seg faults         - `handle SIGSEGV nostop noprint`

- Find infinite loop, i.e. verify approximate location with multiple suspend+continues
```
run
ctrl-c
continue
ctrl-c
continue
...
```

- Send program output to different terminal, debug curses program
```
$ tty
$ sleep 99999
(gdb) tty /dev/pts/8
```


## Macro commands

- Print all current macros            - `show user`

### CLI macros

- Define CLI macro function
```
(gdb) define print_and_go
  >printf $arg0, $arg1
  >continue
  >end
(gdb) print_and go "num == %d\n" num
```

### Config file macros

- Define config file function (e.g. `~/.gdbinit`)
```
define pr_node
  p tmp->val
  if (tmp->left != 0)
    p tmp->left->val
  else
    printf "%s\n", "none"
  call my_func()
end
```

- Print C++ class values
```
(gdb) ptype node
type = class node {
  public:
    static node *root;
    int val;
    node *left;
    node *right;
    node(int);
    static void insert(int);
}
```

## To-research

- Hardware-assisted breakpoint              - `hbreak`
- Temporary hardware-assisted breakpoint    - `thbreak`
- Grep-style regex breakpoint               - `rbreak`

`break main if !my_func(i)`
  - Returns int if no debugging symbols in library, unless...
    ```
    (gdb) set *p = (double (*) (double)) cos
    (gdb) ptype $p
    type = double (*)()
    (gdb) p cos(3.14159265)
    $2 = 14368
    (gdb) p $p(3.14159265)
    $4 = -1
    ```


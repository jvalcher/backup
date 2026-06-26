
###############
# GDB options #
###############

set startup-quietly on
set confirm off
set max-value-size unlimited
set auto-load safe-path /
set disassembly-flavor intel
set debuginfod enabled off
set print array on
set print pretty on
set style enabled on



################
# GDB commands #
################

# Source config, display files
define sc
	source ./.gdbc
	echo "Sourced ./.gdbc"
end
define sd
	source ./.gdbd
	echo "Sourced ./.gdbd"
end

# TUI layouts
define asm
	layout asm
end
define src
	layout src
end
define regs
	layout regs
end
define split
	layout split
end



################
# Run commands #
################

# Flush stdout
define flush_stdout
    call ((void(*)(int))fflush)(0)
end

# Run + refresh
define rr
    run
    refresh
end

# Set delimiter when repeating commands with display values
define print_delim
    printf "\n---- <%s> -----\n", $arg0
end
define print_delim_end
    printf "\n---- Next line: %d -----\n\n", __LINE__
end

define dd
	print_delim "display"
	display
	print_delim_end
	flush_stdout
    refresh
end
define nn
	print_delim "next"
	next
	print_delim_end
	flush_stdout
    refresh
end
define ss
	print_delim "step"
	step
	print_delim_end
	flush_stdout
    refresh
end
define cc
	print_delim "continue"
	continue
	print_delim_end
	flush_stdout
    refresh
end

# Set follow fork mode
define ffc
    set follow-fork-mode child
end
define ffp
    set follow-fork-mode parent
end

# Print linked list
define llist
  set var $n = $arg0->head
  while $n
    printf "%d ", $n->data
    set var $n = $n->next
  end
end




#################
# Ignore errors #
#################

python
import gdb

class IgnoreErrors(gdb.Command):
    def __init__(self):
        super().__init__("ie", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        try:
            gdb.execute(arg)
        except gdb.error:
            pass

IgnoreErrors()
end

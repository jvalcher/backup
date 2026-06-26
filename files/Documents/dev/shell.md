
##########
# System #
##########

```sh

lsb_release -a    # OS info
uname -a          # System info
uname -r          # Kernel only
arch              # Machine architecture

echo $XDG_SESSION_TYPE                      # display server
xdpyinfo | awk '/dimensions/ {print $2}'    # screen resolution

```



##########################################
# Programs, memory, compilation commands #
##########################################

## Program

```sh
wc -c file.txt		         # number of bytes
size a.out                 # static memory sizes
file a.out                 # basic info
cloc src/                  # lines of code
strings a.out              # printable strings
ldd a.out                  # library dependencies
strace a.out	             # trace all system calls made by program
ltrace a.out               # dynamic library calls and signals
nm a.out                   # debugging symbols
objdump -d a.out           # disassembly
objdump -s -j .data a.out  # hexdump of .data segment
hexdump a.out              # binary values

readelf -h a.out    # misc info, top-level elf file headers
readelf -S a.out    # process address spaces
readelf -s a.out    # symbols table
readelf -n a.out    # core notes
readelf -r a.out    # relocation section (relocks)
readelf -d a.out    # dynamic section
```

## Memory

```sh
getconf PAGE_SIZE  # bytes per page
getconf WORDBIT  # bits per word
du -a /home/jvalcher | sort -n -r | head -n 5  # most disk usage
```

## Compiler

```sh
ldconfig -p                     # installed libraries
cpp -v /dev/null -o /dev/null   # C preprocessor directory search sequence
```



#########
# Files #
#########

- Create zeroed file, 4096 bytes
```
dd if=/dev/zero of=./zero_file count=4096B
```

- Compare files
```
diff -s file1 file1_copy        - text files
cmp -l file1 file1_copy         - binaries
```


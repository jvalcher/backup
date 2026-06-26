
# Core dumps

- Check current core size limit
  `ulimit -c`

- Set to unlimited
  `ulimit -c unlimited`

- Print core_pattern value, i.e. core dump name and location
  `sysctl kernel.core_pattern`

- Core pattern specifiers et al.
  `man core`

- To make custom pattern persistent, disable apport (doesn't work)
  `sudoedit /etc/default/apport`
  `enabled=0`

- Set core pattern to output `core` file to current directory
  `sudo sysctl -w kernel.core_pattern=core`
  - Or
  `sudoedit /etc/sysctl.d/60-core-pattern.conf`
  `kernel.core_pattern = core`
  `sudo sysctl --system`

- Examine core
  `gdb a.out core`
  `(gdb) bt`
  `(gdb) bt full`

  - Or use `~/.bin` script
  `$ core_bt`

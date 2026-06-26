
# Using ctags in vim


Commands:

- Ctrl ]    - open first match in new buffer
- g ]       - open list of matches


Create global ctags files<br>

```bash
# C/C++ Linux API
ctags -f $HOME/.tags_linux \
      --recurse=yes \
      --languages=C,C++ \
      --kinds-all=* \
      --exclude=*.c \
      --exclude=*.cpp \
      /usr/include

# C/C++ Arduino
ctags -f $HOME/.tags_arduino \
      --recurse=yes \
      --languages=C,C++ \
      --kinds-all=* \
      --exclude=*.c \
      --exclude=*.cpp \
      --exclude='*/examples/*' \
      $HOME/.arduino15/packages \
      $HOME/Code/Arduino/libraries


# Python 3.12
ctags -f $HOME/.tags_py \
      --recurse=yes \
      --languages=Python \
      --fields=+l \
      --python-kinds=-iv \
      $HOME/.pyenv/versions/3.12.0/lib/python3.12/site-packages
```
<br>


Global `$HOME/.vimrc` settings<br>

```vim
set exrc       " Use .vimrc in project root
set secure     " Disable dangerous commands in local .vimrc
```
<br>


Local `.vimrc` files<br>

```vim
" C/C++
filetype plugin on
set tags  = ./.tags
set tags += $HOME/.tags_linux
set tags += $HOME/.tags_arduino
command! GenCtags execute '!ctags -f .tags --recurse=yes --languages=C,C++ --kinds-all=* --exclude=*.c --exclude=*.cpp .' | redraw!

" Python
filetype plugin on
set tags  = ./.tags
set tags += $HOME/.tags_py
command! GenCtags execute '!ctags -f .tags --recurse=yes --languages=Python --kinds-all=* .' | redraw!
```
<br>


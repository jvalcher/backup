
""""""""""""
" Settings "
""""""""""""

let MYVIMRC=expand("%HOME/.vimrc")
let MYVIMINFO=expand("%HOME/.viminfo")
set runtimepath=$HOME/.vim,$VIMRUNTIME

" Set <leader>
nnoremap <Space> <Nop>
let mapleader=" "

" Set <localleader>
nnoremap , <Nop>
let maplocalleader=","

set confirm
set mouse=a
set noswapfile
set clipboard=unnamedplus
set encoding=utf-8
set fileencodings=utf-8
set autoindent
set smartindent
set shiftround
set tabstop=4
set shiftwidth=4
set softtabstop=4 
set expandtab
set showmatch
set nohlsearch
set wrap
set nowrapscan
set nolist
set textwidth=0
set relativenumber
set incsearch
set ignorecase
set smartcase
set autoread
set linebreak
set nopaste
set ruler
set wildmenu
set noerrorbells
set novisualbell
set backspace=indent,eol,start
set ttymouse=xterm2
set laststatus=2
set nobackup
set nowritebackup
set updatetime=10
set timeoutlen=100
set ttimeoutlen=100
set history=1000
set exrc                      " Use .vimrc in project root
set secure                    " Disable dangerous commands in local .vimrc
set number relativenumber     " norelativenumber
set tagcase=match             " case sensitive ctags matching
"set foldmethod=indent

" Remove end-of-buffer line character
let &fillchars ..= ',eob: '

" Jump to last position when opening file
if has("autocmd")
    augroup LastPosition
        autocmd!
        autocmd BufReadPost * normal! '"
    augroup END
endif

" Man pages
runtime! ftplugin/man.vim
"nnoremap K :Man <cword><CR>
nnoremap K :call system('tmux new-window man ' . shellescape(expand('<cword>')))<CR>

"""""""""
" ctags "
"""""""""
" <C-]>             Jump to first ctags match
" g]                Open ctags match list
" <C-S-N>           Open autocomplete dropdown in insert mode
"""""""""
set tags=tags,$HOME/.vimtags

" Set format options (see fo-table)
au BufEnter * set fo-=c fo-=r fo-=o

" Preserve copied data when replacing with visual mode
xnoremap <expr> p '"_d"'.v:register.'p'
xnoremap P "_dP

" Change cursor from block to line in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Set persistent undo, target directory
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
    call mkdir(expand("$HOME/.vim/undodir"), "p")
endif
set undodir=$HOME/.vim/undodir



""""""""""""
" vim-plug "
""""""""""""

" Automatically install vim-plug
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" NERDTree
let NERDTreeQuitOnOpen = 1
nnoremap <leader>n :NERDTreeToggle<CR>
  " Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
  " Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
  " Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = ''



""""""""""""""""""
" Misc shortcuts "
""""""""""""""""""

" 'jk' to <escape>
inoremap jk <Esc>
vnoremap jk <Esc>

" Set <leader>d to <Esc>
nnoremap <leader>d <Esc>
vnoremap <leader>d <Esc>

" Move cursor up/down wrapped lines
nnoremap j gj
nnoremap k gk

" Navigate, delete buffers
nnoremap <localleader>b :buffers<CR>
nnoremap <leader>a :bprevious<CR>
nnoremap <leader>s :bnext<CR>
nnoremap <leader>x :bdelete<CR>

" Don't yank when deleting with d,dd (only with x)
nnoremap d "_d
nnoremap dd "_dd

" Open terminal
nnoremap <leader>t :shell <CR>

" Scroll screen up/down when cursor not auto-centered
nnoremap <C-m> kzz
nnoremap <C-n> jzz

" Reselect visual block for multiple indents
vnoremap < <gv
vnoremap > >gv

" Record
nnoremap <leader>r  q

" Fold
  " Toggle all folds under cursor
nnoremap <leader>f zA
  " Close all folds in file
nnoremap <leader>c zM

" Open pane split
nnoremap <leader>o :split <CR>
nnoremap <leader>e :vsplit <CR>

" Adjust pane size
nnoremap <leader><up>      2<C-W>+
nnoremap <leader><down>    2<C-W>-
nnoremap <leader><right>   2<C-W>>
nnoremap <leader><left>    2<C-W><    

" Navigate panes
nnoremap <leader>h <C-W><C-H>
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>

" Mouse wheel scrolling
nnoremap <ScrollWheelDown> jzz
nnoremap <ScrollWheelUp>   kzz
vnoremap <ScrollWheelDown> jzz
vnoremap <ScrollWheelUp>   kzz
inoremap <ScrollWheelDown> <Esc>jzz
inoremap <ScrollWheelUp>   <Esc>kzz

" Autocomplete paths
imap <C-c> <C-X><C-F>

" Copy absolute path of current file to clipboard
nnoremap <silent> <leader>w :let @+ = expand('%:p') \| echo 'Copied "' . expand('%:p') . '"'<CR>

" Toggle automatic cursor centering
function Center_cursor()
    let pos = getpos(".")
    normal! zz
    call setpos(".", pos)
endfunction
let g:cursor_centered=1
augroup CenterCursor
    autocmd!
    autocmd CursorMoved,CursorMovedI * call Center_cursor()
augroup END
function Toggle_center_cursor()
    if g:cursor_centered==0
        augroup CenterCursor
            autocmd!
            autocmd CursorMoved,CursorMovedI * call Center_cursor()
        augroup END
        normal! zz
        let g:cursor_centered=1
        echo "Cursor centered"
    else
        augroup CenterCursor
            autocmd!
        augroup END
        let g:cursor_centered=0
        echo "Cursor free"
    endif
endfunction
nnoremap <localleader>c :call Toggle_center_cursor() <CR>

" Toggle autosave
augroup AutoSave
    autocmd!
    autocmd InsertLeave,TextChanged,FocusLost * silent! write
    autocmd FocusGained,BufEnter * :redraw!
augroup END
function! ToggleAutoSave()
    if !exists('#AutoSave#InsertLeave')
        augroup AutoSave
            autocmd!
            autocmd InsertLeave,TextChanged,FocusLost * silent! write
            autocmd FocusGained,BufEnter * :redraw!
        augroup END
        echo "AutoSave on"
    else
        augroup AutoSave
            autocmd!
        augroup END
        echo "AutoSave off"
    endif
endfunction
nnoremap <leader>u :call ToggleAutoSave() <CR>

" Get syntax highlight group under cursor
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction
nnoremap <leader>i :call SynGroup() <CR>

" Toggle paste/nopaste
function! TogglePaste()
    if &paste == 0
		set paste
		echo "paste"
	else
		set nopaste
		echo "nopaste"
	endif
endfunction
noremap <leader>p :call TogglePaste() <CR>

" Toggle relativenumber
function! ToggleLineNum()
  if &relativenumber == 0
		set relativenumber
		echo "relativenumber"
	else
		set norelativenumber 
		echo "norelativenumber"
	endif
endfunction
noremap <leader>v :call ToggleLineNum() <CR>

" Copy current filename to clipboard
function! CopyFileName()
  let l:filename   = expand('%:t')
  let @+ = l:filename
  echo 'Copied "' . l:filename . '" to clipboard'
endfunction
noremap <localleader>f :call CopyFileName() <CR>

" Create, copy GDB breakpoint string '<file>:<line>' to clipboard
function! CreateBreakpoint()
    let l:filename   = expand('%:t')
    let l:linenumber = line('.')
    let l:breakpoint = l:filename . ':' . l:linenumber
    let @+           = l:breakpoint
    echo 'Copied "' . l:breakpoint . '" to clipboard'
endfunction
nnoremap <leader>b :call CreateBreakpoint()<CR>

" Copy LeetCode solution to clipboard (see leet, leetc skeletons)
function! CopyLeetSolutionC()
  let l:start = search('/\*\*\* LEET START \*\*\*/', 'nw')
  let l:end = search('/\*\*\* LEET END \*\*\*/', 'nw')
  if l:start > 0 && l:end > 0 && l:end > l:start
    execute (l:start + 1) . ',' . (l:end - 1) . 'y'
    redraw | echo 'Copied LeetCode solution'
  else
    redraw | echo 'LeetCode solution block not found'
  endif
endfunction
nnoremap <localleader>l :call CopyLeetSolutionC()<CR>



"""""""""""
" Styling "
"""""""""""

syntax on
set t_Co=256
set background=dark

" Colorscheme  (~/.vim/colors/guvbox.vim)
autocmd vimenter * ++nested colorscheme gruvbox

" Transparent background
"hi Normal guibg=NONE ctermbg=NONE
autocmd VimEnter * hi Normal ctermbg=none

" Remove character from unused lines
hi EndOfBuffer guibg=NONE



""""""""""""""""""""""""""
" File-specific settings "
""""""""""""""""""""""""""

augroup FILETYPES
  autocmd!

  " Insert superscript
  func! SetSuperscripts()
    iabbrev ^1 ¹
    iabbrev ^2 ²
    iabbrev ^3 ³
    iabbrev ^4 ⁴
    iabbrev ^5 ⁵
    iabbrev ^6 ⁶
    iabbrev ^7 ⁷
    iabbrev ^8 ⁸
    iabbrev ^9 ⁹
    iabbrev ^0 ⁰
    iabbrev ^n ⁿ
    iabbrev ^N ᴺ
  endfunc

  " Generate local ctags in ./.tags
  "command! GenCtags execute '!ctags -f .tags --recurse=yes --languages=C,C++ --kinds-all=* --exclude=*.c --exclude=*.cpp .' | redraw!


  " Markdown
    " set superscripts
  autocmd Filetype markdown call SetSuperscripts()
  autocmd FileType markdown hi link markdownError NONE
  autocmd FileType markdown hi clear markdownH2

  " 2-space tabs
  autocmd BufRead,BufNewFile *.vimrc,*.htm,*.html,*.yml,*.yaml,*.json,*.md,*.spec,*.css,*.scss setlocal tabstop=2 shiftwidth=2 softtabstop=2

  " Em dash
  autocmd FileType markdown iabbrev <buffer> -- —

  " turn off newline indentation in markdown
  let g:vim_markdown_new_list_item_indent = 1

  " Spell checking (spell, nospell)
  autocmd BufRead,BufNewFile *.md,*.txt setlocal nospell


augroup END



"""""""""""""
" Skeletons "
"""""""""""""

" Bash  (:Bash)
command Bash 0r ~/.vim/skeletons/bash
" C
command C 0r ~/.vim/skeletons/c
" C debug
command Cdebug 0r ~/.vim/skeletons/c_debug
" C++
command Cpp 0r ~/.vim/skeletons/cpp
" HTML
command Html 0r ~/.vim/skeletons/html
" Sass CSS
command Scss 0r ~/.vim/skeletons/scss
" C Makefile
command Makec 0r ~/.vim/skeletons/makec
" Python bash script
command Pybash 0r ~/.vim/skeletons/pybash
" LeetCode solution C++
command Leet 0r ~/.vim/skeletons/leet
" LeetCode solution C
command LeetC 0r ~/.vim/skeletons/leetc
" Ncurses C
command Nc 0r ~/.vim/skeletons/ncurses_c
" NASM
command Nasm 0r ~/.vim/skeletons/nasm

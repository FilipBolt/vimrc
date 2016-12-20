set nocompatible              " be iMproved, required
let os = substitute(system('uname'), "\n", "", "")

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" added nerdtree
Plugin 'scrooloose/nerdtree'

" git plugin for nerdtree
Plugin 'Xuyuanp/nerdtree-git-plugin'

" flake8 checker
Plugin 'andviro/flake8-vim'

" python code assist
Plugin 'python-rope/ropevim'

" indendation 
Plugin 'vim-scripts/indentpython.vim'

" appearance
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" nerdtree in all tabs
Plugin 'jistr/vim-nerdtree-tabs'

" searching for files using Ctrl+P, freezes when tried
Plugin 'kien/ctrlp.vim'

Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" show status line of git branch
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

" Git merge tool
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required

syntax on
filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins

" intendation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix

set showcmd
set showmatch
set incsearch
set hlsearch
set backspace=indent,eol,start
set wildmode=longest,list,full
set wildmenu

let os = substitute(system('uname'), "\n", "", "")
if os != "Linux"
    if has('gui_running')
      set background=dark
      colorscheme solarized
    else
      colorscheme zenburn
    endif
endif

" Open NERDTree by default when opening vim
" Close NERDTree by default when closing vim
"
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p
"
"function! NERDTreeQuit()
"  redir => buffersoutput
"  silent buffers
"  redir END
""                     1BufNo  2Mods.     3File           4LineNo
"  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
"  let windowfound = 0
"
"  for bline in split(buffersoutput, "\n")
"    let m = matchlist(bline, pattern)
"
"    if (len(m) > 0)
"      if (m[2] =~ '..a..')
"        let windowfound = 1
"      endif
"    endif
"  endfor
"
"  if (!windowfound)
"    quitall
"  endif
"endfunction
"autocmd WinEnter * call NERDTreeQuit()

" moving around mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" moving swap files to tmp dir
set swapfile
set dir=/tmp

let python_highlight_all=1

" toggle between dark/light theme
" call togglebg#map("<F5>")

" default copy-paste to clipboard
set clipboard=unnamed

set nowrap
set textwidth=0 wrapmargin=0
set number

" seting for MacVim
if os != "Linux"
    set guifont=Monaco:h14
endif
" disable arrow keys

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-m> :call NumberToggle()<cr>

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
set diffopt+=vertical
noremap <C-n> :call NumberToggle()<cr>


" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

nmap <silent> <RIGHT> :cnext<CR>
nmap <silent> <LEFT> :cprev<CR>

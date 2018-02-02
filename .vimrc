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

" commenting plugin
Plugin 'scrooloose/nerdcommenter'

" indendation 
Plugin 'vim-scripts/indentpython.vim'

" appearance
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" nerdtree in all tabs
Plugin 'jistr/vim-nerdtree-tabs'

" searching for files using Ctrl+P, freezes when tried
Plugin 'kien/ctrlp.vim'

" Git merge tool
Plugin 'tpope/vim-fugitive'

" Surround vim 
Plugin 'tpope/vim-surround', {'autoload': {'filetypes': ['python']} }

" Repeat vim 
Plugin 'tpope/vim-repeat'

" " Testing autocomplete tool
Plugin 'Valloric/YouCompleteMe'
" Plugin 'davidhalter/jedi-vim'
" Plugin 'Shougo/deoplete.nvim'
"
" Undo visualisation
Plugin 'sjl/gundo.vim'

" Navigate between vim splits and tmux splits seamlessly
Plugin 'christoomey/vim-tmux-navigator'

"Add this line if you are using Python 3.
let g:gundo_prefer_python3 = 1

let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

" Latex plugin
Plugin 'lervag/vimtex'

" Haskell plugin(s)
Plugin 'dag/vim2hs'
Plugin 'eagletmt/ghcmod-vim'

" general syntax checker
Plugin 'scrooloose/syntastic'

" trying out an async syntax checker
" Plugin 'w0rp/ale'

" airline

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" async execution
Plugin 'Shougo/vimproc.vim'

" begginner default recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" plugin for tmux + vim  integration -> sending commands to tmux from vim
Plugin 'jpalardy/vim-slime'
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()

" Prose writing plugin
Plugin 'junegunn/goyo.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

syntax on
filetype on            " enables filetype detection
filetype plugin indent on     " enables filetype specific plugins

" intendation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
" set autoindent
set fileformat=unix

set showcmd
set showmatch
set incsearch
set hlsearch
set backspace=indent,eol,start
set wildmode=longest,list,full
set wildmenu

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
set clipboard=unnamedplus

set nowrap
set textwidth=0 wrapmargin=0
set number

" disable arrow keys
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" Always want to use relativenumbers
set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
set diffopt+=vertical

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

" latex ignore files setup
let NERDTreeIgnore = ['\.log$', '\.nav$', '\.snm$', '\.pdf$', '\.aux$', '\.toc$', '\.out$']


" I want to quit the quickfix window if I closed it's corresponding file
:autocmd WinEnter * if &buftype ==# 'quickfix' && winnr('$') == 1 | quit | endif

" Haskell file syntax helpers
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>

" In visual mode you can now press gq to convert 
" a expression to it’s pointfree form. Though quite often the resulting form
" is more obfuscated than the original.

autocmd BufEnter *.hs set formatprg=pointfree

syntax on
let g:solarized_termcolors=256
set t_Co=256 
set background=dark
colorscheme solarized

" add haskell cabal to the path to use it from the haskell plugins
let $PATH = $PATH . ':' . expand('~/.cabal/bin')

" mode that is made for writing text
" see https://statico.github.io/vim3.html#writing-prose-in-vim
function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
  set bg=light
  if !has('gui_running')
    let g:solarized_termcolors=256
  endif
  colors solarized
endfunction

command! ProseMode call ProseMode()
nmap \p :ProseMode<CR>

" I don't like folding so disable it
set nofoldenable    " disable folding

" Aliasing commands
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W", "w")

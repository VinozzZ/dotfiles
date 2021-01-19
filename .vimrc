" Install plugin system (not necessary if already setup)
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Setup plugins
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Valloric/YouCompleteMe', {'do': './install.py'} " autocomplete
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive' " git support
Plug 'jiangmiao/auto-pairs' " auto closing tag
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-sleuth'
call plug#end()

set updatetime=250 " how long (ms) after you stop typing vim refreshes things, used by vim-gitgutter and other plugins

" Options for morhetz/gruvbox
let g:gruvbox_bold=0
let g:gruvbox_italic=0
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
      \   'left': [ [ 'mode'], [ 'lineinfo' ], [ 'percent' ], [ 'filename' ] ],
      \   'right': [ [],[],[], [ 'filetype' ], [ 'gitbranch' ], [ 'modified' ] ],
    \ },
    \ 'inactive': {
      \   'left': [ [ 'filename' ] ],
      \   'right': [ [],[],[], [ 'filetype' ], [ 'gitbranch' ], [ 'modified' ] ],
    \ },
    \ 'component': {
      \ 'lineinfo': '%3l:%L%<',
      \ 'filename': '%f',
    \ },
    \ 'component_function': {
      \ 'gitbranch': 'FugitiveHead',
    \ },
    \ 'component_type': {
      \ 'filetype': 'FugitiveHead',
    \ }
\ }


" toggle nerdtree with ctrl+n
map <C-n> :NERDTreeToggle<CR>
" default nerdtree v and > arrows
let g:NERDTreeDirArrowExpandable = '🥢'
let g:NERDTreeDirArrowCollapsible = '🍜'
" show hidden files in nerdtree
let NERDTreeShowHidden=1

" smartcase for ripgrep
let g:rg_command = 'rg --vimgrep -S'

"
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" Tab options
let g:myTabSize = 4 " Set myTabSize var to use below
let &shiftwidth = myTabSize " Tell vim how many columns is a tab
let &softtabstop = myTabSize " Tab and delete this many columns
let &tabstop = myTabSize " Actual hard tabstops will be my tab size
set autoread " Always reload a file when it has changed instead of asking -- only works on gvim
set autoindent
set number " Line numbers
set mouse=a " Allow mouse scrolling, other mouse events
set clipboard=unnamed,unnamedplus " Always yank to and from the system clipboard
set ignorecase
set smartcase " Smartcase in search
" set cursorline " Show current line highlighted
set incsearch " show search matches as you type
set nowrap " don't wrap text
set backspace=2 " Backspace works as normal -- actually moves cursor back and deletes
set tags=tags; " Tell vim to look for tags recursively downwards
set nostartofline " Keeps the cursor in its last spot when changing buffers (prevents it from going to start of line)
set autowrite     " Automatically :write before running commands
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

""""""""""" View options
set linespace=3 " Line space
syntax on
set background=dark
set noshowmode " don't show --INSERT-- in insert mode, rely on status line
set laststatus=2 " display status line always
set termguicolors "use native true colors (only supported starting vim v8)
set clipboard=unnamed,unnamedplus " Always yank to and from the system clipboard
set cursorline " Show current line highlighted
set incsearch " show search matches as you type
set noerrorbells "disable beep on errors
set visualbell "flash screen instead of beeping on errors
"remap escape key
inoremap jk <esc>
"  remap leader key to comma
let mapleader = ","

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" set swap files location
set directory=$HOME/.vim/swp//
" Disable backup files
set nobackup
" set undo history files location
set undofile
set undodir=~/.vim/undodir

" vim-go settings
let g:go_fmt_command = "goimports"
let g:go_bin_path = "/Users/yingrongzhao/go/bin"
let g:go_fmt_options = {
\ 'goimports': '-local storj.io/'
\ }
let g:go_metalinter_command='golangci-lint --config ~/work/ci/.golangci.yml run --exclude-use-default=false'
let g:go_rename_command = 'gopls'

autocmd FileType go TagbarOpen

let g:tagbar_type_go = {
    \ 'kinds' : [
		\ 'e:embedded',
		\ 'r:constructor',
        \ 't:types:0:0',
        \ 'f:functions:0:0',
        \ 'm:methods:0:0',
        \ 'n:intefaces:0:0',
		\ 'c:constants',
		\ 'v:variables',
        \ '?:unknown',
    \ ],
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
\ }

" Disable hover tooltips
set noballooneval
let g:netrw_nobeval = 1
let g:ycm_auto_hover=''

" ack.vim --- {{{

" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:fzf_layout = { 'down':  '30%'}
let g:fzf_preview_window = 'right:70%:hidden'
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" fzf file finder
nnoremap <silent> <C-f> :Files<CR>

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>
" }}}

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
set tags=tags

" Split panes to right and bottom
set splitbelow
set splitright

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

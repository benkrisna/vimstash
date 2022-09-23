set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" execute pathogen#infect()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable non-vi-compatible options
set nocompatible

" Reset leader to comma
let mapleader=","

" First turn off to force reloading
filetype off

" Install pathogen scripts
" execute pathogen#infect()

" Turn on syntax highlighting
syntax on

" Enable automatic file-type recognition
filetype plugin indent on

" Disable modelines for security purposes
set modelines=0

" Force utf-8 encoding
set encoding=utf-8

" Set undo directory and enable undo files
"set undodir=~/.vim/undo-dir
"set undofile

" Disable beeping
set visualbell
set noerrorbells


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" APPEARANCE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show line and column number at bottom
set ruler

" Show line numbers
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
nnoremap <silent> <F2> :set nonumber!<CR>

function! BgToggle()
  if (&background == "light")
    set background=dark
  else
    set background=light
  endif
  highlight LineNr term=bold cterm=NONE ctermfg=DarkGreen ctermbg=NONE gui=bold guifg=DarkGreen guibg=NONE
endfunction

nnoremap <silent> <F10> :call BgToggle()<CR>
nnoremap <silent> <F12> :set nu! rnu! <CR>

" Set textwidth
set textwidth=160

" Show command in last line
set showcmd

" Keep at least one line shown when scrolling
set scrolloff=3

" Keep at least five chars when scrolling horizontally
set sidescrolloff=5

" Always show status line
set laststatus=2

" Enable search highlighting
set hlsearch

" Show matching parentheses
set showmatch

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Show partial last lines
set display+=lastline

" Set proper status line
set statusline=
set statusline+=%t\     "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
"set statusline+=%{TagName()}\  "C-tag if present
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %3c  "cursor column
set statusline+=\ %P    "percent through file

" Save status line for use in ctags plugin
let g:custom_statusline = &statusline

" Enable solarized color scheme
"set background=dark
"colorscheme solarized
"colorscheme torte   " comments are blue
"colorscheme elflord  " comments are dark green
"colorscheme slate
"colorscheme NeoSolarized
"Change theme based on time of day
let hr = (strftime("%H"))
colorscheme hemisu
if hr >= 20
  "colorscheme simple-dark
  set background=dark
elseif hr >=7
  set background=light
elseif hr >= 0
  set background=dark
  "colorscheme simple-dark
endif
"source vitali.vim

highlight LineNr term=bold cterm=NONE ctermfg=DarkGreen ctermbg=NONE gui=bold guifg=DarkGreen guibg=NONE
" Enable gui-specific options (i.e. MacVim)
if has('gui_running')
  " Use no aliasing
  "set noantialias

  " Set Monaco and font size 12
  "set guifont=Monaco:h12
  " Set Anonymous Pro and font size 14
  set guifont=MyFixed:h14

  " Disable blinking cursor and use block cursor everywhere
  set guicursor+=a:blinkon0
  set guicursor+=a:block-Cursor/lCursor
endif

" Highlight overlong lines in all files
" highlight OverLength ctermbg=0 ctermfg=197
" autocmd VimEnter,WinEnter *
"       \ if !exists('w:created') |
"       \ call matchadd('OverLength', '\%>140v.\+') |
"       \ endif
" 
" Highlight trailing whitespace in all files
highlight ExtraWhitespace ctermbg=0
autocmd VimEnter,WinEnter *
      \ if !exists('w:created') |
      \ call matchadd('ExtraWhitespace', '\s\+$') |
      \ endif

" Highlight tabs in certain file types
autocmd VimEnter,WinEnter *
      \ if (!exists('w:created') && &ft =~ 'cpp\|c\|python\|sh') |
      \ call matchadd('ExtraWhitespace', '\t') |
      \ endif

" Autocmd to mark a window was created
autocmd VimEnter,WinEnter * let w:created=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EDITING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map 'jk' to Escape if in insert mode
"inoremap <silent> jk <Esc>

" Toggle paste mode
set pastetoggle=<F3>

" Move lines up and down in normal mode
nnoremap <silent> - ddp
nnoremap <silent> _ ddkP

" Go to beginning/end of line in normal mode
nnoremap <silent> H ^
nnoremap <silent> L $

" Start searching while typing
"set incsearch

" Ignore case while searching
"set ignorecase

" Consider case if uppercase letter is present
set smartcase

" Set some auto-indentation options
" Insert spaces instead of tab
set expandtab
" Numbers of steps for each indentation level 
set shiftwidth=2
" Number of spaces to show for a tab
set tabstop=2
" Use two spaces when deleting soft tabs
set softtabstop=2
" Automatically indent C programs
set cindent
" Smart auto-indentation when starting a new line
set smartindent
" Use indent from current line when starting a new one
set autoindent
" Round indent to multiples of 'shiftwidth'
set shiftround

" Toggle between parens using tab
nnoremap <tab> %
vnoremap <tab> %

" Set usual backspace behavior
set backspace=indent,eol,start

" Add Mac file formats to be tried when opening files
set fileformats+=mac

" Save 1000 commands in history
set history=1000

" Enhance command line completion
set wildmenu
set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class,*.elc

" Automatically re-read changed files
set autoread

" Do not consider numbers starting with a zero to be octal
set nrformats-=octal


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MOVING AROUND
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Step over each line
nnoremap j gj
nnoremap k gk


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCOMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Automatic indentation for Python
autocmd BufRead *.py set cinwords=if,elif,else,for,while,try,except,finally,def,class

" Automatic adaption of indentation for Python files
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" Do not expand tabs in Makfiles
autocmd FileType make setlocal noexpandtab

" Disable automatic comment continuation for single-line comments
autocmd FileType c,cpp setlocal comments-=:// comments+=f://

" Disable automatic command continuation for single-line comments in vim
autocmd FileType vim setlocal formatoptions-=r formatoptions-=o


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" WINDOWS & BUFFER MANAGEMENT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Edit & reload .vimrc file
nnoremap <silent> <leader>ev :vs $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

" Create new window and switch to it
nnoremap <leader>w <C-w>v<C-w>l

" Do not force to close files, just hide them
" set hidden

" Use space to toggle folding
" nnoremap <space> za


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS: CSCOPE, CTAGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Recursively create tags for all files in the current directory (for ctags and 
" cscope), then reset cscope database
function! RebuildTagsCscope()
  !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
  !cscope -Rb
  cs kill -1
  cs add cscope.out
endfunction

" Rebuild tags & cscope databases with F8
map <silent> <F8> :call RebuildTagsCscope()<CR><CR><CR><CR>

" Set taglist width
let Tlist_WinWidth = 40

" Bind taglist to F4
map <silent> <F4> :TlistToggle<cr>

" Auto-gain focus on taglist when opening
let Tlist_GainFocus_On_ToggleOpen = 1

" Exit vim if the tag list remains the only open window
let Tlist_Exit_OnlyWindow = 1

" Order tag list by name (and not by appearance)
let Tlist_Sort_Type = "name"

" Add C++ standard library tags
set tags+=~/.vim/tags/cpp

" Show current function name in status line
let g:ctags_statusline=1
let generate_tags=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS: YOUCOMPLETEME, SYNTASTIC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" if exists(':YcmDebugInfo')
  " Disable explicit confirmation of ycm_extra_conf.py file
  let g:ycm_global_ycm_extra_conf = '~/Code/ZFS/.ycm_extra_conf_no_auto.py'

  " Disable preview window (annoying!)
  set completeopt=menuone,menu,longest
" endif

" Enable statusline warnings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
let g:syntastic_mode_map = { 'mode': 'passive',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': [] }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS: OMNICPPCOMPLETE, SUPERTAB
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use new omnicppcomplete
" autocmd FileType cpp set omnifunc=omni#cpp#complete#Main
"
" let OmniCpp_DisplayMode         = 1 " Always show full list of members
" let OmniCpp_ShowPrototypeInAbbr = 1 " Show function parameters
" let OmniCpp_DefaultNamespaces   = ["std", "_GLIBCXX_STD"] " Automatically assume namespace
" let OmniCpp_MayCompleteDot      = 0 " Disable auto-complete for .
" let OmniCpp_MayCompleteArrow    = 0 " Disable auto-complete for ->
" let OmniCpp_MayCompleteScope    = 0 " Disable auto-complete for ::
"
" " Automatically open and close the popup menu / preview window
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" " Set the
" set completeopt=menuone,menu,longest
"
" " Enable SuperTab completion
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS: CTRLP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map Ctrl-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

" Use SVN directory as parent search directory
let g:ctrlp_working_path_mode = 'ra'

" Ignore svn/hg/git directories
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(o|exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS: NERDTREE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto-start NERDTree if no file was specified
"autocmd vimenter * if !argc() | NERDTree | endif

" Auto-close NERDTree if it is the last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Map Ctrl-f to NERDTree
noremap <silent> <C-f> :NERDTreeToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS: DOXYGENTOOLKIT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:DoxygenToolkit_briefTag_pre="\\brief "
let g:DoxygenToolkit_paramTag_pre="\\param[] "
let g:DoxygenToolkit_templateParamTag_pre = "\\tparam "
let g:DoxygenToolkit_returnTag = "\\return "
let g:DoxygenToolkit_authorTag = "\\author "
let g:DoxygenToolkit_dateTag = "\\date "
let g:DoxygenToolkit_blockTag = "\\name "
let g:DoxygenToolkit_classTag = "\\class "
let g:DoxygenToolkit_authorName="Michael Schlottke (mic) <mic@aia.rwth-aachen.de>"
let DoxygenToolkit_commentType = "C++"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS: VIM-LATEX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS: FORTRAN
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let fortran_free_source=1
let fortran_do_enddo=1
filetype plugin indent on
autocmd Filetype fortran setlocal formatprg=fprettify\ --silent

syntax on

" Turn on line numbers and
" row/column numbers
set nu
set ruler

" Make vim echo commands as they
" are being entered.
set showcmd

" Set tabstops to two spaces
" and ensure tab characters are
" expanded into spaces.
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2

" Fix backspace key
set bs=2

" Set up searching so
" that it jumps to matches
" as the word is being
" entered and is case-insensitive
set incsearch
set ignorecase
set smartcase
autocmd Filetype fortran setlocal formatprg=fprettify\ --silent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SVN BLAME
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Show the Subversion 'blame' annotation for the current file, in a narrow
"  window to the left of it.
"Usage:
"  'gb' or ':Blame'
"  To get rid of it, close or delete the annotation buffer.
"Bugs:
"  If the source file buffer has unsaved changes, these aren't noticed and
"    the annotations won't align properly. Should either warn or preferably
"    annotate the actual buffer contents rather than the last saved version.
"  When annotating the same source file again, it creates a new annotation
"    buffer. It should re-use the existing one if it still exists.
"Possible enhancements:
"  When invoked on a revnum in a Blame window, re-blame same file up to the
"    previous revision.
"  Dynamically synchronize when edits are made to the source file.
:function! s:svnBlame()
   let line = line(".")
   setlocal nowrap
   " create a new window at the left-hand side
   aboveleft 18vnew
   " blame, ignoring white space changes
   %!svn blame -x-w "#"
   setlocal nomodified readonly buftype=nofile nowrap winwidth=1
   setlocal nonumber
   if has('&relativenumber') | setlocal norelativenumber | endif
   " return to original line
   exec "normal " . line . "G"
   " synchronize scrolling, and return to original window
   setlocal scrollbind
   wincmd p
   setlocal scrollbind
   syncbind
:endfunction
noremap gb :call <SID>svnBlame()<CR>
command! Blame call s:svnBlame()
noremap ggb :wincmd p<CR>:q<CR>:set noscrollbind<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISCELLANEOUS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable to call make from inside the source directory
set makeprg=make\ -j\ 8\ -C\ ../

" Enable quick access to linediff
noremap \ldt :Linediff<CR>
noremap \ldo :LinediffReset<CR>

" Show message when file has changed
:au FileChangedShell * echo "Warning: File changed on disk (enter ':e' to reload current file)."



" Commands to invoke clang-format
"map <C-K> :pyf /home/benkrisna/clang/tools/clang-format/clang-format.py<CR>
"imap <C-K> <ESC>:pyf /home/benkrisna/clang/tools/clang-format/clang-format.py<CR>i
map <C-K> :ClangFormat<CR>
imap <C-K> <ESC>:ClangFormat<CR>i


set tags=./tags;

execute "set <M-1>=\e1"
execute "set <M-2>=\e2"
execute "set <M-3>=\e3"
execute "set <M-4>=\e4"
execute "set <M-5>=\e5"
execute "set <M-6>=\e6"
execute "set <M-7>=\e7"
execute "set <M-8>=\e8"
execute "set <M-9>=\e9"
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9g

nnoremap <c-n> :tabprevious<CR>
nnoremap <c-m> :tabnext<CR>

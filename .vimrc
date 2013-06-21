call pathogen#infect()

set nocompatible

set background=light     " Assume a light background

syntax on

" Auto detect filetype
filetype plugin indent on

runtime macros/matchit.vim

set clipboard=unnamed

" Display current mode
set showmode

" Intuitive basckspace
set backspace=indent,eol,start

" Handle multiple buffer better
set hidden

" Enhanced command line commands
set wildmenu
set wildmode=list:longest
set wildignore+=public/uploads

" Ignore case when search
set ignorecase
" If expression has capital letter the case is relevant
set smartcase

" Remaping the <Leader> key.
let mapleader = ","

" Show line numbers
set number
" Add a highlight color in the current line
set cursorline

" Highlight match as you type
set incsearch
set hlsearch

" Turn on line wrapping.
set wrap
" Show 3 lines of context around the cursor.
set scrolloff=3

" Set the terminal's title
set title

" No more anoying beeps
set visualbell

" Don't make a backup before overwriting a file.
set nobackup
set nowritebackup
" Keep swap files in one location
set directory=$HOME/.vim/tmp//,.

" Default tab width
set tabstop=2
set shiftwidth=2
" Use spaces instead of tabs
set expandtab
set pastetoggle=<F12>

colorscheme Tomorrow

" Mapping for quick js/less/scss folding
nmap <leader>f vi{zf

" Mapping for tab manipulation
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" For the MakeGreen plugin and Ruby RSpec
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

" Set line break
set linebreak
" Don't show invisibles
set nolist
" Invisibles for tab and end of line
set listchars=tab:▸\ ,eol:¬

" Blank chars colors
highlight NonText guifg=#143c46
highlight SpecialKey guifg=#143c46

" Don't use spell checker, if use Portuguese is the default language
set nospell
set spelllang=pt

" Mapping to show or hide invisibles
map <leader>d :set list!<cr>

" Creates one line above and bellow the current cursor position
nmap <Tab> O <Esc> j O <Esc>

map <leader>cc :CommandTFlush<cr>\|:CommandT<cr>

" Syntax Changing
map <leader>jq :set syntax=jquery<cr>
map <leader>js :set syntax=javascript<cr>
" Execute the current file in nodejs
map <leader>nd :!node %<cr>

" Execute rspec
map <leader>s :!rspec --color<cr>

" Function to align key value fat arrows in ruby, and equals in js, stolen
" from @tenderlove vimrc file.
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')
vnoremap <silent> <Leader>a :Align<cr>
function! AlignSection(regex) range
  let extra = 1
  let sep = empty(a:regex) ? '=' : a:regex
  let maxpos = 0
  let section = getline(a:firstline, a:lastline)
  for line in section
    let pos = match(line, ' *'.sep)
    if maxpos < pos
      let maxpos = pos
    endif
  endfor
  call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
  call setline(a:firstline, section)
endfunction

function! AlignLine(line, sep, maxpos, extra)
  let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
  if empty(m)
    return a:line
  endif
  let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
  return m[1] . spaces . m[2]
endfunction

if has('cmdline_info')
  set ruler                   " show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
  set showcmd                 " show partial commands in status line and
  " selected characters/lines in visual mode
endif

if has('statusline')
  set laststatus=2

  " Broken down into easily includeable segments
  set statusline=%<%f\    " Filename
  set statusline+=%w%h%m%r " Options
  set statusline+=%{fugitive#statusline()} "  Git Hotness
  set statusline+=\ [%{&ff}/%Y]            " filetype
  set statusline+=\ [%{getcwd()}]          " current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" " Automaticaly load my vimrc when saved.
" if has("autocmd")
"   autocmd bufwritepost .vimrc source $MYVIMRC
" endif

" " mapping to open my vimrc, to edit it on the fly
" nmap <leader>v :tabedit $MYVIMRC<cr>

" Nice way to corret typos saving, editing and deleting buffers
if has("user_commands")
  command! -bang -nargs=* -complete=file E e<bang> <args>
  command! -bang -nargs=* -complete=file W w<bang> <args>
  command! -bang -nargs=* -complete=file Wq wq<bang> <args>
  command! -bang -nargs=* -complete=file WQ wq<bang> <args>
  command! -bang -nargs=* -complete=file Bd bd<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
  command! -bang Bd bd<bang>
endif

" Removed the slow rake routes function from bash
function! ShowRoutes()
  " requires vim-scratch plugin
  :topleft 100 :split __Routes__
  :set buftype=nofile
  :normal 1GdG
  :0r! rake -s routes
  :exec ":normal " . line("$") . "^W_ "
  :normal 1GG
  :normal dd
endfunction
map <leader>cR :call ShowRoutes()<cr>

" Command-T settings
" Open in split by default
let g:CommandTAcceptSelectionSplitMap=['<CR>', '<C-s>']

" CommandT mapings
map <leader>cv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>ct :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>cm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>ch :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>cs :CommandTFlush<cr>\|:CommandT spec<cr>
map <leader>cl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>ca :CommandTFlush<cr>\|:CommandT app/assets<cr>
map <leader>cg :topleft 100 :split Gemfile<cr>

" Alternate between last opened file
nnoremap <leader><leader> <c-^>

" Map ,e and ,v to open files in the same directory as the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Automaticaly create a directory in the current file
map <leader>md :silent !mkdir -p %%<cr> :redraw! <cr>

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>r :call RenameFile()<cr>

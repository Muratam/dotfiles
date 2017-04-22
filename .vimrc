set encoding=utf-8
set nobackup
set number
set title
set backspace=start,eol,indent
set mouse=a
"set completeopt=menuone
set cursorline
set laststatus=2
set statusline=%F%m%r%h%w\ [%04l,%04v][%p%%]
"set noshowmode
set showmatch
 
"--------tab--------
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set list
set listchars=tab:>-,trail:_
set autoindent
set cindent
au FileType python,java,scala,groovy
  \ setlocal tabstop=4 shiftwidth=4 softtabstop=4

"-------Search--------
set incsearch
set ignorecase
set smartcase
set wrapscan
set hlsearch
set history=50
set pastetoggle=<C-p>
set wildmode=longest,list,full

" keymap
" esc to c-f
"inoremap <C-f> <Esc>
" remove highlights
"nnoremap <Esc><Esc> <C-u>:noh<CR>
"noremap j gj
"noremap k gk
" as gedit
" vnoremap <h> vh
" vnoremap <j> vj
" vnoremap <k> vk
" vnoremap <l> vl
" vnoremap <C-c> y
" nnoremap <C-v> p
" vnoremap <C-x> yx
" nnoremap <C-k> dd
" nnoremap <C-z> u
" nnoremap <C-S-z> r
" noremap <C-w> :wq<Return>
" noremap! <C-w> <ESC>:wq<Return>

"noremap <C-S-w> :q!<Return>
"noremap! <C-S-w> <ESC>:q!<Return>
"inoremap <ESC> <ESC>
" insert auto rr
"noremap <CR> i<CR><ESC>
"noremap <BS> a<BS><ESC>
"noremap <SPACE> a<SPACE><ESC>
"noremap r <C-r>
"nnoremap == gg=G''
"nnoremap n  :NERDTree
"nnoremap v  :vs:VimShell
syntax enable

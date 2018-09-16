let g:go_version_warning = 0
set nocompatible
set encoding=utf-8
set nobackup
set number
set title
"backspace
set backspace=start,eol,indent
" indent when wrap
"set breakindent
"mouse
set mouse=a
"no preview
set completeopt=menuone
"選択行を強調する
set cursorline
" always show status bar
set laststatus=2
" remove vim mode information
set noshowmode
"括弧の対応
set showmatch
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

"--------tab--------
"tabをspaceにするなど
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
"tab空白表示
set list
set listchars=tab:>-,trail:_
"自動インデント
set autoindent
set cindent
" trim space
autocmd BufWritePre * :%s/\s\+$//ge
" Change tabwidth by file type
au FileType python,java,scala,groovy
  \ setlocal tabstop=4 shiftwidth=4 softtabstop=4

"-------Search--------
"インクリメンタルサーチを有効にする
set incsearch
"大文字小文字を区別しない
set ignorecase
"大文字で検索されたら対象を大文字限定にする
set smartcase
"行末まで検索したら行頭に戻る
set wrapscan
"検索をハイライト
set hlsearch
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
"検索やコマンドの履歴
set history=50
"補完設定
set wildmode=longest,list,full
set pastetoggle=<C-k>

" keymap
" C-f to esc
inoremap <C-f> <Esc>
vnoremap <C-f> <Esc>
nnoremap <C-f> <Nop>
" C-a,C-e -> general mode
nnoremap <C-a> ^
nnoremap <C-e> $
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>
nnoremap <C-l> $
nnoremap <C-h> ^
nnoremap q <Nop>
nnoremap ; :
nnoremap <Space> za
" :a! で ペーストするとインデントなし

"augroup local
"  au!
"  au OptionSet paste call lightline#update()
"augroup END


" plug
call plug#begin('~/.vim/plugged')
Plug 'Raimondi/delimitMate'
Plug 'croaker/mustang-vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-cursorword'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'nanotech/jellybeans.vim'
Plug 'fatih/vim-go'
if v:version > 702
  Plug 'itchyny/lightline.vim'
endif
if has('lua')
  Plug 'Shougo/neocomplete'
  Plug 'Shougo/unite.vim'
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
endif
" langs
Plug 'chr4/nginx.vim'
" Plug 'rust-lang/rust.vim'
call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

filetype plugin indent on

"neocomplete
if has('lua')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplcache_enable_smart_case = 2
  let g:neocomplcache_min_syntax_length = 3
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  " unite
  let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable =1
  " unite prefix
  nmap <C-u> [unite]
  nnoremap <silent> [unite]f :<C-u>call <SID>UniteFileRec()<CR>
  nnoremap <silent> [unite]g :<C-u>call <SID>UniteGrep()<CR>
  nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>

  function! s:UniteFileRec()
    if fugitive#extract_git_dir('.') !=# ''
      Unite file_rec/git
    else
      Unite file_rec/async
    endif
  endfunction

  function! s:UniteGrep()
    if fugitive#extract_git_dir('.') !=# ''
      Unite grep/git
    else
      Unite grep
    endif
  endfunction
endif

"gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" folding
function! MyFoldText()
  let line = getline(v:foldstart)
  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')
  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldmethod=indent
set foldtext=MyFoldText()
hi Folded gui=bold term=standout ctermbg=LightGrey ctermfg=DarkBlue guibg=Grey30 guifg=Grey80
hi FoldColumn gui=bold term=standout ctermbg=LightGrey ctermfg=DarkBlue guibg=Grey guifg=DarkBlue
set foldlevel=20

" keymaps
let g:keymaps =  [
      \  {
      \    'name': 'PASTE',
      \    'paste': 1
      \  },
      \]

 " lightline
let g:lightline = {
      \ 'component': {
      \   'total_lines': '%L',
      \ },
      \ 'component_function': {
      \   'git_path': 'GitRelativePath',
      \   'keymap': 'keymaps#get_current_keymap_name',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'keymap' ], [ 'git_path' ], [] ],
      \   'right': [ [], [], [ 'fileformat', 'fileencoding', 'filetype', 'total_lines' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [], [ 'git_path' ], [] ],
      \   'right': [ [], [], [ 'fileformat', 'fileencoding', 'filetype', 'total_lines' ] ],
      \ },
      \}

let g:rustfmt_autosave = 1

function! GitRelativePath()
  let head = &modified ? '* ' : (&modifiable && !&readonly)? '' : '- '
  try
    let git_work_tree = fugitive#repo().tree()
    let rel_path = substitute(expand('%:p'), l:git_work_tree.'/', "G:", "")
  catch
    let rel_path = expand('%:~')
  endtry
  let max_len = winwidth(0) - 45 - strlen(head)
  if strlen(rel_path) > max_len
    return head.'<'.rel_path[-max_len:]
  else
    return head.rel_path
  endif
endfunction

"colorscheme
colorscheme jellybeans
if &term =~ "xterm-256color" || "screen-256color"
    set t_Co=256
    set t_Sf=[3%dm
    set t_Sb=[4%dm
elseif &term =~ "xterm-color"
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
endif
let g:rehash256 = 1
syntax enable
hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c

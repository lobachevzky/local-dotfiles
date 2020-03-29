scriptencoding utf-8
set encoding=utf-8
filetype plugin indent on

"{{{ au FileType
augroup filetypes
  autocmd!
  au FileType vim set foldmethod=marker
  au FileType python set foldmethod=indent
  au FileType markdown setlocal spell
  au FileType markdown nnoremap k gk
  au FileType markdown nnoremap j gj
  au FileType markdown nnoremap gk k
  au FileType markdown nnoremap gj j
  au FileType julius set syntax=javascript
  au FileType hamlet set syntax=html
  au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
  au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
  au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>
  au BufRead,BufNewFile *.mjcf setfiletype xml
  au BufRead,BufNewFile *.toml setfiletype dosini
  au BufRead,BufNewFile *.tsx setfiletype typescript
  autocmd BufNewFile,BufRead .pyre_configuration set syntax=json
augroup END
"}}}

"{{{ let
let mapleader = " "
let $PATH = '/usr/bin:' . $PATH . ':' . '$HOME/.local/bin/'
"let g:syntastic_check_on_open=1
"let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = ' -std=c++14 -stdlib=libc++'
"let g:syntastic_python_checkers = ['flake8']
"let g:syntastic_haskell_checkers = ['hlint', 'hdevtools']

" neovim
let g:python_host_prog  = '/Users/ethan/virtualenvs/neovim2/bin/python'
let g:python3_host_prog  = '/Users/ethan/virtualenvs/neovim/bin/python'

" When the type of shell script is /bin/sh, assume a POSIX-ck wompatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

let g:vimtex_compiler_latexmk = {'build_dir': 'build', 'options' : ['-shell-escape']}
let g:tex_flavor='latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'skim'
let g:vimtex_view_method = 'skim'
let g:vimtex_fold_enabled = 1


let g:ale_fixers = {'python': ['black'], 'markdown': ['prettier'], 'tex': ['latexindent'], 'yaml': ['yapf'], 'ocaml': ['ocamlformat'], 'javascript': ['prettier'], 'haskell': ['brittany', 'hlint'], 'rust': ['rustfmt'], 'typescript': ['prettier'], 'json': ['prettier'], 'html': ['prettier'], 'css': ['prettier'] }
let g:ale_linters = {'python': ['pylint', 'pyls'], 'tex': ['lacheck'], 'ocaml': ['merlin'], 'haskell': ['stack-ghc'], 'css': ['prettier']}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_python_pyls_auto_pipenv = 1
let g:ale_rust_rls_toolchain = 'stable'

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

let g:python_highlight_all = 1
"let g:pymode_options_max_line_length = 90
"let g:pymode_python = 'python3'
"let g:pymode_rope = 1
"let g:pymode_rope_autoimport=1
"}}}
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ }
      \ }

"{{{ nnoremap
nnoremap <leader>w :w<CR>
nnoremap <C-w> :close<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <F4> :Autoformat<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"execute this file
"nnoremap <C-x> :execute "!./" . expand('%:t')<CR>

"execute last command
nnoremap <leader>x :<up><CR>

"save
nnoremap <leader>w :w<CR>

" fzf
nnoremap <C-p> :Files<CR>

" break
nnoremap <leader>b Oimport ipdb; ipdb.set_trace()<ESC>

nnoremap <leader>k :ALEPrevious<CR>
nnoremap <leader>j :ALENext<CR>
"}}}

"{{{ plug
call plug#begin('~/.vim/bundle')
if filereadable(expand("~/.config/nvim/bundles.vim"))
  source ~/.config/nvim/bundles.vim
endif
call plug#end()
"}}}

"{{{ set
set shell=/usr/local/bin/zsh

set t_Co=256
set guifont="Droid Sans Mono":h14

set noswapfile
set incsearch     " incremental searching
set autowrite     " :write before leaving file
set background=dark
set tabstop=2 " show existing tab with 2 spaces width
set shiftwidth=2 " when indenting with '>', use 2 spaces width
set textwidth=80
set expandtab " On pressing tab, insert 2 spaces
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
set number
set numberwidth=1
set complete+=kspell " Autocomplete with dictionary words when spell check is on
set cursorline
set wildmenu
set lazyredraw  " maybe faster with macros
set mouse=a

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
"}}}

"{{{ Use The Silver Searcher for CtrlP
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep!  <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif
"}}}

"{{{ command!
"easy source virmc
command! Sovim source $MYVIMRC
"easy update plugins
command! Replug source $MYVIMRC | PlugUpgrade | PlugClean | PlugInstall
"delete trailing whitespace
command! Despace %s/\s\+\n/\r/g
"}}}

"{{{ Hashbang
function! Hashbang(portable, permission, RemExt)
  let shells = {
        \    'awk': "awk",
        \     'sh': "bash",
        \     'hs': "stack",
        \     'jl': "julia",
        \    'lua': "lua",
        \    'mak': "make",
        \     'js': "node",
        \      'm': "octave",
        \     'pl': "perl",
        \    'php': "php",
        \     'py': "python",
        \      'r': "Rscript",
        \     'rb': "ruby",
        \  'scala': "scala",
        \    'tcl': "tclsh",
        \     'tk': "wish",
        \  'swift': "swift"
        \    }

  let extension = expand("%:e")

  if has_key(shells,extension)
    let fileshell = shells[extension]

    if a:portable
      let line =  "#! /usr/bin/env " . fileshell
    else
      let line = "#! " . system("which " . fileshell)
    endif

    0put = line

    if a:permission
      :autocmd BufWritePost * :autocmd VimLeave * :!chmod u+x %
    endif


    if a:RemExt
      :autocmd BufWritePost * :autocmd VimLeave * :!mv % "%:p:r"
    endif

  endif

endfunction

autocmd BufRead,BufNewFile ~/dotfiles/*/config setfiletype dosini
autocmd BufNewFile * :call Hashbang(1,0,0)
"}}}

colorscheme gruvbox
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line

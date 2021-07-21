if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"
" load plugins
"

call plug#begin('~/.vim/plugged')

Plug 'DavidEGx/ctrlp-smarttabs'
Plug 'antiagainst/vim-tablegen'
Plug 'benekastah/neomake'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'easymotion/vim-easymotion'
Plug 'freeo/vim-kalisi'
Plug 'godlygeek/tabular'
Plug 'justmao945/vim-clang'
Plug 'leissa/vim-acme'
Plug 'lervag/vimtex'
Plug 'machakann/vim-swap'
Plug 'majutsushi/tagbar'
Plug 'mrtazz/DoxygenToolkit.vim'
Plug 'rhysd/vim-grammarous'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wincent/ferret'

call plug#end()

"
" standard options
"

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set nojoinspaces
set nostartofline
set nottimeout
set showcmd
set switchbuf+=usetab,newtab
"set spell
"set spelllang=en
"set spelllang=en,de
set textwidth=0
set wildignore=*.acn,*.aux,*.backup,*.bak,*.bbl,*.bcf,*.blg,*.class,*.d,*.dll,*.dvi,*.exe,*.fdb_latexmk,*.fls,*.fls,
              \*.idx,*.ilg,*.ind,*.ist,*.jpg,*.jpeg,*.loa,*.lof,*.lot,*.nav,*.o,*.obj,*.pdf,*.png,*.pyc,*.run.xml,
              \*.snm,*.synctex.gz,*.so,tags,*.tdo,*.tga,*.toc,*.vrb
set wildmode=list:longest,full
"set conceallevel=0

" colors
set background=dark
let g:kalisi_recolor_quickfixsigns = 1
let g:load_doxygen_syntax=1
colorscheme kalisi
hi Normal  ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi MatchParen ctermbg=58 ctermfg=118 guibg=#5a5a00 guifg=#8fca24

" completion
autocmd CompleteDone * pclose " automatically close preview window
set completeopt=menu,menuone,longest,preview

" indentation rules
set expandtab
set autoindent
set smartindent
set shiftround
set ts=4
set softtabstop=4
set shiftwidth=4

" scrolling
set linebreak
set scrolloff=3
set sidescroll=10
set nowrap

" search
set hlsearch
set incsearch
set ignorecase
set smartcase
if maparg('<C-L>', 'n') ==# ''      " Use <C-L> to clear the highlighting of :set hlsearch.
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

"
" maps/autocmd
"

" leaders
let mapleader=","
let maplocalleader=" "

" ctags
"nmap ,t :tab tjump <C-R>=expand("<cword>")<CR><CR>
nmap ,g     :tjump <C-R>=expand("<cword>")<CR><CR>
com Ctags !ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++
com CCtags !ctags -R --sort=yes --fields=+iaS --extra=+q

" make
noremap <F11> :make! -j `$(nproc)`<CR>
noremap <S-F11> :make!<CR>

" remove trailing whitespaces
autocmd FileType acme,asm,bib,c,cpp,impala,java,markdown,inc,php,python,s,tex,yml autocmd BufWritePre <buffer> :%s/\s\+$//e

" other
map Y y$
map Ä :vimgrep//gj **/*.{cpp,h}<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
map Q @q
cabbrev h tab help
cabbrev help tab help

" builtin macros
runtime macros/matchit.vim
runtime macros/shellmenu.vim

"
" setup plugins
"

let g:airline_powerline_fonts = 1

"let g:powerline_pycmd="py3"
"
"set autowrite
"set confirm
"set hidden
"set laststatus=2
"let g:powerline_pycmd="py3"
"nmap <leader>x :tabclose<CR>  |" close buffer

"nmap <leader>x :bn <BAR> bd #<CR>  |" close buffer
"nmap <leader>wx :w<CR>:bn <BAR> bd #<CR>  |" close buffer

" CtrlP

let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_open_multiple_files = 't'       " open in a new tab
let g:ctrlp_open_new_file = 't'             " open in a new tab
let g:ctrlp_regexp = 1
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|build)$',
    \ 'file': '\v\.(exe|so|dll|class|png|prg|jpg|jpeg)$',
\ }
let g:ctrlp_extensions = ['smarttabs']

nmap <leader>pb :CtrlPBuffer<CR>
nmap <leader>pc :CtrlPChangeAll<CR>
nmap <leader>pl :CtrlPLine<CR>
nmap <leader>pm :CtrlPMixed<CR>
nmap <leader>pr :CtrlPMRU<CR>
nmap <leader>pt :CtrlPTag<CR>

" clang
let g:clang_auto = 0
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=gnu++2a'
let g:clang_diagsopt = ''   " <- disable diagnostics
let g:clang_exec = '/usr/bin/clang'
let g:clang_format_exec = '/usr/bin/clang-format'
let g:clang_pwheight = 8
let g:clang_sh_exec = 'bash'
let g:clang_verbose_pmenu = 1
let g:clang_vim_exec = 'vim'

" easymotion
map  <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)
"nmap <Leader>s <Plug>(easymotion-overwin-f2)
map  <Leader>l <Plug>(easymotion-bd-jk)
"nmap <Leader>l <Plug>(easymotion-overwin-line)
map  <Leader>w <Plug>(easymotion-bd-w)
"nmap <Leader>w <Plug>(easymotion-overwin-w)

" fswitch
nmap <silent> ö :FSSplitRight<CR>           |" Switch to the file and load it into a new window split on the right
"nmap <silent> <Leader>ol :FSSplitRight<CR>  |" Switch to the file and load it into a new window split on the right
"nmap <silent> <Leader>oh :FSSplitLeft<CR>   |" Switch to the file and load it into a new window split on the left

"
augroup filetype
    au! BufRead,BufNewFile *.td set filetype=tablegen
    au! BufRead,BufNewFile *.ll set filetype=llvm
augroup END

" NERDTree
nnoremap <silent> <F10> :NERDTreeToggle<CR>
let NERDTreeRespectWildIgnore = 1

" tagbar
map <silent> <F9> :TagbarToggle<CR>
"let g:tagbar_left = 1
"let g:tagbar_autoclose = 1
"let g:tagbar_autofocus = 1
let g:tagbar_width=60

" tex
let g:tex_flavor='latex'
"let g:vimtex_index_show_help = 0
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

"
" include custom settings - do this last
"

if filereadable(".project.vim")
    source .project.vim
endif

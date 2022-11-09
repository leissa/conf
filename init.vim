if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:FerretMap = 0 " don't import standard ferret mappings


"
" load plugins
"

call plug#begin('~/.vim/plugged')

Plug 'AnyDSL/vim-thorin2'
Plug 'DavidEGx/ctrlp-smarttabs'
Plug 'antiagainst/vim-tablegen'
Plug 'benekastah/neomake'
Plug 'condy0919/docom.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'easymotion/vim-easymotion'
Plug 'fneu/breezy'
Plug 'godlygeek/tabular'
Plug 'joshdick/onedark.vim'
Plug 'justmao945/vim-clang'
Plug 'leissa/vim-acme'
Plug 'lervag/vimtex'
Plug 'machakann/vim-swap'
Plug 'majutsushi/tagbar'
Plug 'morhetz/gruvbox'
Plug 'mrtazz/DoxygenToolkit.vim'
Plug 'preservim/vim-markdown'
Plug 'rhysd/vim-grammarous'
Plug 'rust-lang/rust.vim'
Plug 'sakhnik/nvim-gdb'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/indentpython.vim'
Plug 'wincent/ferret'
"Plug 'Valloric/YouCompleteMe'

call plug#end()

"
" standard options
"

set encoding=utf-8
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
set diffopt=internal,filler,closeoff,vertical

"set conceallevel=0

" colors
set background=light
set termguicolors
let python_highlight_all=1
colorscheme breezy
" transparent bg
hi Normal guibg=NONE guifg=#cfcfc2 gui=NONE

" completion
autocmd CompleteDone * pclose " automatically close preview window
set completeopt=menu,menuone,longest,noinsert

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

set autowrite
set confirm
set hidden
set laststatus=2

" leaders
let mapleader=","
let maplocalleader=" "

nmap <leader>x :tabclose<CR>  |" close buffer
"nmap <leader>x :bn <BAR> bd #<CR>  |" close buffer
nmap <leader>wx :w<CR>:bn <BAR> bd #<CR>  |" close buffer
" don't annoy me with ex mode
map q: <Nop> 

" make
noremap <F11> :make! -j $(nproc)<CR>
noremap <S-F11> :make!<CR>

" remove trailing whitespaces
autocmd FileType acme,asm,bib,c,cpp,cmake,impala,java,markdown,inc,php,python,s,tex,yml autocmd BufWritePre <buffer> :%s/\s\+$//e

" other
map Y y$
map Ä :vimgrep//gj **/*.{cpp,h}<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
map Q @q
cabbrev h tab help
cabbrev help tab help

"augroup filetype
    "au! BufRead,BufNewFile *.td set filetype=tablegen
    "au! BufRead,BufNewFile *.ll set filetype=llvm
"augroup END

" builtin macros
runtime macros/matchit.vim
runtime macros/shellmenu.vim

"
" setup plugins
"

" airline

let g:airline_powerline_fonts = 1
"let g:airline#extensions#whitespace#mixed_indent_algo = 1
"let g:airline_theme='powerlineish'
"let g:airline_theme='gruvbox'
"let g:airline_theme='onedark'
let g:airline_theme='breezy'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " just show tab number

let g:airline#extensions#tmuxline#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = ' ㏇:'

"
" clang
"

"let g:clang_auto = 0
let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=gnu++20'
let g:clang_diagsopt = ''   " <- disable diagnostics
let g:clang_exec = '/usr/bin/clang'
let g:clang_format_exec = '/usr/bin/clang-format'
let g:clang_pwheight = 8
let g:clang_sh_exec = 'bash'
let g:clang_verbose_pmenu = 0
let g:clang_vim_exec = 'nvim'
let g:clang_c_completeopt = 'menu,menuone,longest,noinsert,preview'
let g:clang_cpp_completeopt = 'menu,menuone,longest,noinsert,preview'

"if has('python')
    "map <C-I> :pyf /usr/share/clang/clang-format.py<cr>
    "imap <C-I> <c-o>:pyf /usr/share/clang/clang-format.py<cr>
"elseif has('python3')
    map <C-K> :py3f /usr/share/clang/clang-format.py<CR>
    "imap <C-I> <c-o>:py3f /usr/share/clang/clang-format.py<cr>
    "imap <C-I> <c-o>:py3f /usr/share/clang/clang-format.py<cr>
"endif

"
" ctrlp
"

let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_open_multiple_files = 't'       " open in a new tab
let g:ctrlp_open_new_file = 't'             " open in a new tab
let g:ctrlp_regexp = 1
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_tabpage_position = 'cl'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|build|modules|html)$',
    \ 'file': '\v\.(exe|so|dll|class|png|prg|jpg|jpeg|ll)$',
\ }

" open in new tab instead of buffer
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }
let g:ctrlp_max_files = 100000

"nmap <leader>pb :CtrlPBuffer<CR>
"nmap <leader>pc :CtrlPChangeAll<CR>
"nmap <leader>pl :CtrlPLine<CR>
"nmap <leader>pm :CtrlPMixed<CR>
"nmap <leader>pr :CtrlPMRU<CR>
"nmap <leader>pt :CtrlPTag<CR>

let g:ctrlp_extensions = ['smarttabs']
" Altgr+p to open SmartTabs
nnoremap þ :CtrlPSmartTabs<CR> 

"
" easymotion
"

"map  <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)
"nmap <Leader>s <Plug>(easymotion-overwin-f2)
map  <Leader><Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader><Leader>l <Plug>(easymotion-overwin-line)
"map  <Leader>w <Plug>(easymotion-bd-w)
"nmap <Leader>w <Plug>(easymotion-overwin-w)

"
" fswitch
"

nmap <silent> ö :FSSplitRight<CR>           |" Switch to the file and load it into a new window split on the right
"nmap <silent> <Leader>ol :FSSplitRight<CR>  |" Switch to the file and load it into a new window split on the right
"nmap <silent> <Leader>oh :FSSplitLeft<CR>   |" Switch to the file and load it into a new window split on the left

" markdown

" nvim-gdb
let g:nvimgdb_config_override = {
    \ 'key_next': '<Leader>dn',
    \ 'key_step': '<Leader>ds',
    \ 'key_finish': '<Leader>df',
    \ 'key_continue': '<Leader>dc',
    \ 'key_until': '<Leader>du',
    \ 'key_breakpoint': '<Leader>db',
    \ 'set_keymaps':    'function("lua", "NvimGdb.i().keymaps.set()")',
    \ 'unset_keymaps':  'function("lua", "NvimGdb.i().keymaps.unset()")',
    \ }

"\ 'set_tkeymaps':   'function("lua", "NvimGdb.i().keymaps:set_t()")',
let g:nvimgdb_use_find_executables = 1
let g:nvimgdb_use_cmake_to_find_executables = 0

" markdown

let g:vim_markdown_folding_disabled = 1

" NERDTree

nnoremap <silent> <F10> :NERDTreeToggle<CR>
let NERDTreeRespectWildIgnore = 1

" tagbar

map <silent> <F9> :TagbarToggle<CR>
"let g:tagbar_left = 1
"let g:tagbar_autoclose = 1
"let g:tagbar_autofocus = 1
let g:tagbar_width=60

" Tabularize

function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar>\zs<CR>
vmap <Leader>a<Bar> :Tabularize /<Bar>\zs<CR>

"autocmd FileType markdown inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" tex

"let g:vimtex_index_show_help = 0
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
"let g:vimtex_quickfix_open_on_warning = 0
" Disable custom warnings based on regexp
let g:vimtex_quickfix_ignore_filters = [ 'Marginpar on page', 'Overfull']


" include custom settings - do this last

if filereadable(".project.vim")
    source .project.vim
endif

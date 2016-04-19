"
" load plugins
"

call plug#begin('~/.vim/plugged')

Plug 'benekastah/neomake'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'easymotion/vim-easymotion'
Plug 'freeo/vim-kalisi'
Plug 'godlygeek/tabular'
Plug 'justmao945/vim-clang'
Plug 'lervag/vimtex'
Plug 'majutsushi/tagbar'
Plug 'mrtazz/DoxygenToolkit.vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/swap-parameters'

call plug#end()

"
" standard options
"

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set nostartofline
set nottimeout
set showcmd
"set spell
"set spelllang=en
"set spelllang=en,de
set textwidth=0
set wildignore=*.acn,*.aux,*.backup,*.bak,*.bbl,*.bcf,*.blg,*.class,*.dll,*.dvi,*.exe,*.fdb_latexmk,*.fls,*.fls,
              \*.idx,*.ilg,*.ind,*.ist,*.jpg,*.jpeg,*.loa,*.lof,*.lot,*.nav,*.o,*.obj,*.pdf,*.png,*.run.xml,
              \*.snm,*.synctex.gz,*.so,tags,*.tdo,*.tga,*.toc,*.vrb
set wildmode=list:longest,full
"set conceallevel=0

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

" colors
set background=dark
let g:kalisi_recolor_quickfixsigns = 1
let g:load_doxygen_syntax=1
colorscheme kalisi
hi Normal  ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi MatchParen ctermbg=58 ctermfg=118 guibg=#5a5a00 guifg=#8fca24

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
noremap <F11> :make! -j`cat /proc/cpuinfo \\| grep processor \\| echo \`wc -l\` + 1 \\| bc`<CR>
noremap <S-F11> :make!<CR>

" remove trailing whitespaces
autocmd FileType c,cpp,java,php,tex autocmd BufWritePre <buffer> :%s/\s\+$//e

" other
map Y y$
map Ä :vimgrep//gj **/*.{cpp,h}<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
"cabbrev help tab help

"
" setup plugins
"

" airline/tabline
set autowrite
set confirm
set hidden
set laststatus=2
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ctrlp#show_adjacent_modes = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1
nmap <leader>x :bn <BAR> bd #<CR>  |" close buffer
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" CtrlP

let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_open_multiple_files = 'i'
let g:ctrlp_regexp = 0
let g:ctrlp_root_markers = ['.project.vim']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
nmap <leader>pb :CtrlPBuffer<CR>
nmap <leader>pc :CtrlPChangeAll<CR>
nmap <leader>pl :CtrlPLine<CR>
nmap <leader>pm :CtrlPMixed<CR>
nmap <leader>pr :CtrlPMRU<CR>
nmap <leader>pt :CtrlPTag<CR>

" clang
let g:clang_c_options = '-std=c99'
let g:clang_cpp_options = '-std=c++11'
let g:clang_pwheight = 8
let g:clang_verbose_pmenu = 1
let g:clang_vim_exex = 'nvim'

" easymotion
map  <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)
"nmap <Leader>s <Plug>(easymotion-overwin-f2)
map  <Leader>l <Plug>(easymotion-bd-jk)
"nmap <Leader>l <Plug>(easymotion-overwin-line)
map  <Leader>w <Plug>(easymotion-bd-w)
"nmap <Leader>w <Plug>(easymotion-overwin-w)

" fswitch
nmap <silent> <Leader>of :FSHere<CR>        |" Switch to the file and load it into the current window
nmap <silent> <Leader>ol :FSSplitRight<CR>  |" Switch to the file and load it into a new window split on the right
nmap <silent> <Leader>oh :FSSplitLeft<CR>   |" Switch to the file and load it into a new window split on the left

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
"let g:vimtex_indent_bib_enabled = 0
"let g:vimtex_indent_enabled = 0
let g:vimtex_index_show_help = 0
let g:vimtex_index_split_width = 60
let g:vimtex_latexmk_progname =  'nvr'
let g:vimtex_quickfix_ignore_all_warnings = 1
let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_quickfix_ignored_warnings = [
    \ 'Underfull',
    \ 'Overfull',
    \ 'specifier changed to',
    \ ]

"
" include custom settings - do this last
"

if filereadable(".project.vim")
    source .project.vim
endif

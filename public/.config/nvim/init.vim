set timeoutlen=1000 ttimeoutlen=0
"set mouse=a
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'LukeSmithxyz/vimling'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vifm/vifm.vim'
Plug 'mattn/emmet-vim'
Plug 'mcchrish/nnn.vim'
Plug 'sebdah/vim-delve'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'b0o/builder.vim'
Plug 'b0o/quicktemplate.vim'
Plug 'vim-scripts/rcshell.vim'
Plug 'dansomething/vim-eclim'
Plug 'skywind3000/asyncrun.vim'
"Plug 'conornewton/vim-latex-preview'
Plug 'kien/ctrlp.vim'
Plug 'moorereason/vim-markdownfmt'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'idanarye/vim-vebugger'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'rhysd/vim-clang-format'
Plug 'dylanaraps/wal.vim'
call plug#end()

colorscheme wal

let fortran_free_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1

let g:latex_pdf_viewer="zathura"
let g:latex_engine="xelatex"
let g:markdownfmt_command="mdfmt"
"let g:markdownfmt_autosave=1
let g:clang_format#detect_style_file=1
let g:clang_format#auto_format=1

autocmd FileType java setlocal omnifunc=javacomplete#Complete


